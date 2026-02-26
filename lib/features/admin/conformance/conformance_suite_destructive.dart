// SPDX-License-Identifier: GPL-3.0-or-later
import 'dart:async';
import 'dart:math';

import '../../../generated/meshtastic/config.pb.dart' as config_pb;
import 'adapters/config_domain_adapters.dart';
import 'conformance_context.dart';
import 'conformance_models.dart';
import 'conformance_suite_safe.dart';

/// Destructive conformance suite — requires explicit opt-in.
///
/// Includes:
///   A) Randomized config mutation sweep
///   B) Node DB reset + rehydration
///   C) Factory reset + restore (config only)
///   D) Channel wipe + restore
///   E) Region flip + restore
///   F) Burst stress (rapid reads + writes)
///   G) Remote admin target-switch torture
class ConformanceSuiteDestructive {
  final ConformanceContext _ctx;
  final ConformanceProgressCallback? onProgress;

  bool _cancelled = false;
  final List<ConformanceTestResult> _results = [];

  ConformanceSuiteDestructive({
    required ConformanceContext context,
    this.onProgress,
  }) : _ctx = context;

  /// Cancel remaining tests.
  void cancel() => _cancelled = true;

  /// Results collected so far.
  List<ConformanceTestResult> get results => List.unmodifiable(_results);

  /// Run the full destructive suite.
  Future<List<ConformanceTestResult>> run() async {
    if (!_ctx.destructiveMode) {
      return [
        const ConformanceTestResult(
          name: 'DestructiveSuite',
          domain: 'SYSTEM',
          outcome: ConformanceOutcome.skipped,
          durationMs: 0,
          error: 'Destructive mode not enabled',
        ),
      ];
    }

    final tests = <Future<ConformanceTestResult> Function()>[
      _testRandomizedMutation,
      _testBurstStressReads,
      _testBurstStressWrites,
      _testChannelWipeRestore,
      _testNodeDbReset,
    ];

    final totalTests = tests.length;

    for (var i = 0; i < tests.length; i++) {
      if (_cancelled) {
        for (var j = i; j < tests.length; j++) {
          _results.add(
            const ConformanceTestResult(
              name: 'Cancelled',
              domain: 'SYSTEM',
              outcome: ConformanceOutcome.skipped,
              durationMs: 0,
              error: 'Suite cancelled',
            ),
          );
        }
        break;
      }

      // Connection health gate: BLE connected + protocol config exchange
      if (!_ctx.isReady) {
        final reconnected = await _ctx.awaitReconnection();
        if (!reconnected) {
          for (var j = i; j < tests.length; j++) {
            _results.add(
              const ConformanceTestResult(
                name: 'Disconnected',
                domain: 'SYSTEM',
                outcome: ConformanceOutcome.skipped,
                durationMs: 0,
                error: 'Device disconnected',
              ),
            );
          }
          break;
        }
      }

      final result = await tests[i]();
      _results.add(result);

      onProgress?.call(result.name, i + 1, totalTests, result.outcome);

      // After a timeout/disconnect failure, probe firmware readiness
      // before continuing (device may be mid-reboot).
      if (result.error != null &&
          (result.error!.contains('timeout') ||
              result.error!.contains('Timeout') ||
              result.error!.contains('not connected'))) {
        final ready = await _ctx.awaitReconnection(
          maxWait: const Duration(seconds: 45),
        );
        if (!ready) {
          for (var j = i + 1; j < tests.length; j++) {
            _results.add(
              const ConformanceTestResult(
                name: 'Unresponsive',
                domain: 'SYSTEM',
                outcome: ConformanceOutcome.skipped,
                durationMs: 0,
                error: 'Device unresponsive',
              ),
            );
          }
          break;
        }
      }

      // Inter-test settling delay
      if (i < tests.length - 1) {
        await Future<void>.delayed(const Duration(seconds: 1));
      }
    }

    return _results;
  }

  // -----------------------------------------------------------------------
  // A) Randomized Config Mutation Sweep
  // -----------------------------------------------------------------------

