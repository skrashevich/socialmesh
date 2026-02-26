// SPDX-License-Identifier: GPL-3.0-or-later
import 'dart:async';
import 'dart:convert';

import '../../../core/logging.dart';
import '../../../generated/meshtastic/admin.pb.dart' as admin;
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

  /// Wait for the device to reconnect after a disconnect or reboot.
  ///
  /// Uses an end-to-end probe strategy that does NOT trust
  /// `configurationComplete` or `myNodeNum` — these can be stale after an
  /// unexpected disconnect because `_handleDisconnect()` does not call
  /// `protocol.stop()`.
  ///
  /// Strategy:
  ///   1. Wait for BLE transport to reconnect (`isConnected`).
  ///   2. Brief settle delay for BLE services discovery.
  ///   3. Admin probe — send a real DEVICE_CONFIG request, wait for a
  ///      response on `deviceConfigStream`. This proves the full pipeline
  ///      (transport → BLE notifications → data subscription → protocol
  ///      handler → stream) is functional.
  ///   4. If the probe fails but BLE is still connected, force a protocol
  ///      restart (`stop()` + `start()`) to re-establish the data pipeline,
  ///      then re-probe with a **fresh** 30 s deadline (the initial probes
  ///      may have consumed the original deadline).
  ///
  /// Returns `true` if reconnected and responsive, `false` if timed out.
  Future<bool> awaitReconnection({
    Duration maxWait = const Duration(seconds: 60),
    Duration pollInterval = const Duration(milliseconds: 500),
  }) async {
    final startTime = DateTime.now();
    final deadline = startTime.add(maxWait);

    String elapsed() =>
        '${DateTime.now().difference(startTime).inMilliseconds}ms';

    AppLogging.adminDiag(
      'awaitReconnection [${elapsed()}]: START — '
      'isConnected=$isConnected, '
      'configComplete=${protocolService.configurationComplete}, '
      'myNodeNum=${protocolService.myNodeNum}',
    );

    // ── Phase 1: Wait for BLE transport ──
    if (!isConnected) {
      AppLogging.adminDiag(
        'Phase 1 [${elapsed()}]: BLE disconnected — polling for reconnect...',
      );
      while (DateTime.now().isBefore(deadline)) {
        await Future<void>.delayed(pollInterval);
        if (isConnected) break;
      }
      if (!isConnected) {
        AppLogging.adminDiag(
          'Phase 1 FAILED [${elapsed()}]: '
          'BLE did not reconnect within ${maxWait.inSeconds}s',
        );
        return false;
      }
      AppLogging.adminDiag('Phase 1 OK [${elapsed()}]: BLE reconnected');
    } else {
      AppLogging.adminDiag('Phase 1 OK [${elapsed()}]: BLE already connected');
    }

    // ── Phase 2: Settle delay ──
    // BLE reports connected before service discovery and the auto-reconnect
    // manager have finished. Give the stack time to stabilize.
    AppLogging.adminDiag(
      'Phase 2 [${elapsed()}]: Settling 3 s for BLE service discovery...',
    );
    await Future<void>.delayed(const Duration(seconds: 3));

    // ── Phase 3: Admin probe ──
    // Don't trust configurationComplete — it may be stale from a previous
    // connection. Send a real admin request and verify we get a response.
    AppLogging.adminDiag(
      'Phase 3 [${elapsed()}]: Probing admin pipeline — '
      'isConnected=$isConnected, '
      'configComplete=${protocolService.configurationComplete}, '
      'myNodeNum=${protocolService.myNodeNum}',
    );
    final probeOk = await _probeFirmwareReady(deadline);
    if (probeOk) {
      AppLogging.adminDiag(
        'Phase 3 OK [${elapsed()}]: Admin pipeline verified — done',
      );
      return true;
    }
    AppLogging.adminDiag(
      'Phase 3 FAILED [${elapsed()}]: All admin probes failed — '
      'isConnected=$isConnected, '
      'configComplete=${protocolService.configurationComplete}',
    );

    // ── Phase 4: Protocol restart fallback ──
    // The probe failed despite BLE being connected. This happens when the
    // auto-reconnect manager's stale guard in
    // _initializeProtocolAfterAutoReconnect() skips protocol.start() because
    // configurationComplete/myNodeNum are still set from the previous
    // session. Without start(), enableNotifications() is never called so the
    // fromNum BLE subscription is dead — no data flows to the protocol layer.
    //
    // Fix: force protocol.stop() (clears stale state, cancels old
    // subscriptions) + protocol.start() (re-subscribes to transport data
    // stream, re-enables BLE notifications, does full config exchange).
    //
    // Use a FRESH 30 s deadline — the initial probes may have consumed most
    // of the original budget, but the restart is the actual fix and deserves
    // its own time window.
    if (!isConnected) {
      AppLogging.adminDiag(
        'Phase 4 SKIPPED [${elapsed()}]: BLE disconnected during probing',
      );
      return false;
    }

    AppLogging.adminDiag(
      'Phase 4 [${elapsed()}]: Forcing protocol restart (stop + start)...',
    );
    final restartDeadline = DateTime.now().add(const Duration(seconds: 30));
    try {
      protocolService.stop();
      AppLogging.adminDiag(
        'Phase 4 [${elapsed()}]: stop() done — '
        'configComplete=${protocolService.configurationComplete}, '
        'myNodeNum=${protocolService.myNodeNum}',
      );
      await protocolService.start();
      AppLogging.adminDiag(
        'Phase 4 [${elapsed()}]: start() done — '
        'configComplete=${protocolService.configurationComplete}, '
        'myNodeNum=${protocolService.myNodeNum}',
      );
    } catch (e) {
      AppLogging.adminDiag(
        'Phase 4 FAILED [${elapsed()}]: Protocol restart threw: $e',
      );
      return false;
    }

    // protocol.start() awaits the full config exchange so
    // _isProtocolReady should be true. If not, poll briefly.
    if (!_isProtocolReady) {
      AppLogging.adminDiag(
        'Phase 4 [${elapsed()}]: Waiting for protocol ready...',
      );
      while (DateTime.now().isBefore(restartDeadline)) {
        if (_isProtocolReady) break;
        await Future<void>.delayed(pollInterval);
      }
    }
    if (!_isProtocolReady) {
      AppLogging.adminDiag(
        'Phase 4 FAILED [${elapsed()}]: Protocol not ready after restart — '
        'configComplete=${protocolService.configurationComplete}, '
        'myNodeNum=${protocolService.myNodeNum}',
      );
      return false;
    }

    // Re-probe with the fresh deadline to verify the pipeline end-to-end.
    AppLogging.adminDiag(
      'Phase 4 [${elapsed()}]: Protocol ready — re-probing admin pipeline...',
    );
    final retryOk = await _probeFirmwareReady(restartDeadline);
    if (retryOk) {
      AppLogging.adminDiag(
        'Phase 4 OK [${elapsed()}]: Admin pipeline verified after restart — done',
      );
      return true;
    }

    AppLogging.adminDiag(
      'awaitReconnection FAILED [${elapsed()}]: '
      'All recovery attempts exhausted — '
      'isConnected=$isConnected, '
      'configComplete=${protocolService.configurationComplete}, '
      'myNodeNum=${protocolService.myNodeNum}',
    );
    return false;
  }

  /// Probe the firmware admin handler by requesting DEVICE_CONFIG.
  ///
  /// Tries up to 3 times with 5-second timeouts (or until [deadline]).
  /// Each attempt logs transport state and categorizes failure (timeout
  /// vs "not connected" vs unexpected error) for diagnostics.
  ///
  /// Returns `true` if any attempt gets a response, proving the full
  /// admin pipeline (BLE → transport → data subscription → protocol
  /// handler → stream controller) is functional.
  Future<bool> _probeFirmwareReady(DateTime deadline) async {
    for (var attempt = 1; attempt <= 3; attempt++) {
      if (DateTime.now().isAfter(deadline)) {
        AppLogging.adminDiag('Probe $attempt/3: SKIPPED — deadline exceeded');
        return false;
      }

      AppLogging.adminDiag(
        'Probe $attempt/3: sending DEVICE_CONFIG — '
        'isConnected=$isConnected, '
        'configComplete=${protocolService.configurationComplete}',
      );

      try {
        final completer = Completer<bool>();
        final sub = protocolService.deviceConfigStream.listen((_) {
          if (!completer.isCompleted) completer.complete(true);
        });
        try {
          await protocolService.getConfig(
            admin.AdminMessage_ConfigType.DEVICE_CONFIG,
            target: target,
          );
          final ready = await completer.future.timeout(
            const Duration(seconds: 5),
          );
          if (ready) {
            AppLogging.adminDiag('Probe $attempt/3: PASS');
            return true;
          }
        } finally {
          await sub.cancel();
        }
      } on TimeoutException {
        AppLogging.adminDiag(
          'Probe $attempt/3: TIMEOUT — '
          'getConfig sent but no stream response in 5 s '
          '(dead fromNum subscription?)',
        );
      } catch (e) {
        // Categorize the error for diagnostics
        final msg = e.toString();
        if (msg.contains('not connected')) {
          AppLogging.adminDiag(
            'Probe $attempt/3: NOT CONNECTED — '
            'getConfig guard rejected (isConnected=$isConnected)',
          );
        } else {
          AppLogging.adminDiag('Probe $attempt/3: ERROR — $e');
        }
      }
      if (attempt < 3) {
        await Future<void>.delayed(const Duration(seconds: 2));
      }
    }
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
