// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter_test/flutter_test.dart';
import 'package:socialmesh/features/admin/diagnostics/services/diagnostic_probe_registry.dart';

void main() {
  group('DiagnosticProbeRegistry', () {
    test('buildReadOnlyProbes returns expected probe count', () {
      final probes = DiagnosticProbeRegistry.buildReadOnlyProbes();

      // 2 env + 8 config + 5 module config + 2 payload = 17
      expect(probes.length, 17);
    });

    test('buildReadOnlyProbes starts with env probes', () {
      final probes = DiagnosticProbeRegistry.buildReadOnlyProbes();

      expect(probes[0].name, 'GetMyNodeInfo');
      expect(probes[1].name, 'GetDeviceMetadata');
    });

    test('buildReadOnlyProbes includes config probes', () {
      final probes = DiagnosticProbeRegistry.buildReadOnlyProbes();
      final names = probes.map((p) => p.name).toList();

      expect(names, contains('GetConfig_DEVICE_CONFIG'));
      expect(names, contains('GetConfig_LORA_CONFIG'));
      expect(names, contains('GetConfig_POSITION_CONFIG'));
      expect(names, contains('GetConfig_POWER_CONFIG'));
      expect(names, contains('GetConfig_NETWORK_CONFIG'));
      expect(names, contains('GetConfig_BLUETOOTH_CONFIG'));
      expect(names, contains('GetConfig_DISPLAY_CONFIG'));
      expect(names, contains('GetConfig_SECURITY_CONFIG'));
    });

    test('buildReadOnlyProbes includes module config probes', () {
      final probes = DiagnosticProbeRegistry.buildReadOnlyProbes();
      final names = probes.map((p) => p.name).toList();

      expect(names, contains('GetModuleConfig_MQTT_CONFIG'));
      expect(names, contains('GetModuleConfig_TELEMETRY_CONFIG'));
      expect(names, contains('GetModuleConfig_PAXCOUNTER_CONFIG'));
      expect(names, contains('GetModuleConfig_SERIAL_CONFIG'));
      expect(names, contains('GetModuleConfig_RANGETEST_CONFIG'));
    });

    test('buildReadOnlyProbes includes payload probes', () {
      final probes = DiagnosticProbeRegistry.buildReadOnlyProbes();
      final names = probes.map((p) => p.name).toList();

      expect(names, contains('GetCannedMessages'));
      expect(names, contains('GetRingtone'));
    });

    test('buildReadOnlyProbes has no write probes', () {
      final probes = DiagnosticProbeRegistry.buildReadOnlyProbes();
      expect(probes.every((p) => !p.requiresWrite), true);
    });

    test('buildReadOnlyProbes has no stress probes', () {
      final probes = DiagnosticProbeRegistry.buildReadOnlyProbes();
      expect(probes.every((p) => !p.isStressTest), true);
    });

    test('buildStressProbes returns 2 probes', () {
      final probes = DiagnosticProbeRegistry.buildStressProbes();
      expect(probes.length, 2);
      expect(probes.every((p) => p.isStressTest), true);
    });

    test('buildWriteProbes returns 2 probes', () {
      final probes = DiagnosticProbeRegistry.buildWriteProbes();
      expect(probes.length, 2);
      expect(probes.every((p) => p.requiresWrite), true);
    });

    test('build with no options returns read-only only', () {
      final probes = DiagnosticProbeRegistry.build();
      expect(probes.length, 17);
    });

    test('build with stress tests includes stress probes', () {
      final probes = DiagnosticProbeRegistry.build(includeStressTests: true);
      expect(probes.length, 19);
    });

    test('build with write tests includes write probes', () {
      final probes = DiagnosticProbeRegistry.build(includeWriteTests: true);
      expect(probes.length, 19);
    });

    test('build with all options includes all probes', () {
      final probes = DiagnosticProbeRegistry.build(
        includeStressTests: true,
        includeWriteTests: true,
      );
      expect(probes.length, 21);
    });

    test('build order is env, config, module, payload, stress, write', () {
      final probes = DiagnosticProbeRegistry.build(
        includeStressTests: true,
        includeWriteTests: true,
      );

      // First 2: env
      expect(probes[0].name, contains('NodeInfo'));
      expect(probes[1].name, contains('Metadata'));

      // Next 8: config (GetConfig_*)
      expect(probes[2].name, startsWith('GetConfig_'));

      // Next 5: module config (GetModuleConfig_*)
      expect(probes[10].name, startsWith('GetModuleConfig_'));

      // Payload
      expect(probes[15].name, contains('CannedMessages'));
      expect(probes[16].name, contains('Ringtone'));

      // Stress
      expect(probes[17].isStressTest, true);
      expect(probes[18].isStressTest, true);

      // Write
      expect(probes[19].requiresWrite, true);
      expect(probes[20].requiresWrite, true);
    });

    test('all probe names are unique', () {
      final probes = DiagnosticProbeRegistry.build(
        includeStressTests: true,
        includeWriteTests: true,
      );
      final names = probes.map((p) => p.name).toSet();
      expect(names.length, probes.length);
    });
  });
}
