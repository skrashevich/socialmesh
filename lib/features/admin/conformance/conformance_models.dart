// SPDX-License-Identifier: GPL-3.0-or-later
import 'dart:convert';

/// Outcome of a single conformance test case.
enum ConformanceOutcome { pass, fail, skipped }

/// Category of conformance test.
enum ConformanceSuiteType { safe, destructive }

/// A single provider state snapshot captured at a point in time.
class ProviderStateSnapshot {
  final String providerName;
  final String testCaseName;
  final String phase;
  final int timestamp;
  final Map<String, dynamic>? serializedState;
  final String? error;

  const ProviderStateSnapshot({
    required this.providerName,
    required this.testCaseName,
    required this.phase,
    required this.timestamp,
    this.serializedState,
    this.error,
  });

  String toNdjsonLine() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => {
    'providerName': providerName,
    'testCaseName': testCaseName,
    'phase': phase,
    'timestamp': timestamp,
    if (serializedState != null) 'state': serializedState,
    if (error != null) 'error': error,
  };

  factory ProviderStateSnapshot.fromJson(Map<String, dynamic> json) =>
      ProviderStateSnapshot(
        providerName: json['providerName'] as String,
        testCaseName: json['testCaseName'] as String,
        phase: json['phase'] as String,
        timestamp: json['timestamp'] as int,
        serializedState: json['state'] as Map<String, dynamic>?,
        error: json['error'] as String?,
      );
}

/// Result of a single conformance test case.
class ConformanceTestResult {
  final String name;
  final String domain;
  final ConformanceOutcome outcome;
  final int durationMs;
  final String? error;
  final List<String> notes;

  const ConformanceTestResult({
    required this.name,
    required this.domain,
    required this.outcome,
    required this.durationMs,
    this.error,
    this.notes = const [],
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'domain': domain,
    'outcome': outcome.name,
    'durationMs': durationMs,
    if (error != null) 'error': error,
    if (notes.isNotEmpty) 'notes': notes,
  };

  factory ConformanceTestResult.fromJson(Map<String, dynamic> json) =>
      ConformanceTestResult(
        name: json['name'] as String,
        domain: json['domain'] as String,
        outcome: ConformanceOutcome.values.firstWhere(
          (e) => e.name == json['outcome'],
        ),
        durationMs: json['durationMs'] as int,
        error: json['error'] as String?,
        notes:
            (json['notes'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const [],
      );
}

/// Latency statistics for a batch of operations.
class LatencyStats {
  final int count;
  final int minMs;
  final int maxMs;
  final double meanMs;
  final double medianMs;
  final double p95Ms;
  final int timeoutCount;

  const LatencyStats({
    required this.count,
    required this.minMs,
    required this.maxMs,
    required this.meanMs,
    required this.medianMs,
    required this.p95Ms,
    this.timeoutCount = 0,
  });

  factory LatencyStats.fromDurations(
    List<int> durationsMs, {
    int timeoutCount = 0,
  }) {
    if (durationsMs.isEmpty) {
      return const LatencyStats(
        count: 0,
        minMs: 0,
        maxMs: 0,
        meanMs: 0,
        medianMs: 0,
        p95Ms: 0,
      );
    }
    final sorted = List<int>.from(durationsMs)..sort();
    final mean = sorted.reduce((a, b) => a + b) / sorted.length;
    final median = sorted[sorted.length ~/ 2].toDouble();
    final p95Index = (sorted.length * 0.95).floor().clamp(0, sorted.length - 1);

    return LatencyStats(
      count: sorted.length,
      minMs: sorted.first,
      maxMs: sorted.last,
      meanMs: mean,
      medianMs: median,
      p95Ms: sorted[p95Index].toDouble(),
      timeoutCount: timeoutCount,
    );
  }

  Map<String, dynamic> toJson() => {
    'count': count,
    'minMs': minMs,
    'maxMs': maxMs,
    'meanMs': meanMs,
    'medianMs': medianMs,
    'p95Ms': p95Ms,
    'timeoutCount': timeoutCount,
  };
}

/// Full conformance run summary.
class ConformanceSummary {
  final String runId;
  final DateTime startedAt;
  final DateTime finishedAt;
  final ConformanceSuiteType suiteType;
  final int totalTests;
  final int passed;
  final int failed;
  final int skipped;
  final int timeoutCount;
  final int decodeFailureCount;
  final int restoreFailureCount;
  final List<ConformanceTestResult> results;
  final Map<String, LatencyStats> latencyByDomain;
  final List<String> suspectedAnomalies;

  const ConformanceSummary({
    required this.runId,
    required this.startedAt,
    required this.finishedAt,
    required this.suiteType,
    required this.totalTests,
    required this.passed,
    required this.failed,
    required this.skipped,
    this.timeoutCount = 0,
    this.decodeFailureCount = 0,
    this.restoreFailureCount = 0,
    required this.results,
    this.latencyByDomain = const {},
    this.suspectedAnomalies = const [],
  });

  Map<String, dynamic> toJson() => {
    'runId': runId,
    'startedAt': startedAt.toIso8601String(),
    'finishedAt': finishedAt.toIso8601String(),
    'suiteType': suiteType.name,
    'totalTests': totalTests,
    'passed': passed,
    'failed': failed,
    'skipped': skipped,
    'timeoutCount': timeoutCount,
    'decodeFailureCount': decodeFailureCount,
    'restoreFailureCount': restoreFailureCount,
    'results': results.map((r) => r.toJson()).toList(),
    'latencyByDomain': latencyByDomain.map((k, v) => MapEntry(k, v.toJson())),
    'suspectedAnomalies': suspectedAnomalies,
  };

  String toJsonString() => const JsonEncoder.withIndent('  ').convert(toJson());
}
