// SPDX-License-Identifier: GPL-3.0-or-later
import 'dart:async';

import '../../../core/logging.dart';
import 'adapters/config_domain_adapters.dart';
import 'conformance_context.dart';
import 'conformance_models.dart';

/// Progress callback for conformance test execution.
typedef ConformanceProgressCallback =
    void Function(
      String testName,
      int completed,
      int total,
      ConformanceOutcome? lastOutcome,
    );

/// Safe conformance suite — no destructive operations.
///
/// For each config domain:
///   1. Load via adapter.load(target)
///   2. Snapshot provider state
///   3. Save NO-OP via adapter.save(currentState, target)
///   4. Load again
///   5. Snapshot provider state
///   6. Assert equality
///   7. Record pass/fail
///
/// All operations flow through the same ProtocolService methods
/// used by the actual config screens.
class ConformanceSuiteSafe {
  final ConformanceContext _ctx;
  final ConformanceProgressCallback? onProgress;

  bool _cancelled = false;
  final List<ConformanceTestResult> _results = [];

  ConformanceSuiteSafe({required ConformanceContext context, this.onProgress})
    : _ctx = context;

  /// Cancel remaining tests.
  void cancel() => _cancelled = true;

  /// Whether the suite was cancelled.
  bool get isCancelled => _cancelled;

  /// Results collected so far.
  List<ConformanceTestResult> get results => List.unmodifiable(_results);

  /// Run the full safe conformance suite.
  ///
  /// Returns the list of test results.
  Future<List<ConformanceTestResult>> run() async {
    final adapters = buildAllAdapters();
    final totalTests = adapters.length;

    AppLogging.adminDiag('Safe conformance suite: $totalTests domains');

    for (var i = 0; i < adapters.length; i++) {
      if (_cancelled) {
        _skipRemaining(adapters, i);
        break;
      }

      // Connection health gate: if not fully ready (BLE + protocol config
      // exchange), wait for reconnect. If reconnection fails, skip remaining.
      if (!_ctx.isReady) {
        final reconnected = await _ctx.awaitReconnection();
        if (!reconnected) {
          AppLogging.adminDiag(
            'Connection lost — skipping remaining ${adapters.length - i} tests',
          );
          _skipRemaining(adapters, i, reason: 'Device disconnected');
          break;
        }
      }

      final adapter = adapters[i];
      onProgress?.call('NoOp_${adapter.domainName}', i, totalTests, null);

      final result = await _runNoOpWriteReadback(adapter);
      _results.add(result);

      onProgress?.call(result.name, i + 1, totalTests, result.outcome);

      // After a timeout failure, the device may be rebooting with BLE
      // still technically connected. Probe firmware readiness before
      // continuing to the next test to avoid a cascade of timeouts.
      if (result.error != null &&
          (result.error!.contains('timeout') ||
              result.error!.contains('Timeout') ||
              result.error!.contains('not connected'))) {
        AppLogging.adminDiag(
          'Test failure suggests device instability — '
          'probing firmware readiness before next test...',
        );
        final ready = await _ctx.awaitReconnection(
          maxWait: const Duration(seconds: 45),
        );
        if (!ready) {
          AppLogging.adminDiag(
            'Device unresponsive — skipping remaining '
            '${adapters.length - i - 1} tests',
          );
          _skipRemaining(adapters, i + 1, reason: 'Device unresponsive');
          break;
        }
      }

      // Inter-test settling delay to reduce rapid-fire config writes
      // that can trigger device reboots.
      if (i < adapters.length - 1) {
        await Future<void>.delayed(const Duration(seconds: 1));
      }
    }

    return _results;
  }

