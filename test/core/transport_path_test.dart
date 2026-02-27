// SPDX-License-Identifier: GPL-3.0-or-later
import 'package:flutter_test/flutter_test.dart';
import 'package:socialmesh/core/transport_path.dart';

void main() {
  group('classifyTransport', () {
    test('null returns unknown', () {
      expect(classifyTransport(null), TransportPath.unknown);
    });

    test('true returns mqtt', () {
      expect(classifyTransport(true), TransportPath.mqtt);
    });

    test('false returns rf', () {
      expect(classifyTransport(false), TransportPath.rf);
    });
  });

  group('TransportPath.label', () {
    test('rf label is RF', () {
      expect(TransportPath.rf.label, 'RF');
    });

    test('mqtt label is MQTT', () {
      expect(TransportPath.mqtt.label, 'MQTT');
    });

    test('unknown label is Unknown', () {
      expect(TransportPath.unknown.label, 'Unknown');
    });
  });

  group('TransportPath.chipLabel', () {
    test('rf chipLabel is RF', () {
      expect(TransportPath.rf.chipLabel, 'RF');
    });

    test('mqtt chipLabel is MQTT', () {
      expect(TransportPath.mqtt.chipLabel, 'MQTT');
    });

    test('unknown chipLabel is dash', () {
      expect(TransportPath.unknown.chipLabel, '—');
    });
  });
}
