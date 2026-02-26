// SPDX-License-Identifier: GPL-3.0-or-later
import 'dart:convert';

/// Target mode for the diagnostic run.
enum DiagnosticTargetMode { local, remote }

/// Result of a single diagnostic probe.
enum ProbeResultStatus { pass, fail, skipped }

/// Target info captured at run start.
class DiagnosticTarget {
  final DiagnosticTargetMode mode;
  final int? targetNodeNum;

  const DiagnosticTarget({required this.mode, this.targetNodeNum});

  Map<String, dynamic> toJson() => {
    'mode': mode.name,
    if (targetNodeNum != null) 'targetNodeNum': targetNodeNum,
  };

  factory DiagnosticTarget.fromJson(Map<String, dynamic> json) =>
      DiagnosticTarget(
        mode: DiagnosticTargetMode.values.firstWhere(
          (e) => e.name == json['mode'],
        ),
        targetNodeNum: json['targetNodeNum'] as int?,
      );
}

/// Result counts from a completed run.
class DiagnosticResultCounts {
  final int passed;
  final int failed;
  final int skipped;

  const DiagnosticResultCounts({
    this.passed = 0,
    this.failed = 0,
    this.skipped = 0,
  });

  int get total => passed + failed + skipped;

  Map<String, dynamic> toJson() => {
    'passed': passed,
    'failed': failed,
    'skipped': skipped,
    'total': total,
  };

  factory DiagnosticResultCounts.fromJson(Map<String, dynamic> json) =>
      DiagnosticResultCounts(
        passed: json['passed'] as int? ?? 0,
        failed: json['failed'] as int? ?? 0,
        skipped: json['skipped'] as int? ?? 0,
      );
}

/// Captures the full context of a diagnostic session.
class DiagnosticRun {
  final String runId;
  final DateTime startedAt;
  DateTime? finishedAt;
  final String appVersion;
  final String buildNumber;
  final String platform;
  final String osVersion;
  final String deviceModel;
  final String transport;
  final int? mtu;
  final int? myNodeNum;
  final DiagnosticTarget target;
  final String? firmwareVersion;
  final String? hardwareModel;
  DiagnosticResultCounts result;

  DiagnosticRun({
    required this.runId,
    required this.startedAt,
    this.finishedAt,
    required this.appVersion,
    required this.buildNumber,
    required this.platform,
    required this.osVersion,
    required this.deviceModel,
    required this.transport,
    this.mtu,
    this.myNodeNum,
    required this.target,
    this.firmwareVersion,
    this.hardwareModel,
    this.result = const DiagnosticResultCounts(),
  });

  /// Generate a stable run ID from timestamp + random suffix.
  static String generateRunId() {
    final now = DateTime.now().toUtc();
    final ts = now.toIso8601String().replaceAll(':', '').replaceAll('-', '');
    final suffix = now.microsecondsSinceEpoch.toRadixString(36).substring(0, 4);
    return '${ts}_$suffix';
  }

  Map<String, dynamic> toJson() => {
    'runId': runId,
    'startedAt': startedAt.toIso8601String(),
    if (finishedAt != null) 'finishedAt': finishedAt!.toIso8601String(),
    'appVersion': appVersion,
    'buildNumber': buildNumber,
    'platform': platform,
    'osVersion': osVersion,
    'deviceModel': deviceModel,
    'transport': transport,
    if (mtu != null) 'mtu': mtu,
    if (myNodeNum != null) 'myNodeNum': myNodeNum,
    'target': target.toJson(),
    if (firmwareVersion != null) 'firmwareVersion': firmwareVersion,
    if (hardwareModel != null) 'hardwareModel': hardwareModel,
    'result': result.toJson(),
  };

  /// Produce the environment.json content.
  String toEnvironmentJson() =>
      const JsonEncoder.withIndent('  ').convert(toJson());

  factory DiagnosticRun.fromJson(Map<String, dynamic> json) => DiagnosticRun(
    runId: json['runId'] as String,
    startedAt: DateTime.parse(json['startedAt'] as String),
    finishedAt: json['finishedAt'] != null
        ? DateTime.parse(json['finishedAt'] as String)
        : null,
    appVersion: json['appVersion'] as String,
    buildNumber: json['buildNumber'] as String,
    platform: json['platform'] as String,
    osVersion: json['osVersion'] as String,
    deviceModel: json['deviceModel'] as String,
    transport: json['transport'] as String,
    mtu: json['mtu'] as int?,
    myNodeNum: json['myNodeNum'] as int?,
    target: DiagnosticTarget.fromJson(json['target'] as Map<String, dynamic>),
    firmwareVersion: json['firmwareVersion'] as String?,
    hardwareModel: json['hardwareModel'] as String?,
    result: json['result'] != null
        ? DiagnosticResultCounts.fromJson(
            json['result'] as Map<String, dynamic>,
          )
        : const DiagnosticResultCounts(),
  );
}