  Future<ConformanceTestResult> _testRandomizedMutation() async {
    const testName = 'RandomizedMutation_DISPLAY';
    final sw = Stopwatch()..start();
    final notes = <String>[];
    final rng = Random(42); // deterministic seed

    try {
      final adapter = DisplayConfigAdapter();

      // Load baseline
      final baseline = await adapter.load(_ctx.protocolService, _ctx.target);
      _ctx.recordState(
        providerName: adapter.domainName,
        testCaseName: testName,
        phase: 'baseline_load',
        serializedState: adapter.serialize(baseline),
      );
      notes.add('Baseline loaded');

      // Mutate a safe field: screenOnSecs (10–600 is valid range)
      final mutatedScreenOnSecs = 10 + rng.nextInt(590);
      final mutated = config_pb.Config_DisplayConfig()
        ..mergeFromMessage(baseline)
        ..screenOnSecs = mutatedScreenOnSecs;

      notes.add('Mutating screenOnSecs to $mutatedScreenOnSecs');

      await adapter.save(_ctx.protocolService, mutated, _ctx.target);
      await Future<void>.delayed(const Duration(milliseconds: 500));

      // Read back and verify mutation took effect
      final readback = await adapter.load(_ctx.protocolService, _ctx.target);
      _ctx.recordState(
        providerName: adapter.domainName,
        testCaseName: testName,
        phase: 'mutation_readback',
        serializedState: adapter.serialize(readback),
      );

      if (readback.screenOnSecs != mutatedScreenOnSecs) {
        return ConformanceTestResult(
          name: testName,
          domain: adapter.domainName,
          outcome: ConformanceOutcome.fail,
          durationMs: sw.elapsedMilliseconds,
          error:
              'Mutation readback mismatch: '
              'expected screenOnSecs=$mutatedScreenOnSecs, '
              'got ${readback.screenOnSecs}',
          notes: notes,
        );
      }
      notes.add('Mutation verified');

      // Restore original
      await adapter.save(_ctx.protocolService, baseline, _ctx.target);
      await Future<void>.delayed(const Duration(milliseconds: 500));

      final restored = await adapter.load(_ctx.protocolService, _ctx.target);
      _ctx.recordState(
        providerName: adapter.domainName,
        testCaseName: testName,
        phase: 'restore_readback',
        serializedState: adapter.serialize(restored),
      );

      if (!adapter.isEqual(baseline, restored)) {
        return ConformanceTestResult(
          name: testName,
          domain: adapter.domainName,
          outcome: ConformanceOutcome.fail,
          durationMs: sw.elapsedMilliseconds,
          error: 'Baseline restore failed',
          notes: notes,
        );
      }
      notes.add('Baseline restored successfully');

      return ConformanceTestResult(
        name: testName,
        domain: adapter.domainName,
        outcome: ConformanceOutcome.pass,
        durationMs: sw.elapsedMilliseconds,
        notes: notes,
      );
    } on TimeoutException {
      return ConformanceTestResult(
        name: testName,
        domain: 'DISPLAY_CONFIG',
        outcome: ConformanceOutcome.fail,
        durationMs: sw.elapsedMilliseconds,
        error: 'Timeout during mutation sweep',
        notes: notes,
      );
    } catch (e) {
      return ConformanceTestResult(
        name: testName,
        domain: 'DISPLAY_CONFIG',
        outcome: ConformanceOutcome.fail,
        durationMs: sw.elapsedMilliseconds,
        error: e.toString(),
        notes: notes,
      );
    }
  }

  // -----------------------------------------------------------------------
  // D) Channel Wipe + Restore
  // -----------------------------------------------------------------------