  /// Run no-op write-readback test for a single domain.
  Future<ConformanceTestResult> _runNoOpWriteReadback<T>(
    ConfigDomainAdapter<T> adapter,
  ) async {
    final testName = 'NoOp_${adapter.domainName}';
    final sw = Stopwatch()..start();
    final notes = <String>[];

    try {
      // Step 1: Load baseline
      AppLogging.adminDiag('$testName: loading baseline');
      _ctx.recordState(
        providerName: adapter.domainName,
        testCaseName: testName,
        phase: 'before_load',
      );

      final baseline = await adapter.load(_ctx.protocolService, _ctx.target);

      _ctx.recordState(
        providerName: adapter.domainName,
        testCaseName: testName,
        phase: 'after_load',
        serializedState: adapter.serialize(baseline),
      );
      notes.add('Baseline loaded');

      // Step 2: Write no-op (save same config back)
      AppLogging.adminDiag('$testName: writing no-op');
      _ctx.recordState(
        providerName: adapter.domainName,
        testCaseName: testName,
        phase: 'before_save',
        serializedState: adapter.serialize(baseline),
      );

      await adapter.save(_ctx.protocolService, baseline, _ctx.target);
      notes.add('No-op write completed');

      // Brief delay for device processing
      await Future<void>.delayed(const Duration(milliseconds: 500));

      _ctx.recordState(
        providerName: adapter.domainName,
        testCaseName: testName,
        phase: 'after_save',
      );

      // Post-write connectivity check: many config writes trigger a firmware
      // reboot. If the device disconnected after the write, recover BEFORE
      // attempting the readback rather than failing and recovering after.
      if (!_ctx.isConnected) {
        AppLogging.adminDiag(
          '$testName: device disconnected after write — '
          'waiting for reconnection before readback...',
        );
        notes.add('Post-write reboot detected');
        final recovered = await _ctx.awaitReconnection(
          maxWait: const Duration(seconds: 45),
        );
        if (!recovered) {
          AppLogging.adminDiag(
            '$testName: FAIL — device did not recover after post-write reboot',
          );
          return ConformanceTestResult(
            name: testName,
            domain: adapter.domainName,
            outcome: ConformanceOutcome.fail,
            durationMs: sw.elapsedMilliseconds,
            error: 'Device did not recover after config write reboot',
            notes: notes,
          );
        }
        notes.add('Post-write recovery complete');
      }

      // Step 3: Read back
      AppLogging.adminDiag('$testName: reading back');
      final readback = await adapter.load(_ctx.protocolService, _ctx.target);

      _ctx.recordState(
        providerName: adapter.domainName,
        testCaseName: testName,
        phase: 'after_readback',
        serializedState: adapter.serialize(readback),
      );
      notes.add('Readback completed');

      // Step 4: Assert equality
      final equal = adapter.isEqual(baseline, readback);

      if (equal) {
        AppLogging.adminDiag('$testName: PASS');
        return ConformanceTestResult(
          name: testName,
          domain: adapter.domainName,
          outcome: ConformanceOutcome.pass,
          durationMs: sw.elapsedMilliseconds,
          notes: notes,
        );
      } else {
        final baselineJson = adapter.serialize(baseline);
        final readbackJson = adapter.serialize(readback);
        AppLogging.adminDiag(
          '$testName: FAIL — readback mismatch\n'
          '  baseline: $baselineJson\n'
          '  readback: $readbackJson',
        );
        return ConformanceTestResult(
          name: testName,
          domain: adapter.domainName,
          outcome: ConformanceOutcome.fail,
          durationMs: sw.elapsedMilliseconds,
          error: 'Readback mismatch after no-op write',
          notes: [
            ...notes,
            'Baseline: $baselineJson',
            'Readback: $readbackJson',
          ],
        );
      }
    } on TimeoutException {
      AppLogging.adminDiag('$testName: FAIL — timeout');
      return ConformanceTestResult(
        name: testName,
        domain: adapter.domainName,
        outcome: ConformanceOutcome.fail,
        durationMs: sw.elapsedMilliseconds,
        error: 'Timeout during load or save',
        notes: notes,
      );
    } catch (e) {
      AppLogging.adminDiag('$testName: FAIL — $e');
      return ConformanceTestResult(
        name: testName,
        domain: adapter.domainName,
        outcome: ConformanceOutcome.fail,
        durationMs: sw.elapsedMilliseconds,
        error: e.toString(),
        notes: notes,
      );
    }
  }

  void _skipRemaining(
    List<ConfigDomainAdapter<dynamic>> adapters,
    int startIndex, {
    String reason = 'Suite cancelled',
  }) {
    for (var j = startIndex; j < adapters.length; j++) {
      _results.add(
        ConformanceTestResult(
          name: 'NoOp_${adapters[j].domainName}',
          domain: adapters[j].domainName,
          outcome: ConformanceOutcome.skipped,
          durationMs: 0,
          error: reason,
        ),
      );
    }
  }
}
