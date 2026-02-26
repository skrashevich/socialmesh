// SPDX-License-Identifier: GPL-3.0-or-later
import '../../../../services/protocol/admin_target.dart';
import '../../../../services/protocol/protocol_service.dart';
import 'diagnostic_capture_service.dart';

/// Result of a single probe execution.
enum ProbeOutcome { pass, fail, skipped }

/// Result returned by a probe after execution.
class ProbeResult {
  final ProbeOutcome outcome;
  final int durationMs;
  final String? error;

  const ProbeResult({
    required this.outcome,
    required this.durationMs,
    this.error,
  });
}

/// Context passed to each probe during a diagnostic run.
class DiagnosticContext {
  final ProtocolService protocolService;
  final AdminTarget target;
  final int myNodeNum;
  final String runId;
  final DiagnosticCaptureService capture;
  final Duration timeout;
  final int maxRetries;

  const DiagnosticContext({
    required this.protocolService,
    required this.target,
    required this.myNodeNum,
    required this.runId,
    required this.capture,
    this.timeout = const Duration(seconds: 6),
    this.maxRetries = 1,
  });

  /// The node number of the target being diagnosed.
  int get targetNodeNum => target.resolve(myNodeNum);

  /// Whether the target is local (self).
  bool get isLocal => target.isLocal;

  /// Whether the target is a remote node.
  bool get isRemote => target.isRemote;
}

/// Interface for a diagnostic probe.
///
/// Probes are executed sequentially by [DiagnosticRunner].
/// Each probe should be self-contained and idempotent.
abstract class DiagnosticProbe {
  /// Human-readable name of this probe.
  String get name;

  /// Optional maximum wall-clock duration for the runner's outer timeout.
  ///
  /// When `null` (default) the runner uses [DiagnosticContext.timeout].
  /// Override this in probes that send multiple requests and need more
  /// time than a single request/response cycle (e.g. stress probes).
  Duration? get maxDuration => null;

  /// Whether this probe requires write access.
  bool get requiresWrite => false;

  /// Whether this probe is a stress test.
  bool get isStressTest => false;

  /// Execute the probe and return a result.
  Future<ProbeResult> run(DiagnosticContext ctx);
}
