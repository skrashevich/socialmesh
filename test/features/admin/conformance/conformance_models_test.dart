// SPDX-License-Identifier: GPL-3.0-or-later

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:socialmesh/features/admin/conformance/conformance_models.dart';

void main() {
  group('ProviderStateSnapshot', () {
    test('toJson produces expected structure', () {
      final snapshot = ProviderStateSnapshot(
        providerName: 'test_provider',
        testCaseName: 'test_case',
        phase: 'after_load',
        timestamp: 1700000000000,
        serializedState: {'key': 'value'},
      );

      final json = snapshot.toJson();

      expect(json['providerName'], 'test_provider');
      expect(json['testCaseName'], 'test_case');
      expect(json['phase'], 'after_load');
      expect(json['timestamp'], 1700000000000);
      expect(json['state'], {'key': 'value'});
      expect(json.containsKey('error'), false);
    });

    test('toJson includes error when present', () {
      final snapshot = ProviderStateSnapshot(
        providerName: 'p',
        testCaseName: 't',
        phase: 'error',
        timestamp: 0,
        error: 'Something failed',
      );

      final json = snapshot.toJson();

      expect(json['error'], 'Something failed');
      expect(json.containsKey('state'), false);
    });

    test('toNdjsonLine produces valid JSON', () {
      final snapshot = ProviderStateSnapshot(
        providerName: 'p',
        testCaseName: 't',
        phase: 'baseline',
        timestamp: 12345,
      );

      final line = snapshot.toNdjsonLine();
      final decoded = jsonDecode(line) as Map<String, dynamic>;

      expect(decoded['providerName'], 'p');
      expect(decoded['timestamp'], 12345);
    });

    test('fromJson roundtrips correctly', () {
      final original = ProviderStateSnapshot(
        providerName: 'prov',
        testCaseName: 'case',
        phase: 'before_save',
        timestamp: 99999,
        serializedState: {'a': 1, 'b': 'two'},
        error: 'minor issue',
      );

      final restored = ProviderStateSnapshot.fromJson(original.toJson());

      expect(restored.providerName, original.providerName);
      expect(restored.testCaseName, original.testCaseName);
      expect(restored.phase, original.phase);
      expect(restored.timestamp, original.timestamp);
      expect(restored.serializedState, original.serializedState);
      expect(restored.error, original.error);
    });
  });

  group('ConformanceTestResult', () {
    test('toJson produces expected structure', () {
      final result = ConformanceTestResult(
        name: 'NoOpWriteReadback_DEVICE',
        domain: 'DEVICE',
        outcome: ConformanceOutcome.pass,
        durationMs: 1234,
      );

      final json = result.toJson();

      expect(json['name'], 'NoOpWriteReadback_DEVICE');
      expect(json['domain'], 'DEVICE');
      expect(json['outcome'], 'pass');
      expect(json['durationMs'], 1234);
      expect(json.containsKey('error'), false);
      expect(json.containsKey('notes'), false);
    });

    test('toJson includes error and notes when present', () {
      final result = ConformanceTestResult(
        name: 'test',
        domain: 'D',
        outcome: ConformanceOutcome.fail,
        durationMs: 500,
        error: 'Mismatch',
        notes: ['loaded', 'saved', 'readback failed'],
      );

      final json = result.toJson();

      expect(json['error'], 'Mismatch');
      expect(json['notes'], hasLength(3));
      expect(json['outcome'], 'fail');
    });

    test('fromJson roundtrips correctly', () {
      final original = ConformanceTestResult(
        name: 'Test1',
        domain: 'DISPLAY',
        outcome: ConformanceOutcome.skipped,
        durationMs: 0,
        error: 'skipped',
        notes: ['note1'],
      );

      final restored = ConformanceTestResult.fromJson(original.toJson());

      expect(restored.name, original.name);
      expect(restored.domain, original.domain);
      expect(restored.outcome, original.outcome);
      expect(restored.durationMs, original.durationMs);
      expect(restored.error, original.error);
      expect(restored.notes, original.notes);
    });

    test('fromJson handles missing optional fields', () {
      final json = {
        'name': 'T',
        'domain': 'D',
        'outcome': 'pass',
        'durationMs': 100,
      };

      final result = ConformanceTestResult.fromJson(json);

      expect(result.error, isNull);
      expect(result.notes, isEmpty);
    });
  });

  group('LatencyStats', () {
    test('fromDurations computes min, max, mean correctly', () {
      final stats = LatencyStats.fromDurations([100, 200, 300, 400, 500]);

      expect(stats.count, 5);
      expect(stats.minMs, 100);
      expect(stats.maxMs, 500);
      expect(stats.meanMs, 300);
    });

    test('fromDurations computes median correctly for odd count', () {
      final stats = LatencyStats.fromDurations([10, 20, 30, 40, 50]);

      expect(stats.medianMs, 30);
    });

    test('fromDurations computes median correctly for even count', () {
      // For even count, takes the element at length ~/ 2
      final stats = LatencyStats.fromDurations([10, 20, 30, 40]);

      expect(stats.medianMs, 30); // index 2
    });

    test('fromDurations computes p95 correctly', () {
      // 20 elements: p95 index = floor(20 * 0.95) = 19
      final durations = List.generate(20, (i) => (i + 1) * 10);
      final stats = LatencyStats.fromDurations(durations);

      expect(stats.p95Ms, 200); // index 19 → 200
    });

    test('fromDurations handles empty list', () {
      final stats = LatencyStats.fromDurations([]);

      expect(stats.count, 0);
      expect(stats.minMs, 0);
      expect(stats.maxMs, 0);
      expect(stats.meanMs, 0);
      expect(stats.medianMs, 0);
      expect(stats.p95Ms, 0);
    });

    test('fromDurations handles single element', () {
      final stats = LatencyStats.fromDurations([42]);

      expect(stats.count, 1);
      expect(stats.minMs, 42);
      expect(stats.maxMs, 42);
      expect(stats.meanMs, 42);
      expect(stats.medianMs, 42);
      expect(stats.p95Ms, 42);
    });

    test('fromDurations preserves timeout count', () {
      final stats = LatencyStats.fromDurations([100, 200], timeoutCount: 3);

      expect(stats.timeoutCount, 3);
    });

    test('fromDurations sorts unsorted input', () {
      final stats = LatencyStats.fromDurations([500, 100, 300, 200, 400]);

      expect(stats.minMs, 100);
      expect(stats.maxMs, 500);
    });

    test('toJson produces expected structure', () {
      final stats = LatencyStats.fromDurations([100, 200, 300]);
      final json = stats.toJson();

      expect(json['count'], 3);
      expect(json['minMs'], 100);
      expect(json['maxMs'], 300);
      expect(json.containsKey('meanMs'), true);
      expect(json.containsKey('medianMs'), true);
      expect(json.containsKey('p95Ms'), true);
      expect(json['timeoutCount'], 0);
    });
  });

  group('ConformanceSummary', () {
    test('passed/failed/skipped counts are correct', () {
      final summary = ConformanceSummary(
        runId: 'test_run',
        startedAt: DateTime(2024),
        finishedAt: DateTime(2024),
        suiteType: ConformanceSuiteType.safe,
        totalTests: 4,
        passed: 2,
        failed: 1,
        skipped: 1,
        results: [
          const ConformanceTestResult(
            name: 'A',
            domain: 'D',
            outcome: ConformanceOutcome.pass,
            durationMs: 100,
          ),
          const ConformanceTestResult(
            name: 'B',
            domain: 'D',
            outcome: ConformanceOutcome.pass,
            durationMs: 200,
          ),
          const ConformanceTestResult(
            name: 'C',
            domain: 'D',
            outcome: ConformanceOutcome.fail,
            durationMs: 300,
          ),
          const ConformanceTestResult(
            name: 'D',
            domain: 'D',
            outcome: ConformanceOutcome.skipped,
            durationMs: 0,
          ),
        ],
        latencyByDomain: const {},
        suspectedAnomalies: const [],
      );

      expect(summary.totalTests, 4);
      expect(summary.passed, 2);
      expect(summary.failed, 1);
      expect(summary.skipped, 1);
    });

    test('timeoutCount uses explicit value', () {
      final summary = ConformanceSummary(
        runId: 'r',
        startedAt: DateTime(2024),
        finishedAt: DateTime(2024),
        suiteType: ConformanceSuiteType.destructive,
        totalTests: 0,
        passed: 0,
        failed: 0,
        skipped: 0,
        timeoutCount: 3,
        results: const [],
        latencyByDomain: {
          'A': LatencyStats.fromDurations([100], timeoutCount: 2),
          'B': LatencyStats.fromDurations([200], timeoutCount: 1),
        },
        suspectedAnomalies: const [],
      );

      expect(summary.timeoutCount, 3);
    });

    test('toJsonString produces valid JSON', () {
      final summary = ConformanceSummary(
        runId: 'test123',
        startedAt: DateTime(2024, 1, 1),
        finishedAt: DateTime(2024, 1, 1, 0, 0, 10),
        suiteType: ConformanceSuiteType.safe,
        totalTests: 1,
        passed: 1,
        failed: 0,
        skipped: 0,
        results: const [
          ConformanceTestResult(
            name: 'Test',
            domain: 'D',
            outcome: ConformanceOutcome.pass,
            durationMs: 50,
          ),
        ],
        latencyByDomain: const {},
        suspectedAnomalies: const ['anomaly1'],
      );

      final jsonString = summary.toJsonString();
      final decoded = jsonDecode(jsonString) as Map<String, dynamic>;

      expect(decoded['runId'], 'test123');
      expect(decoded['suiteType'], 'safe');
      expect(decoded['results'], hasLength(1));
      expect(decoded['suspectedAnomalies'], ['anomaly1']);
    });
  });
}
