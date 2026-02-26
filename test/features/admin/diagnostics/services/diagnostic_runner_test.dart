// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter_test/flutter_test.dart';
import 'package:socialmesh/features/admin/diagnostics/models/diagnostic_event.dart';
import 'package:socialmesh/features/admin/diagnostics/models/diagnostic_summary.dart';
import 'package:socialmesh/features/admin/diagnostics/services/diagnostic_capture_service.dart';
import 'package:socialmesh/features/admin/diagnostics/services/diagnostic_probe.dart';
import 'package:socialmesh/features/admin/diagnostics/services/diagnostic_runner.dart';
import 'package:socialmesh/services/protocol/admin_target.dart';
import 'package:socialmesh/services/protocol/protocol_service.dart';

/// Fake probe that always passes.
class _FakePassProbe extends DiagnosticProbe {
  @override
  final String name;

  _FakePassProbe(this.name);

  @override
  Future<ProbeResult> run(DiagnosticContext ctx) async {
    return const ProbeResult(outcome: ProbeOutcome.pass, durationMs: 50);
  }
}

/// Fake probe that always fails.
class _FakeFailProbe extends DiagnosticProbe {
  @override
  final String name;

  final String errorMessage;

  _FakeFailProbe(this.name, {this.errorMessage = 'Simulated failure'});

  @override
  Future<ProbeResult> run(DiagnosticContext ctx) async {
    return ProbeResult(
      outcome: ProbeOutcome.fail,
      durationMs: 100,
      error: errorMessage,
    );
  }
}

/// Fake probe that throws an exception.
class _FakeThrowProbe extends DiagnosticProbe {
  @override
  final String name;

  _FakeThrowProbe(this.name);

  @override
  Future<ProbeResult> run(DiagnosticContext ctx) async {
    throw StateError('Unexpected error in probe');
  }
}

