// SPDX-License-Identifier: GPL-3.0-or-later
import 'dart:convert';

import 'diagnostic_run.dart';

/// Per-probe result entry in the summary.
class ProbeSummaryEntry {
  final String name;
  final String status; // pass, fail, skipped
  final int durationMs;
  final String? errorExcerpt;

  const ProbeSummaryEntry({
    required this.name,
    required this.status,
    required this.durationMs,
    this.errorExcerpt,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'status': status,
    'durationMs': durationMs,
    if (errorExcerpt != null) 'errorExcerpt': errorExcerpt,
  };

  factory ProbeSummaryEntry.fromJson(Map<String, dynamic> json) =>
      ProbeSummaryEntry(
        name: json['name'] as String,
        status: json['status'] as String,
        durationMs: json['durationMs'] as int,
        errorExcerpt: json['errorExcerpt'] as String?,
      );
}

/// A derived signal — not speculation, just observable evidence.
class SuspectedCause {
  final String signal;
  final String evidence;

  const SuspectedCause({required this.signal, required this.evidence});

  Map<String, dynamic> toJson() => {'signal': signal, 'evidence': evidence};

  factory SuspectedCause.fromJson(Map<String, dynamic> json) => SuspectedCause(
    signal: json['signal'] as String,
    evidence: json['evidence'] as String,
  );
}

/// Top-level summary of a diagnostic run (summary.json).
class DiagnosticSummary {
  final String runId;
  final Map<String, dynamic> environment;
  final List<ProbeSummaryEntry> probes;
  final List<SuspectedCause> suspectedCauses;

  const DiagnosticSummary({
    required this.runId,
    required this.environment,
    required this.probes,
    this.suspectedCauses = const [],
  });

  Map<String, dynamic> toJson() => {
    'runId': runId,
    'environment': environment,
    'probes': probes.map((p) => p.toJson()).toList(),
    'suspectedCauses': suspectedCauses.map((c) => c.toJson()).toList(),
  };

  String toJsonString() => const JsonEncoder.withIndent('  ').convert(toJson());

  /// Build a summary from a completed run and probe results.
  factory DiagnosticSummary.fromRun(
    DiagnosticRun run,
    List<ProbeSummaryEntry> probes,
  ) {
    final causes = <SuspectedCause>[];

    // Derive signals from probe results
    final timeouts = probes.where(
      (p) =>
          p.status == 'fail' &&
          (p.errorExcerpt?.contains('timeout') == true ||
              p.errorExcerpt?.contains('Timeout') == true),
    );
    if (timeouts.length >= 2) {
      causes.add(
        SuspectedCause(
          signal: 'multiple_timeouts',
          evidence:
              '${timeouts.length} probes timed out: ${timeouts.map((t) => t.name).join(", ")}',
        ),
      );
    }

    final decodeErrors = probes.where(
      (p) =>
          p.status == 'fail' &&
          (p.errorExcerpt?.contains('decode') == true ||
              p.errorExcerpt?.contains('Decode') == true),
    );
    if (decodeErrors.isNotEmpty) {
      causes.add(
        SuspectedCause(
          signal: 'decode_failures',
          evidence:
              '${decodeErrors.length} probes had decode errors: ${decodeErrors.map((d) => d.name).join(", ")}',
        ),
      );
    }

    final failCount = probes.where((p) => p.status == 'fail').length;
    if (failCount == probes.length && probes.isNotEmpty) {
      causes.add(
        const SuspectedCause(
          signal: 'all_probes_failed',
          evidence: 'Every probe failed — possible transport/connection issue',
        ),
      );
    }

    return DiagnosticSummary(
      runId: run.runId,
      environment: run.toJson(),
      probes: probes,
      suspectedCauses: causes,
    );
  }

  factory DiagnosticSummary.fromJson(Map<String, dynamic> json) =>
      DiagnosticSummary(
        runId: json['runId'] as String,
        environment: json['environment'] as Map<String, dynamic>,
        probes: (json['probes'] as List<dynamic>)
            .map((p) => ProbeSummaryEntry.fromJson(p as Map<String, dynamic>))
            .toList(),
        suspectedCauses:
            (json['suspectedCauses'] as List<dynamic>?)
                ?.map((c) => SuspectedCause.fromJson(c as Map<String, dynamic>))
                .toList() ??
            [],
      );
}
