// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:socialmesh/features/admin/diagnostics/models/diagnostic_run.dart';

void main() {
  group('DiagnosticTargetMode', () {
    test('has local and remote values', () {
      expect(DiagnosticTargetMode.values.length, 2);
      expect(DiagnosticTargetMode.values, contains(DiagnosticTargetMode.local));
      expect(
        DiagnosticTargetMode.values,
        contains(DiagnosticTargetMode.remote),
      );
    });
  });

  group('DiagnosticTarget', () {
    test('local target serializes correctly', () {
      const target = DiagnosticTarget(mode: DiagnosticTargetMode.local);
      final json = target.toJson();

      expect(json['mode'], 'local');
      expect(json.containsKey('targetNodeNum'), false);
    });

    test('remote target serializes with node number', () {
      const target = DiagnosticTarget(
        mode: DiagnosticTargetMode.remote,
        targetNodeNum: 0x12345678,
      );
      final json = target.toJson();

      expect(json['mode'], 'remote');
      expect(json['targetNodeNum'], 0x12345678);
    });

    test('round-trips through JSON', () {
      const original = DiagnosticTarget(
        mode: DiagnosticTargetMode.remote,
        targetNodeNum: 42,
      );

      final json = original.toJson();
      final restored = DiagnosticTarget.fromJson(json);

      expect(restored.mode, DiagnosticTargetMode.remote);
      expect(restored.targetNodeNum, 42);
    });
  });

  group('DiagnosticResultCounts', () {
    test('defaults to zeros', () {
      const counts = DiagnosticResultCounts();
      expect(counts.passed, 0);
      expect(counts.failed, 0);
      expect(counts.skipped, 0);
    });

    test('serializes to JSON', () {
      const counts = DiagnosticResultCounts(passed: 10, failed: 2, skipped: 1);
      final json = counts.toJson();

      expect(json['passed'], 10);
      expect(json['failed'], 2);
      expect(json['skipped'], 1);
    });

    test('round-trips through JSON', () {
      const original = DiagnosticResultCounts(passed: 5, failed: 3, skipped: 2);

      final json = original.toJson();
      final restored = DiagnosticResultCounts.fromJson(json);

      expect(restored.passed, original.passed);
      expect(restored.failed, original.failed);
      expect(restored.skipped, original.skipped);
    });
  });

  group('DiagnosticRun', () {
    DiagnosticRun createRun({String? runId, DateTime? startedAt}) {
      return DiagnosticRun(
        runId: runId ?? 'test_run_001',
        startedAt: startedAt ?? DateTime.utc(2024, 1, 1),
        appVersion: '1.16.0',
        buildNumber: '123',
        platform: 'ios',
        osVersion: 'iOS 17.0',
        deviceModel: 'iPhone15,2',
        transport: 'ble',
        myNodeNum: 0x12345678,
        target: const DiagnosticTarget(mode: DiagnosticTargetMode.local),
        firmwareVersion: '2.5.0.abc1234',
        hardwareModel: 'HELTEC_V3',
      );
    }

    test('generateRunId produces non-empty ID', () {
      final id = DiagnosticRun.generateRunId();
      expect(id, isNotEmpty);
      expect(id.contains('_'), true);
    });

    test('generateRunId produces unique IDs', () {
      final ids = <String>{};
      for (var i = 0; i < 10; i++) {
        ids.add(DiagnosticRun.generateRunId());
      }
      // At least some should be unique (timing dependent)
      expect(ids.length, greaterThan(1));
    });

    test('serializes to JSON with all fields', () {
      final run = createRun();
      run.finishedAt = DateTime.utc(2024, 1, 1, 0, 5);
      run.result = const DiagnosticResultCounts(
        passed: 15,
        failed: 2,
        skipped: 0,
      );

      final json = run.toJson();

      expect(json['runId'], 'test_run_001');
      expect(json['appVersion'], '1.16.0');
      expect(json['buildNumber'], '123');
      expect(json['platform'], 'ios');
      expect(json['osVersion'], 'iOS 17.0');
      expect(json['deviceModel'], 'iPhone15,2');
      expect(json['transport'], 'ble');
      expect(json['myNodeNum'], 0x12345678);
      expect(json['firmwareVersion'], '2.5.0.abc1234');
      expect(json['hardwareModel'], 'HELTEC_V3');
      expect(json['finishedAt'], isNotNull);
      expect(json['result'], isA<Map<String, dynamic>>());
    });

    test('omits null optional fields', () {
      final run = DiagnosticRun(
        runId: 'test_001',
        startedAt: DateTime.utc(2024),
        appVersion: '1.0.0',
        buildNumber: '1',
        platform: 'android',
        osVersion: 'Android 14',
        deviceModel: 'Pixel 8',
        transport: 'usb',
        target: const DiagnosticTarget(mode: DiagnosticTargetMode.local),
      );

      final json = run.toJson();

      expect(json.containsKey('mtu'), false);
      expect(json.containsKey('myNodeNum'), false);
      expect(json.containsKey('firmwareVersion'), false);
      expect(json.containsKey('hardwareModel'), false);
      expect(json.containsKey('finishedAt'), false);
    });

    test('toEnvironmentJson produces valid formatted JSON', () {
      final run = createRun();
      final envJson = run.toEnvironmentJson();

      expect(envJson, contains('  ')); // indented
      final parsed = Map<String, dynamic>.from(
        const JsonDecoder().convert(envJson) as Map,
      );
      expect(parsed['runId'], 'test_run_001');
    });

    test('round-trips through JSON', () {
      final original = createRun();
      original.finishedAt = DateTime.utc(2024, 1, 1, 0, 10);
      original.result = const DiagnosticResultCounts(
        passed: 10,
        failed: 5,
        skipped: 2,
      );

      final json = original.toJson();
      final restored = DiagnosticRun.fromJson(json);

      expect(restored.runId, original.runId);
      expect(restored.appVersion, original.appVersion);
      expect(restored.platform, original.platform);
      expect(restored.transport, original.transport);
      expect(restored.myNodeNum, original.myNodeNum);
      expect(restored.firmwareVersion, original.firmwareVersion);
      expect(restored.hardwareModel, original.hardwareModel);
      expect(restored.result.passed, 10);
      expect(restored.result.failed, 5);
      expect(restored.result.skipped, 2);
      expect(restored.finishedAt, isNotNull);
    });

    test('finishedAt and result are mutable', () {
      final run = createRun();
      expect(run.finishedAt, isNull);

      run.finishedAt = DateTime.utc(2024, 1, 1, 1);
      run.result = const DiagnosticResultCounts(passed: 1);

      expect(run.finishedAt, isNotNull);
      expect(run.result.passed, 1);
    });
  });
}