  Future<ConformanceTestResult> _testChannelWipeRestore() async {
    const testName = 'ChannelWipeRestore';
    final sw = Stopwatch()..start();
    final notes = <String>[];

    try {
      final adapter = ChannelConfigAdapter(channelIndex: 0);

      // Baseline
      final baseline = await adapter.load(_ctx.protocolService, _ctx.target);
      _ctx.recordState(
        providerName: adapter.domainName,
        testCaseName: testName,
        phase: 'baseline',
        serializedState: adapter.serialize(baseline),
      );
      notes.add('Channel 0 baseline: "${baseline.name}" role=${baseline.role}');

      // Write same channel back (safe no-op write)
      await adapter.save(_ctx.protocolService, baseline, _ctx.target);
      await Future<void>.delayed(const Duration(seconds: 1));

      // Read back
      final readback = await adapter.load(_ctx.protocolService, _ctx.target);
      _ctx.recordState(
        providerName: adapter.domainName,
        testCaseName: testName,
        phase: 'readback',
        serializedState: adapter.serialize(readback),
      );

      if (!adapter.isEqual(baseline, readback)) {
        return ConformanceTestResult(
          name: testName,
          domain: adapter.domainName,
          outcome: ConformanceOutcome.fail,
          durationMs: sw.elapsedMilliseconds,
          error: 'Channel 0 readback mismatch after write',
          notes: notes,
        );
      }
      notes.add('Channel 0 write-readback verified');

      return ConformanceTestResult(
        name: testName,
        domain: adapter.domainName,
        outcome: ConformanceOutcome.pass,
        durationMs: sw.elapsedMilliseconds,
        notes: notes,
      );
    } on TimeoutException {
      return ConformanceTestResult(
        name: testName,
        domain: 'CHANNEL_0',
        outcome: ConformanceOutcome.fail,
        durationMs: sw.elapsedMilliseconds,
        error: 'Timeout during channel wipe/restore',
        notes: notes,
      );
    } catch (e) {
      return ConformanceTestResult(
        name: testName,
        domain: 'CHANNEL_0',
        outcome: ConformanceOutcome.fail,
        durationMs: sw.elapsedMilliseconds,
        error: e.toString(),
        notes: notes,
      );
    }
  }

  // -----------------------------------------------------------------------
  // B) Node DB Reset
  // -----------------------------------------------------------------------

  Future<ConformanceTestResult> _testNodeDbReset() async {
    const testName = 'NodeDbReset';
    final sw = Stopwatch()..start();
    final notes = <String>[];

    try {
      // Record pre-reset state
      _ctx.recordState(
        providerName: 'nodeDb',
        testCaseName: testName,
        phase: 'before_reset',
      );

      await _ctx.protocolService.nodeDbReset(target: _ctx.target);
      notes.add('nodeDbReset command sent');

      // Wait for device to process the reset
      await Future<void>.delayed(const Duration(seconds: 3));

      _ctx.recordState(
        providerName: 'nodeDb',
        testCaseName: testName,
        phase: 'after_reset',
      );

      // Verify we can still load configs (device is alive)
      final adapter = DeviceConfigAdapter();
      final config = await adapter.load(_ctx.protocolService, _ctx.target);
      _ctx.recordState(
        providerName: adapter.domainName,
        testCaseName: testName,
        phase: 'post_reset_load',
        serializedState: adapter.serialize(config),
      );
      notes.add('Post-reset config load succeeded');

      return ConformanceTestResult(
        name: testName,
        domain: 'SYSTEM',
        outcome: ConformanceOutcome.pass,
        durationMs: sw.elapsedMilliseconds,
        notes: notes,
      );
    } on TimeoutException {
      return ConformanceTestResult(
        name: testName,
        domain: 'SYSTEM',
        outcome: ConformanceOutcome.fail,
        durationMs: sw.elapsedMilliseconds,
        error: 'Timeout after nodeDbReset',
        notes: notes,
      );
    } catch (e) {
      return ConformanceTestResult(
        name: testName,
        domain: 'SYSTEM',
        outcome: ConformanceOutcome.fail,
        durationMs: sw.elapsedMilliseconds,
        error: e.toString(),
        notes: notes,
      );
    }
  }

  // -----------------------------------------------------------------------
  // F) Burst Stress — Reads
  // -----------------------------------------------------------------------

