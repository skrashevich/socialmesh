// SPDX-License-Identifier: GPL-3.0-or-later
import 'dart:async';
import 'dart:convert';

import '../../../core/logging.dart';
import '../../../services/protocol/admin_target.dart';
import '../../../services/protocol/protocol_service.dart';
import '../diagnostics/services/diagnostic_capture_service.dart';
import 'conformance_models.dart';

/// Context for a conformance test run.
///
/// Provides access to the protocol service, admin target, packet
/// capture, provider state recording, and test configuration.
///
/// All test cases receive this context — they must NOT access
/// ProtocolService directly except through the adapters.
class ConformanceContext {
  final ProtocolService protocolService;
  final AdminTarget target;
  final int myNodeNum;
  final String runId;
  final DiagnosticCaptureService packetCapture;
  final Duration timeout;
  final int maxRetries;
  final bool destructiveMode;

  /// Provider state snapshot sink — append-only NDJSON.
  final List<ProviderStateSnapshot> _stateSnapshots = [];

  /// Event notes collected during the run.
  final List<String> _notes = [];

  ConformanceContext({
    required this.protocolService,
    required this.target,
    required this.myNodeNum,
    required this.runId,
    required this.packetCapture,
    this.timeout = const Duration(seconds: 8),
    this.maxRetries = 1,
    this.destructiveMode = false,
  });

  /// Whether the device is currently connected at the BLE transport level.
  bool get isConnected => protocolService.isConnected;

  /// Whether the device is connected AND the protocol service has completed
  /// its config exchange — the device is ready to accept admin requests.
  bool get isReady => isConnected && _isProtocolReady;

  /// Node number of the target being tested.
  int get targetNodeNum => target.resolve(myNodeNum);

  /// Whether operating on the local device.
  bool get isLocal => target.isLocal;

  /// All captured provider state snapshots.
  List<ProviderStateSnapshot> get stateSnapshots =>
      List.unmodifiable(_stateSnapshots);

  /// All collected notes.
  List<String> get notes => List.unmodifiable(_notes);

  /// Record a provider state snapshot.
  void recordState({
    required String providerName,
    required String testCaseName,
    required String phase,
    Map<String, dynamic>? serializedState,
    String? error,
  }) {
    final snapshot = ProviderStateSnapshot(
      providerName: providerName,
      testCaseName: testCaseName,
      phase: phase,
      timestamp: DateTime.now().millisecondsSinceEpoch,
      serializedState: serializedState,
      error: error,
    );
    _stateSnapshots.add(snapshot);
    AppLogging.adminDiag(
      'State snapshot: $providerName [$phase] for $testCaseName',
    );
  }

  /// Add a note about the run.
  void addNote(String note) {
    _notes.add(note);
    AppLogging.adminDiag('Note: $note');
  }

  /// Export provider state snapshots as NDJSON.
  String stateSnapshotsToNdjson() =>
      _stateSnapshots.map((s) => s.toNdjsonLine()).join('\n');

  /// Wait for a stream emission matching [predicate] within [timeout].
  ///
  /// Returns the matched value or throws [TimeoutException].
  Future<T> waitForStream<T>(
    Stream<T> stream,
    bool Function(T) predicate, {
    Duration? overrideTimeout,
  }) {
    final completer = Completer<T>();
    late StreamSubscription<T> sub;
    sub = stream.listen((event) {
      if (predicate(event) && !completer.isCompleted) {
        completer.complete(event);
        sub.cancel();
      }
    });

    return completer.future.timeout(overrideTimeout ?? timeout).whenComplete(
      () {
        if (!completer.isCompleted) sub.cancel();
      },
    );
  }

  /// Wait for the device to reconnect after a disconnect.
  ///
  /// Polls [isConnected] every [pollInterval] up to [maxWait].
  /// Once BLE reports connected, waits for the protocol service to
  /// complete its config exchange (`configurationComplete` + `myNodeNum`
  /// set), which is the authoritative signal that the device firmware
  /// is ready to accept admin requests.
  /// Returns `true` if reconnected and responsive, `false` if timed out.
  Future<bool> awaitReconnection({
    Duration maxWait = const Duration(seconds: 60),
    Duration pollInterval = const Duration(milliseconds: 500),
  }) async {
    // Fast path — already fully connected and configured
    if (isConnected && _isProtocolReady) {
      AppLogging.adminDiag('Device already connected and protocol ready');
      return true;
    }

    AppLogging.adminDiag('Device disconnected — waiting for reconnection...');
    final deadline = DateTime.now().add(maxWait);

    // Phase 1: Wait for BLE transport to reconnect
    while (DateTime.now().isBefore(deadline)) {
      await Future<void>.delayed(pollInterval);
      if (isConnected) {
        AppLogging.adminDiag('BLE reconnected — waiting for protocol init...');
        break;
      }
    }

    if (!isConnected) {
      AppLogging.adminDiag(
        'Reconnection timed out (BLE) after ${maxWait.inSeconds}s',
      );
      return false;
    }

    // Phase 2: Wait for protocol.start() to complete config exchange.
    // After BLE reconnects, the auto-reconnect manager calls protocol.start()
    // which clears _myNodeNum, re-subscribes to the transport data stream,
    // re-enables BLE notifications, and does a full config exchange. Only
    // when configurationComplete is true is the data pipeline active and
    // admin requests will actually get responses.
    while (DateTime.now().isBefore(deadline)) {
      if (_isProtocolReady) {
        AppLogging.adminDiag(
          'Protocol re-initialized — '
          'myNodeNum=${protocolService.myNodeNum}, configComplete=true',
        );
        // Brief settle for any remaining firmware init
        await Future<void>.delayed(const Duration(seconds: 2));
        AppLogging.adminDiag('Device reconnected and firmware responsive');
        return true;
      }
      await Future<void>.delayed(pollInterval);
    }

    AppLogging.adminDiag(
      'Reconnection timed out (protocol init) after ${maxWait.inSeconds}s '
      '— isConnected=$isConnected, '
      'configComplete=${protocolService.configurationComplete}, '
      'myNodeNum=${protocolService.myNodeNum}',
    );
    return false;
  }

  /// Whether the protocol service has completed its config exchange
  /// and is ready to accept admin requests.
  bool get _isProtocolReady =>
      protocolService.configurationComplete &&
      protocolService.myNodeNum != null;

  /// Serialize a protobuf message to JSON for state capture.
  Map<String, dynamic>? serializeProtobuf(dynamic proto) {
    if (proto == null) return null;
    try {
      return jsonDecode(jsonEncode(proto.toProto3Json()))
          as Map<String, dynamic>;
    } catch (_) {
      return {'_raw': proto.toString()};
    }
  }
}
