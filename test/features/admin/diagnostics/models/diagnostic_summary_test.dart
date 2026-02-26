// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter_test/flutter_test.dart';
import 'package:socialmesh/features/admin/diagnostics/models/diagnostic_run.dart';
import 'package:socialmesh/features/admin/diagnostics/models/diagnostic_summary.dart';

void main() {
  group('ProbeSummaryEntry', () {
    test('serializes pass result to JSON', () {
      const entry = ProbeSummaryEntry(
        name: 'GetMyNodeInfoProbe',
        status: 'pass',
        durationMs: 250,
      );

      final json = entry.toJson();

      expect(json['name'], 'GetMyNodeInfoProbe');
      expect(json['status'], 'pass');
      expect(json['durationMs'], 250);
      expect(json.containsKey('errorExcerpt'), false);
    });

    test('serializes fail result with error', () {
      const entry = ProbeSummaryEntry(
        name: 'GetConfigProbe(DEVICE_CONFIG)',
        status: 'fail',
        durationMs: 6000,
        errorExcerpt: 'Timeout after 6s',
      );

      final json = entry.toJson();

      expect(json['errorExcerpt'], 'Timeout after 6s');
    });

    test('round-trips through JSON', () {
      const original = ProbeSummaryEntry(
        name: 'TestProbe',
        status: 'skipped',
        durationMs: 0,
        errorExcerpt: 'Run cancelled',
      );

      final json = original.toJson();
      final restored = ProbeSummaryEntry.fromJson(json);

      expect(restored.name, original.name);
      expect(restored.status, original.status);
      expect(restored.durationMs, original.durationMs);
      expect(restored.errorExcerpt, original.errorExcerpt);
    });
  });

  group('SuspectedCause', () {
    test('serializes to JSON', () {
      const cause = SuspectedCause(
        signal: 'multiple_timeouts',
        evidence: '3 probes timed out: A, B, C',
      );

      final json = cause.toJson();

      expect(json['signal'], 'multiple_timeouts');
      expect(json['evidence'], contains('3 probes'));
    });

    test('round-trips through JSON', () {
      const original = SuspectedCause(
        signal: 'all_probes_failed',
        evidence: 'Every probe failed',
      );

      final json = original.toJson();
      final restored = SuspectedCause.fromJson(json);

      expect(restored.signal, original.signal);
      expect(restored.evidence, original.evidence);
    });
  });

  group('DiagnosticSummary', () {
    DiagnosticRun createTestRun() {
      return DiagnosticRun(
        runId: 'summary_test_001',
        startedAt: DateTime.utc(2024, 1, 1),
        appVersion: '1.16.0',
        buildNumber: '123',
        platform: 'ios',
        osVersion: 'iOS 17.0',
        deviceModel: 'iPhone15,2',
        transport: 'ble',
        target: const DiagnosticTarget(mode: DiagnosticTargetMode.local),
      );
    }

    test('fromRun with all passing probes produces no suspected causes', () {
      final run = createTestRun();
      final probes = [
        const ProbeSummaryEntry(
          name: 'ProbeA',
          status: 'pass',
          durationMs: 100,
        ),
        const ProbeSummaryEntry(
          name: 'ProbeB',
          status: 'pass',
          durationMs: 200,
        ),
      ];

      final summary = DiagnosticSummary.fromRun(run, probes);

      expect(summary.runId, 'summary_test_001');
      expect(summary.probes.length, 2);
      expect(summary.suspectedCauses, isEmpty);
    });

    test('fromRun with multiple timeouts produces timeout signal', () {
      final run = createTestRun();
      final probes = [
        const ProbeSummaryEntry(
          name: 'ProbeA',
          status: 'fail',
          durationMs: 6000,
          errorExcerpt: 'Timeout after 6s',
        ),
        const ProbeSummaryEntry(
          name: 'ProbeB',
          status: 'fail',
          durationMs: 6000,
          errorExcerpt: 'timeout exceeded',
        ),
        const ProbeSummaryEntry(
          name: 'ProbeC',
          status: 'pass',
          durationMs: 100,
        ),
      ];

      final summary = DiagnosticSummary.fromRun(run, probes);

      expect(summary.suspectedCauses.length, 1);
      expect(summary.suspectedCauses.first.signal, 'multiple_timeouts');
      expect(
        summary.suspectedCauses.first.evidence,
        contains('2 probes timed out'),
      );
    });

    test('fromRun with decode errors produces decode signal', () {
      final run = createTestRun();
      final probes = [
        const ProbeSummaryEntry(
          name: 'ProbeA',
          status: 'fail',
          durationMs: 100,
          errorExcerpt: 'Decode failed: invalid protobuf',
        ),
      ];

      final summary = DiagnosticSummary.fromRun(run, probes);

      expect(
        summary.suspectedCauses.any((c) => c.signal == 'decode_failures'),
        true,
      );
    });

    test('fromRun with all failures produces all_probes_failed signal', () {
      final run = createTestRun();
      final probes = [
        const ProbeSummaryEntry(
          name: 'ProbeA',
          status: 'fail',
          durationMs: 6000,
          errorExcerpt: 'Timeout after 6s',
        ),
        const ProbeSummaryEntry(
          name: 'ProbeB',
          status: 'fail',
          durationMs: 6000,
          errorExcerpt: 'Timeout after 6s',
        ),
      ];

      final summary = DiagnosticSummary.fromRun(run, probes);

      expect(
        summary.suspectedCauses.any((c) => c.signal == 'all_probes_failed'),
        true,
      );
      // 100% timeout → zombie_connection, not multiple_timeouts
      expect(
        summary.suspectedCauses.any((c) => c.signal == 'zombie_connection'),
        true,
      );
      expect(
        summary.suspectedCauses.any((c) => c.signal == 'multiple_timeouts'),
        false,
      );
    });

    test('fromRun with >80% timeouts produces zombie_connection signal', () {
      final run = createTestRun();
      // 9/10 = 90% timeouts → zombie signature
      final probes = [
        const ProbeSummaryEntry(
          name: 'GetMyNodeInfo',
          status: 'pass',
          durationMs: 0,
        ),
        for (var i = 1; i <= 9; i++)
          ProbeSummaryEntry(
            name: 'Probe$i',
            status: 'fail',
            durationMs: 6000,
            errorExcerpt: 'Timeout after 6s',
          ),
      ];

      final summary = DiagnosticSummary.fromRun(run, probes);

      expect(
        summary.suspectedCauses.any((c) => c.signal == 'zombie_connection'),
        true,
      );
      // zombie_connection replaces multiple_timeouts
      expect(
        summary.suspectedCauses.any((c) => c.signal == 'multiple_timeouts'),
        false,
      );
    });

    test('single timeout does not produce timeout signal', () {
      final run = createTestRun();
      final probes = [
        const ProbeSummaryEntry(
          name: 'ProbeA',
          status: 'fail',
          durationMs: 6000,
          errorExcerpt: 'Timeout after 6s',
        ),
        const ProbeSummaryEntry(
          name: 'ProbeB',
          status: 'pass',
          durationMs: 100,
        ),
      ];

      final summary = DiagnosticSummary.fromRun(run, probes);

      expect(
        summary.suspectedCauses.any((c) => c.signal == 'multiple_timeouts'),
        false,
      );
    });

    test('toJsonString produces valid formatted JSON', () {
      final run = createTestRun();
      final summary = DiagnosticSummary.fromRun(run, []);

      final jsonString = summary.toJsonString();

      expect(jsonString, contains('  ')); // indented
      expect(jsonString, contains('"runId"'));
      expect(jsonString, contains('"environment"'));
      expect(jsonString, contains('"probes"'));
      expect(jsonString, contains('"suspectedCauses"'));
    });

    test('round-trips through JSON', () {
      final run = createTestRun();
      final probes = [
        const ProbeSummaryEntry(
          name: 'TestProbe',
          status: 'pass',
          durationMs: 150,
        ),
      ];
      final original = DiagnosticSummary.fromRun(run, probes);

      final json = original.toJson();
      final restored = DiagnosticSummary.fromJson(json);

      expect(restored.runId, original.runId);
      expect(restored.probes.length, 1);
      expect(restored.probes.first.name, 'TestProbe');
      expect(restored.suspectedCauses, isEmpty);
    });
  });
}