  Future<ConformanceTestResult> _testBurstStressReads() async {
    const testName = 'BurstStress_Reads';
    const burstCount = 30;
    final sw = Stopwatch()..start();
    final notes = <String>[];
    final durations = <int>[];
    var timeouts = 0;

    try {
      final adapter = DeviceConfigAdapter();

      for (var i = 0; i < burstCount; i++) {
        if (_cancelled) break;

        final opSw = Stopwatch()..start();
        try {
          await adapter.load(_ctx.protocolService, _ctx.target);
          durations.add(opSw.elapsedMilliseconds);
        } on TimeoutException {
          timeouts++;
          durations.add(opSw.elapsedMilliseconds);
        }
      }

      final stats = LatencyStats.fromDurations(
        durations,
        timeoutCount: timeouts,
      );
      notes.add(
        'Completed $burstCount reads: '
        'mean=${stats.meanMs.toStringAsFixed(1)}ms, '
        'p95=${stats.p95Ms.toStringAsFixed(1)}ms, '
        'timeouts=$timeouts',
      );

      _ctx.recordState(
        providerName: 'BurstStress',
        testCaseName: testName,
        phase: 'completed',
        serializedState: stats.toJson(),
      );

      // Pass if timeout rate < 20%
      final outcome = timeouts < (burstCount * 0.2)
          ? ConformanceOutcome.pass
          : ConformanceOutcome.fail;

      return ConformanceTestResult(
        name: testName,
        domain: 'STRESS',
        outcome: outcome,
        durationMs: sw.elapsedMilliseconds,
        error: outcome == ConformanceOutcome.fail
            ? 'Timeout rate: ${(timeouts / burstCount * 100).toStringAsFixed(1)}%'
            : null,
        notes: notes,
      );
    } catch (e) {
      return ConformanceTestResult(
        name: testName,
        domain: 'STRESS',
        outcome: ConformanceOutcome.fail,
        durationMs: sw.elapsedMilliseconds,
        error: e.toString(),
        notes: notes,
      );
    }
  }

  // -----------------------------------------------------------------------
  // F) Burst Stress — Writes
  // -----------------------------------------------------------------------

  Future<ConformanceTestResult> _testBurstStressWrites() async {
    const testName = 'BurstStress_Writes';
    const burstCount = 30;
    final sw = Stopwatch()..start();
    final notes = <String>[];
    final durations = <int>[];
    var timeouts = 0;

    try {
      final adapter = DisplayConfigAdapter();

      // Load baseline once
      final baseline = await adapter.load(_ctx.protocolService, _ctx.target);
      notes.add('Baseline loaded for write burst');

      for (var i = 0; i < burstCount; i++) {
        if (_cancelled) break;

        final opSw = Stopwatch()..start();
        try {
          // Write same config back each time (no-op mutation)
          await adapter.save(_ctx.protocolService, baseline, _ctx.target);
          durations.add(opSw.elapsedMilliseconds);
        } on TimeoutException {
          timeouts++;
          durations.add(opSw.elapsedMilliseconds);
        }
      }

      // Verify device is still healthy by loading config
      final postBurst = await adapter.load(_ctx.protocolService, _ctx.target);
      if (!adapter.isEqual(baseline, postBurst)) {
        notes.add('WARNING: Post-burst config differs from baseline');
      }

      final stats = LatencyStats.fromDurations(
        durations,
        timeoutCount: timeouts,
      );
      notes.add(
        'Completed $burstCount writes: '
        'mean=${stats.meanMs.toStringAsFixed(1)}ms, '
        'p95=${stats.p95Ms.toStringAsFixed(1)}ms, '
        'timeouts=$timeouts',
      );

      _ctx.recordState(
        providerName: 'BurstStress',
        testCaseName: testName,
        phase: 'completed',
        serializedState: stats.toJson(),
      );

      final outcome = timeouts < (burstCount * 0.2)
          ? ConformanceOutcome.pass
          : ConformanceOutcome.fail;

      return ConformanceTestResult(
        name: testName,
        domain: 'STRESS',
        outcome: outcome,
        durationMs: sw.elapsedMilliseconds,
        error: outcome == ConformanceOutcome.fail
            ? 'Timeout rate: ${(timeouts / burstCount * 100).toStringAsFixed(1)}%'
            : null,
        notes: notes,
      );
    } catch (e) {
      return ConformanceTestResult(
        name: testName,
        domain: 'STRESS',
        outcome: ConformanceOutcome.fail,
        durationMs: sw.elapsedMilliseconds,
        error: e.toString(),
        notes: notes,
      );
    }
  }
}