void main() {
  group('DiagnosticRunner', () {
    late DiagnosticCaptureService capture;

    setUp(() {
      capture = DiagnosticCaptureService();
      capture.start();
    });

    test('runs all probes sequentially and returns results', () async {
      final probes = [
        _FakePassProbe('Probe1'),
        _FakePassProbe('Probe2'),
        _FakePassProbe('Probe3'),
      ];

      final runner = DiagnosticRunner(
        capture: capture,
        context: _createFakeContext(capture),
        probes: probes,
      );

      final results = await runner.run();

      expect(results.length, 3);
      expect(results.every((r) => r.status == 'pass'), true);
    });

    test('reports correct progress', () async {
      final progressUpdates = <(String, int, int, ProbeOutcome?)>[];

      final probes = [
        _FakePassProbe('A'),
        _FakeFailProbe('B'),
        _FakePassProbe('C'),
      ];

      final runner = DiagnosticRunner(
        capture: capture,
        context: _createFakeContext(capture),
        probes: probes,
        onProgress: (name, completed, total, outcome) {
          progressUpdates.add((name, completed, total, outcome));
        },
      );

      await runner.run();

      // Should have 6 progress calls: 3 starts + 3 completions
      expect(progressUpdates.length, 6);

      // First call: about to start probe A
      expect(progressUpdates[0].$1, 'A');
      expect(progressUpdates[0].$2, 0);
      expect(progressUpdates[0].$3, 3);
      expect(progressUpdates[0].$4, isNull); // no outcome yet

      // Second call: A completed
      expect(progressUpdates[1].$1, 'A');
      expect(progressUpdates[1].$2, 1);
      expect(progressUpdates[1].$4, ProbeOutcome.pass);

      // Fourth call: B completed
      expect(progressUpdates[3].$1, 'B');
      expect(progressUpdates[3].$2, 2);
      expect(progressUpdates[3].$4, ProbeOutcome.fail);
    });

    test('handles probe exceptions gracefully', () async {
      final probes = [
        _FakePassProbe('Safe'),
        _FakeThrowProbe('Broken'),
        _FakePassProbe('AfterBroken'),
      ];

      final runner = DiagnosticRunner(
        capture: capture,
        context: _createFakeContext(capture),
        probes: probes,
      );

      final results = await runner.run();

      expect(results.length, 3);
      expect(results[0].status, 'pass');
      expect(results[1].status, 'fail');
      expect(results[1].errorExcerpt, contains('Unexpected error'));
      expect(results[2].status, 'pass');
    });

    test('cancel marks remaining probes as skipped', () async {
      final probes = [
        _FakePassProbe('First'),
        _FakePassProbe('Second'),
        _FakePassProbe('Third'),
      ];

      final runner = DiagnosticRunner(
        capture: capture,
        context: _createFakeContext(capture),
        probes: probes,
      );

      // Cancel before first probe starts
      runner.cancel();
      final results = await runner.run();

      expect(runner.isCancelled, true);
      expect(results.length, 3);
      expect(results.every((r) => r.status == 'skipped'), true);
      expect(results.every((r) => r.errorExcerpt == 'Run cancelled'), true);
    });

    test('records start and end internal events for each probe', () async {
      final probes = [_FakePassProbe('TrackedProbe')];

      final runner = DiagnosticRunner(
        capture: capture,
        context: _createFakeContext(capture),
        probes: probes,
      );

      await runner.run();

      final probeEvents = capture.events
          .where(
            (e) =>
                e.phase == DiagnosticPhase.probe &&
                e.probeName == 'TrackedProbe',
          )
          .toList();

      expect(probeEvents.length, 2);
      expect(probeEvents[0].notes, 'start');
      expect(probeEvents[1].notes, contains('end'));
      expect(probeEvents[1].notes, contains('pass'));
    });

    test('records failure in end event notes', () async {
      final probes = [
        _FakeFailProbe('FailProbe', errorMessage: 'Custom error'),
      ];

      final runner = DiagnosticRunner(
        capture: capture,
        context: _createFakeContext(capture),
        probes: probes,
      );

      await runner.run();

      final endEvent = capture.events.lastWhere(
        (e) => e.probeName == 'FailProbe' && e.notes?.contains('end') == true,
      );

      expect(endEvent.notes, contains('fail'));
      expect(endEvent.notes, contains('Custom error'));
    });

    test('mixed pass and fail results counted correctly', () async {
      final probes = [
        _FakePassProbe('P1'),
        _FakeFailProbe('F1'),
        _FakePassProbe('P2'),
        _FakeFailProbe('F2'),
        _FakePassProbe('P3'),
      ];

      final runner = DiagnosticRunner(
        capture: capture,
        context: _createFakeContext(capture),
        probes: probes,
      );

      final results = await runner.run();

      final passCount = results.where((r) => r.status == 'pass').length;
      final failCount = results.where((r) => r.status == 'fail').length;

      expect(passCount, 3);
      expect(failCount, 2);
    });

    test('results list on runner is unmodifiable snapshot', () async {
      final probes = [_FakePassProbe('Only')];

      final runner = DiagnosticRunner(
        capture: capture,
        context: _createFakeContext(capture),
        probes: probes,
      );

      await runner.run();

      expect(runner.results.length, 1);
      expect(
        () => runner.results.add(
          const ProbeSummaryEntry(
            name: 'injected',
            status: 'pass',
            durationMs: 0,
          ),
        ),
        throwsA(isA<UnsupportedError>()),
      );
    });
  });
}

/// Creates a minimal fake [DiagnosticContext] for testing.
///
/// This does NOT use a real ProtocolService — probes that need one should
/// be tested with protocol-level integration tests.
DiagnosticContext _createFakeContext(DiagnosticCaptureService capture) {
  return DiagnosticContext(
    protocolService: _FakeProtocolService(),
    target: const AdminTarget.local(),
    myNodeNum: 0x12345678,
    runId: 'test_run_001',
    capture: capture,
    timeout: const Duration(seconds: 2),
  );
}

/// Minimal fake ProtocolService for testing.
/// The test probes don't call any methods on it.
class _FakeProtocolService extends Fake implements ProtocolService {}
