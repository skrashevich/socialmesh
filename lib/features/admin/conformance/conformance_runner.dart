// SPDX-License-Identifier: GPL-3.0-or-later
import 'dart:async';

import '../../../core/logging.dart';
import '../../../services/protocol/admin_target.dart';
import '../../../services/protocol/protocol_service.dart';
import '../diagnostics/services/diagnostic_capture_service.dart';
import 'conformance_context.dart';
import 'conformance_models.dart';
import 'conformance_suite_destructive.dart';
import 'conformance_suite_safe.dart';

/// Progress callback for the conformance runner.
typedef ConformanceRunnerProgressCallback =
    void Function(
      String phaseName,
      String testName,
      int completed,
      int total,
      ConformanceOutcome? lastOutcome,
    );

/// Orchestrates a full conformance run: safe suite, then optionally
/// the destructive suite.
///
/// The runner:
/// 1. Creates the ConformanceContext
/// 2. Starts packet capture
/// 3. Runs safe suite (all config domains)
/// 4. Optionally runs destructive suite
/// 5. Builds summary
/// 6. Stops capture
class ConformanceRunner {
  final ProtocolService protocolService;
  final AdminTarget target;
  final int myNodeNum;
  final bool destructiveMode;
  final ConformanceRunnerProgressCallback? onProgress;

  ConformanceSuiteSafe? _safeSuite;
  ConformanceSuiteDestructive? _destructiveSuite;

  ConformanceRunner({
    required this.protocolService,
    required this.target,
    required this.myNodeNum,
    this.destructiveMode = false,
    this.onProgress,
  });

  /// Cancel the current run.
  void cancel() {
    _safeSuite?.cancel();
    _destructiveSuite?.cancel();
  }

  /// Execute the full conformance run.
  ///
  /// Returns a [ConformanceRunResult] with all results, packet capture,
  /// and provider state snapshots.
  Future<ConformanceRunResult> run() async {
    final runId = _generateRunId();
    final capture = DiagnosticCaptureService();
    capture.start();

    final ctx = ConformanceContext(
      protocolService: protocolService,
      target: target,
      myNodeNum: myNodeNum,
      runId: runId,
      packetCapture: capture,
      destructiveMode: destructiveMode,
    );

    final startedAt = DateTime.now();
    final allResults = <ConformanceTestResult>[];

    AppLogging.adminDiag(
      'Conformance run $runId started '
      '(destructive=$destructiveMode)',
    );

    // Phase 1: Safe suite
    _safeSuite = ConformanceSuiteSafe(
      context: ctx,
      onProgress: (name, completed, total, outcome) {
        onProgress?.call('Safe', name, completed, total, outcome);
      },
    );

    final safeResults = await _safeSuite!.run();
    allResults.addAll(safeResults);

    // Phase 2: Destructive suite (optional)
    if (destructiveMode && !_safeSuite!.isCancelled) {
      _destructiveSuite = ConformanceSuiteDestructive(
        context: ctx,
        onProgress: (name, completed, total, outcome) {
          onProgress?.call('Destructive', name, completed, total, outcome);
        },
      );

      final destructiveResults = await _destructiveSuite!.run();
      allResults.addAll(destructiveResults);
    }

    capture.stop();
    final finishedAt = DateTime.now();

    // Build summary
    final summary = _buildSummary(
      runId: runId,
      startedAt: startedAt,
      finishedAt: finishedAt,
      results: allResults,
    );

    AppLogging.adminDiag(
      'Conformance run $runId finished: '
      '${summary.passed}/${summary.totalTests} passed, '
      '${summary.failed} failed, '
      '${summary.skipped} skipped',
    );

    return ConformanceRunResult(
      summary: summary,
      capture: capture,
      context: ctx,
    );
  }

  ConformanceSummary _buildSummary({
    required String runId,
    required DateTime startedAt,
    required DateTime finishedAt,
    required List<ConformanceTestResult> results,
  }) {
    final passed = results
        .where((r) => r.outcome == ConformanceOutcome.pass)
        .length;
    final failed = results
        .where((r) => r.outcome == ConformanceOutcome.fail)
        .length;
    final skipped = results
        .where((r) => r.outcome == ConformanceOutcome.skipped)
        .length;

    // Count timeouts (error contains 'Timeout')
    final timeoutCount = results
        .where(
          (r) =>
              r.error?.contains('Timeout') == true ||
              r.error?.contains('timeout') == true,
        )
        .length;

    // Count decode failures
    final decodeFailureCount = results
        .where(
          (r) =>
              r.error?.contains('decode') == true ||
              r.error?.contains('Decode') == true,
        )
        .length;

    // Count restore failures
    final restoreFailureCount = results
        .where(
          (r) =>
              r.error?.contains('restore') == true ||
              r.error?.contains('Restore') == true,
        )
        .length;

    // Compute latency stats by domain
    final latencyByDomain = <String, LatencyStats>{};
    final byDomain = <String, List<int>>{};
    for (final r in results) {
      byDomain.putIfAbsent(r.domain, () => []).add(r.durationMs);
    }
    for (final entry in byDomain.entries) {
      latencyByDomain[entry.key] = LatencyStats.fromDurations(entry.value);
    }

    // Detect anomalies
    final anomalies = <String>[];
    if (timeoutCount > 0) {
      anomalies.add('$timeoutCount test(s) timed out');
    }
    if (restoreFailureCount > 0) {
      anomalies.add('$restoreFailureCount config restore(s) failed');
    }
    final disconnectCount = results
        .where(
          (r) =>
              r.error != null &&
              (r.error!.contains('not connected') ||
                  r.error!.contains('disconnected') ||
                  r.error!.contains('Device disconnected')),
        )
        .length;
    if (disconnectCount > 0) {
      anomalies.add(
        '$disconnectCount test(s) failed due to device disconnection',
      );
    }
    final failedDomains = results
        .where((r) => r.outcome == ConformanceOutcome.fail)
        .map((r) => r.domain)
        .toSet();
    if (failedDomains.length > 3) {
      anomalies.add(
        'Multiple unrelated domains failing — suspect transport issue',
      );
    }

    return ConformanceSummary(
      runId: runId,
      startedAt: startedAt,
      finishedAt: finishedAt,
      suiteType: destructiveMode
          ? ConformanceSuiteType.destructive
          : ConformanceSuiteType.safe,
      totalTests: results.length,
      passed: passed,
      failed: failed,
      skipped: skipped,
      timeoutCount: timeoutCount,
      decodeFailureCount: decodeFailureCount,
      restoreFailureCount: restoreFailureCount,
      results: results,
      latencyByDomain: latencyByDomain,
      suspectedAnomalies: anomalies,
    );
  }

  static String _generateRunId() {
    final now = DateTime.now().toUtc();
    final ts = now.toIso8601String().replaceAll(':', '').replaceAll('-', '');
    final suffix = now.microsecondsSinceEpoch.toRadixString(36).substring(0, 4);
    return 'conf_${ts}_$suffix';
  }
}

/// Complete result of a conformance run.
class ConformanceRunResult {
  final ConformanceSummary summary;
  final DiagnosticCaptureService capture;
  final ConformanceContext context;

  const ConformanceRunResult({
    required this.summary,
    required this.capture,
    required this.context,
  });
}
