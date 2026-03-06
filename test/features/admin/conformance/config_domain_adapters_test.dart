// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)

import 'package:flutter_test/flutter_test.dart';
import 'package:socialmesh/features/admin/conformance/adapters/config_domain_adapters.dart';

void main() {
  group('ConfigDomainAdapters', () {
    test('buildAllAdapters returns 20 adapters', () {
      final adapters = buildAllAdapters();

      expect(adapters.length, 20);
    });

    test('buildAllAdapters has unique domain names', () {
      final adapters = buildAllAdapters();
      final names = adapters.map((a) => a.domainName).toSet();

      expect(names.length, adapters.length);
    });

    test('buildAllAdapters starts with core config adapters', () {
      final adapters = buildAllAdapters();

      expect(adapters[0].domainName, 'DEVICE_CONFIG');
      expect(adapters[1].domainName, 'LORA_CONFIG');
      expect(adapters[2].domainName, 'POSITION_CONFIG');
      expect(adapters[3].domainName, 'POWER_CONFIG');
      expect(adapters[4].domainName, 'NETWORK_CONFIG');
      expect(adapters[5].domainName, 'BLUETOOTH_CONFIG');
      expect(adapters[6].domainName, 'DISPLAY_CONFIG');
      expect(adapters[7].domainName, 'SECURITY_CONFIG');
    });

    test('buildAllAdapters includes all module config adapters', () {
      final adapters = buildAllAdapters();
      final names = adapters.map((a) => a.domainName).toList();

      expect(names, contains('MQTT_CONFIG'));
      expect(names, contains('TELEMETRY_CONFIG'));
      expect(names, contains('PAXCOUNTER_CONFIG'));
      expect(names, contains('SERIAL_CONFIG'));
      expect(names, contains('RANGETEST_CONFIG'));
      expect(names, contains('EXTNOTIF_CONFIG'));
      expect(names, contains('STOREFORWARD_CONFIG'));
      expect(names, contains('CANNEDMSG_CONFIG'));
      expect(names, contains('AMBIENTLIGHTING_CONFIG'));
      expect(names, contains('DETECTIONSENSOR_CONFIG'));
      expect(names, contains('TRAFFICMANAGEMENT_CONFIG'));
    });

    test('buildAllAdapters ends with channel adapter', () {
      final adapters = buildAllAdapters();
      final last = adapters.last;

      expect(last.domainName, 'CHANNEL_0');
      expect(last, isA<ChannelConfigAdapter>());
    });

    test('core config adapter count is 8', () {
      final adapters = buildAllAdapters();
      final coreNames = [
        'DEVICE_CONFIG',
        'LORA_CONFIG',
        'POSITION_CONFIG',
        'POWER_CONFIG',
        'NETWORK_CONFIG',
        'BLUETOOTH_CONFIG',
        'DISPLAY_CONFIG',
        'SECURITY_CONFIG',
      ];
      final coreAdapters = adapters
          .where((a) => coreNames.contains(a.domainName))
          .toList();

      expect(coreAdapters.length, 8);
    });

    test('module config adapter count is 11', () {
      final adapters = buildAllAdapters();
      final moduleNames = [
        'MQTT_CONFIG',
        'TELEMETRY_CONFIG',
        'PAXCOUNTER_CONFIG',
        'SERIAL_CONFIG',
        'RANGETEST_CONFIG',
        'EXTNOTIF_CONFIG',
        'STOREFORWARD_CONFIG',
        'CANNEDMSG_CONFIG',
        'AMBIENTLIGHTING_CONFIG',
        'DETECTIONSENSOR_CONFIG',
        'TRAFFICMANAGEMENT_CONFIG',
      ];
      final moduleAdapters = adapters
          .where((a) => moduleNames.contains(a.domainName))
          .toList();

      expect(moduleAdapters.length, 11);
    });

    test('ChannelConfigAdapter stores channel index', () {
      final adapter = ChannelConfigAdapter(channelIndex: 3);

      expect(adapter.domainName, 'CHANNEL_3');
    });

    test('DeviceConfigAdapter has correct domain name', () {
      expect(DeviceConfigAdapter().domainName, 'DEVICE_CONFIG');
    });

    test('DisplayConfigAdapter has correct domain name', () {
      expect(DisplayConfigAdapter().domainName, 'DISPLAY_CONFIG');
    });

    test('SecurityConfigAdapter has correct domain name', () {
      expect(SecurityConfigAdapter().domainName, 'SECURITY_CONFIG');
    });
  });
}
