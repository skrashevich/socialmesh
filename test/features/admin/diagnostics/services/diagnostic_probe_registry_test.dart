// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter_test/flutter_test.dart';
import 'package:socialmesh/features/admin/diagnostics/services/diagnostic_probe_registry.dart';

void main() {
  group('DiagnosticProbeRegistry', () {
    test('buildReadOnlyProbes returns expected probe count', () {
      final probes = DiagnosticProbeRegistry.buildReadOnlyProbes();

      // 2 env + 8 config + 11 module config + 2 payload
      // + 8 channel + 3 data-plane = 34
      expect(probes.length, 34);
    });

    test('buildReadOnlyProbes starts with env probes', () {
      final probes = DiagnosticProbeRegistry.buildReadOnlyProbes();

      expect(probes[0].name, 'GetMyNodeInfo');
      expect(probes[1].name, 'GetDeviceMetadata');
    });

    test('buildReadOnlyProbes includes all config probes', () {
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

    test('buildReadOnlyProbes includes all module config probes', () {
      final probes = DiagnosticProbeRegistry.buildReadOnlyProbes();
      final names = probes.map((p) => p.name).toList();

      expect(names, contains('GetModuleConfig_MQTT_CONFIG'));
      expect(names, contains('GetModuleConfig_TELEMETRY_CONFIG'));
      expect(names, contains('GetModuleConfig_PAXCOUNTER_CONFIG'));
      expect(names, contains('GetModuleConfig_SERIAL_CONFIG'));
      expect(names, contains('GetModuleConfig_RANGETEST_CONFIG'));
      expect(names, contains('GetModuleConfig_EXTNOTIF_CONFIG'));
      expect(names, contains('GetModuleConfig_STOREFORWARD_CONFIG'));
      expect(names, contains('GetModuleConfig_CANNEDMSG_CONFIG'));
      expect(names, contains('GetModuleConfig_AMBIENTLIGHTING_CONFIG'));
      expect(names, contains('GetModuleConfig_DETECTIONSENSOR_CONFIG'));
      expect(names, contains('GetModuleConfig_TRAFFICMANAGEMENT_CONFIG'));
    });

    test('buildReadOnlyProbes includes payload probes', () {
      final probes = DiagnosticProbeRegistry.buildReadOnlyProbes();
      final names = probes.map((p) => p.name).toList();

      expect(names, contains('GetCannedMessages'));
      expect(names, contains('GetRingtone'));
    });

    test('buildReadOnlyProbes includes all 8 channel probes', () {
      final probes = DiagnosticProbeRegistry.buildReadOnlyProbes();
      final names = probes.map((p) => p.name).toList();

      for (var i = 0; i < 8; i++) {
        expect(names, contains('GetChannel_$i'));
      }
    });

    test('buildReadOnlyProbes includes data-plane probes', () {
      final probes = DiagnosticProbeRegistry.buildReadOnlyProbes();
      final names = probes.map((p) => p.name).toList();

      expect(names, contains('GetOwnerInfo'));
      expect(names, contains('PositionRequestSelf'));
      expect(names, contains('SignalQuality'));
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

    test('buildWriteProbes returns 25 probes', () {
      final probes = DiagnosticProbeRegistry.buildWriteProbes();
      expect(probes.length, 25);
      expect(probes.every((p) => p.requiresWrite), true);
    });

    test('buildWriteProbes includes config write probes', () {
      final probes = DiagnosticProbeRegistry.buildWriteProbes();
      final names = probes.map((p) => p.name).toList();

      expect(names, contains('WriteConfig_DEVICE_CONFIG'));
      expect(names, contains('WriteConfig_LORA_CONFIG'));
      expect(names, contains('WriteConfig_POSITION_CONFIG'));
      expect(names, contains('WriteConfig_POWER_CONFIG'));
      expect(names, contains('WriteConfig_NETWORK_CONFIG'));
      expect(names, contains('WriteConfig_BLUETOOTH_CONFIG'));
      expect(names, contains('WriteConfig_DISPLAY_CONFIG'));
      expect(names, contains('WriteConfig_SECURITY_CONFIG'));
    });

    test('buildWriteProbes includes module config write probes', () {
      final probes = DiagnosticProbeRegistry.buildWriteProbes();
      final names = probes.map((p) => p.name).toList();

      expect(names, contains('WriteModuleConfig_MQTT_CONFIG'));
      expect(names, contains('WriteModuleConfig_TELEMETRY_CONFIG'));
      expect(names, contains('WriteModuleConfig_PAXCOUNTER_CONFIG'));
      expect(names, contains('WriteModuleConfig_SERIAL_CONFIG'));
      expect(names, contains('WriteModuleConfig_RANGETEST_CONFIG'));
      expect(names, contains('WriteModuleConfig_EXTNOTIF_CONFIG'));
      expect(names, contains('WriteModuleConfig_STOREFORWARD_CONFIG'));
      expect(names, contains('WriteModuleConfig_CANNEDMSG_CONFIG'));
      expect(names, contains('WriteModuleConfig_AMBIENTLIGHTING_CONFIG'));
      expect(names, contains('WriteModuleConfig_DETECTIONSENSOR_CONFIG'));
      expect(names, contains('WriteModuleConfig_TRAFFICMANAGEMENT_CONFIG'));
    });

    test('buildWriteProbes includes payload write probes', () {
      final probes = DiagnosticProbeRegistry.buildWriteProbes();
      final names = probes.map((p) => p.name).toList();

      expect(names, contains('WriteRingtone_NoOp'));
      expect(names, contains('WriteCannedMessages_NoOp'));
    });

    test('buildWriteProbes includes channel write probe', () {
      final probes = DiagnosticProbeRegistry.buildWriteProbes();
      final names = probes.map((p) => p.name).toList();

      expect(names, contains('WriteChannel_0_NoOp'));
    });

    test('buildWriteProbes includes data-plane write probes', () {
      final probes = DiagnosticProbeRegistry.buildWriteProbes();
      final names = probes.map((p) => p.name).toList();

      expect(names, contains('SelfMessageLoopback'));
      expect(names, contains('MessageDeliveryAck'));
      expect(names, contains('TracerouteSelf'));
    });

    test('build with no options returns read-only only', () {
      final probes = DiagnosticProbeRegistry.build();
      expect(probes.length, 34);
    });

    test('build with stress tests includes stress probes', () {
      final probes = DiagnosticProbeRegistry.build(includeStressTests: true);
      expect(probes.length, 36);
    });

    test('build with write tests includes write probes', () {
      final probes = DiagnosticProbeRegistry.build(includeWriteTests: true);
      expect(probes.length, 59);
    });

    test('build with all options includes all probes', () {
      final probes = DiagnosticProbeRegistry.build(
        includeStressTests: true,
        includeWriteTests: true,
      );
      expect(probes.length, 61);
    });

    test('build order is env, config, module, payload, channel, data-plane, '
        'stress, write', () {
      final probes = DiagnosticProbeRegistry.build(
        includeStressTests: true,
        includeWriteTests: true,
      );

      // First 2: env
      expect(probes[0].name, contains('NodeInfo'));
      expect(probes[1].name, contains('Metadata'));

      // Next 8: config (GetConfig_*)
      for (var i = 2; i < 10; i++) {
        expect(probes[i].name, startsWith('GetConfig_'));
      }

      // Next 11: module config (GetModuleConfig_*)
      for (var i = 10; i < 21; i++) {
        expect(probes[i].name, startsWith('GetModuleConfig_'));
      }

      // Next 2: payload
      expect(probes[21].name, contains('CannedMessages'));
      expect(probes[22].name, contains('Ringtone'));

      // Next 8: channels
      for (var i = 23; i < 31; i++) {
        expect(probes[i].name, startsWith('GetChannel_'));
      }

      // Next 3: data-plane (read-only)
      expect(probes[31].name, 'GetOwnerInfo');
      expect(probes[32].name, 'PositionRequestSelf');
      expect(probes[33].name, 'SignalQuality');

      // Stress (2)
      expect(probes[34].isStressTest, true);
      expect(probes[35].isStressTest, true);

      // Write (25)
      for (var i = 36; i < 61; i++) {
        expect(probes[i].requiresWrite, true);
      }
    });

    test('all probe names are unique', () {
      final probes = DiagnosticProbeRegistry.build(
        includeStressTests: true,
        includeWriteTests: true,
      );
      final names = probes.map((p) => p.name).toSet();
      expect(names.length, probes.length);
    });

    test('write config probes have extended maxDuration', () {
      final probes = DiagnosticProbeRegistry.buildWriteProbes();
      final configWriteProbes = probes.where(
        (p) => p.name.startsWith('WriteConfig_'),
      );
      for (final probe in configWriteProbes) {
        expect(
          probe.maxDuration,
          isNotNull,
          reason: '${probe.name} should have maxDuration set',
        );
        expect(
          probe.maxDuration!.inSeconds,
          greaterThanOrEqualTo(18),
          reason: '${probe.name} needs enough time for 3 BLE round-trips',
        );
      }
    });

    test('write module config probes have extended maxDuration', () {
      final probes = DiagnosticProbeRegistry.buildWriteProbes();
      final moduleWriteProbes = probes.where(
        (p) => p.name.startsWith('WriteModuleConfig_'),
      );
      for (final probe in moduleWriteProbes) {
        expect(
          probe.maxDuration,
          isNotNull,
          reason: '${probe.name} should have maxDuration set',
        );
        expect(
          probe.maxDuration!.inSeconds,
          greaterThanOrEqualTo(18),
          reason: '${probe.name} needs enough time for 3 BLE round-trips',
        );
      }
    });

    test('data-plane write probes have extended maxDuration', () {
      final probes = DiagnosticProbeRegistry.buildWriteProbes();
      final dataPlaneProbes = probes.where(
        (p) =>
            p.name == 'SelfMessageLoopback' ||
            p.name == 'MessageDeliveryAck' ||
            p.name == 'TracerouteSelf',
      );
      for (final probe in dataPlaneProbes) {
        expect(
          probe.maxDuration,
          isNotNull,
          reason: '${probe.name} should have maxDuration set',
        );
        expect(
          probe.maxDuration!.inSeconds,
          greaterThanOrEqualTo(12),
          reason: '${probe.name} needs time for firmware round-trip',
        );
      }
    });

    test('channel write probe has extended maxDuration', () {
      final probes = DiagnosticProbeRegistry.buildWriteProbes();
      final channelWrite = probes.firstWhere(
        (p) => p.name == 'WriteChannel_0_NoOp',
      );
      expect(channelWrite.maxDuration, isNotNull);
      expect(channelWrite.maxDuration!.inSeconds, greaterThanOrEqualTo(18));
    });
  });
}
