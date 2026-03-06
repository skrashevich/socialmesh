// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:socialmesh/features/admin/diagnostics/models/diagnostic_event.dart';

void main() {
  group('DiagnosticPhase', () {
    test('has all expected values', () {
      expect(DiagnosticPhase.values.length, 6);
      expect(DiagnosticPhase.values, contains(DiagnosticPhase.env));
      expect(DiagnosticPhase.values, contains(DiagnosticPhase.probe));
      expect(DiagnosticPhase.values, contains(DiagnosticPhase.packet));
      expect(DiagnosticPhase.values, contains(DiagnosticPhase.decode));
      expect(DiagnosticPhase.values, contains(DiagnosticPhase.assert_));
      expect(DiagnosticPhase.values, contains(DiagnosticPhase.error));
    });
  });

  group('PacketDirection', () {
    test('has all expected values', () {
      expect(PacketDirection.values.length, 3);
      expect(PacketDirection.values, contains(PacketDirection.tx));
      expect(PacketDirection.values, contains(PacketDirection.rx));
      expect(PacketDirection.values, contains(PacketDirection.internal));
    });
  });

  group('PacketEnvelope', () {
    test('serializes to JSON', () {
      const envelope = PacketEnvelope(
        id: 42,
        from: 0x12345678,
        to: 0xABCDEF00,
        wantAck: true,
        priority: 'RELIABLE',
        channel: 0,
        portnum: 'ADMIN_APP',
      );

      final json = envelope.toJson();

      expect(json['id'], 42);
      expect(json['from'], 0x12345678);
      expect(json['to'], 0xABCDEF00);
      expect(json['wantAck'], true);
      expect(json['priority'], 'RELIABLE');
      expect(json['channel'], 0);
      expect(json['portnum'], 'ADMIN_APP');
    });

    test('omits null optional fields', () {
      const envelope = PacketEnvelope(id: 1, from: 2, to: 3);

      final json = envelope.toJson();

      expect(json.containsKey('priority'), false);
      expect(json.containsKey('channel'), false);
      expect(json.containsKey('portnum'), false);
      expect(json['wantAck'], false);
    });

    test('round-trips through JSON', () {
      const original = PacketEnvelope(
        id: 99,
        from: 100,
        to: 200,
        wantAck: true,
        priority: 'ACK',
        channel: 1,
        portnum: 'TEXT_MESSAGE_APP',
      );

      final json = original.toJson();
      final restored = PacketEnvelope.fromJson(json);

      expect(restored.id, original.id);
      expect(restored.from, original.from);
      expect(restored.to, original.to);
      expect(restored.wantAck, original.wantAck);
      expect(restored.priority, original.priority);
      expect(restored.channel, original.channel);
      expect(restored.portnum, original.portnum);
    });
  });

  group('DecodedPayload', () {
    test('serializes to JSON', () {
      const payload = DecodedPayload(
        messageType: 'AdminMessage.getConfigResponse',
        json: {'key': 'value'},
      );

      final json = payload.toJson();

      expect(json['messageType'], 'AdminMessage.getConfigResponse');
      expect(json['json'], {'key': 'value'});
      expect(json.containsKey('error'), false);
    });

    test('includes error when present', () {
      const payload = DecodedPayload(
        messageType: 'AdminMessage',
        error: 'Decode failed',
      );

      final json = payload.toJson();

      expect(json['error'], 'Decode failed');
    });

    test('round-trips through JSON', () {
      const original = DecodedPayload(
        messageType: 'AdminMessage.getDeviceMetadataResponse',
        json: {'firmware': '2.5.0'},
      );

      final json = original.toJson();
      final restored = DecodedPayload.fromJson(json);

      expect(restored.messageType, original.messageType);
      expect(restored.json, original.json);
      expect(restored.error, isNull);
    });
  });

  group('DiagnosticEvent', () {
    test('serializes minimal event to Json', () {
      const event = DiagnosticEvent(
        seq: 0,
        ts: 1700000000000,
        phase: DiagnosticPhase.env,
      );

      final json = event.toJson();

      expect(json['seq'], 0);
      expect(json['ts'], 1700000000000);
      expect(json['phase'], 'env');
      expect(json.containsKey('probeName'), false);
      expect(json.containsKey('direction'), false);
      expect(json.containsKey('packet'), false);
    });

    test('serializes full event to JSON', () {
      const event = DiagnosticEvent(
        seq: 5,
        ts: 1700000001000,
        phase: DiagnosticPhase.packet,
        probeName: 'GetConfigProbe(DEVICE_CONFIG)',
        direction: PacketDirection.tx,
        packet: PacketEnvelope(
          id: 42,
          from: 100,
          to: 200,
          wantAck: false,
          portnum: 'ADMIN_APP',
        ),
        payloadB64: 'AQIDBA==',
        decoded: DecodedPayload(
          messageType: 'AdminMessage.getConfigRequest',
          json: {'configType': 'DEVICE_CONFIG'},
        ),
        notes: 'Config request sent',
      );

      final json = event.toJson();

      expect(json['seq'], 5);
      expect(json['phase'], 'packet');
      expect(json['probeName'], 'GetConfigProbe(DEVICE_CONFIG)');
      expect(json['direction'], 'tx');
      expect(json['packet'], isA<Map<String, dynamic>>());
      expect(json['payloadB64'], 'AQIDBA==');
      expect(json['decoded'], isA<Map<String, dynamic>>());
      expect(json['notes'], 'Config request sent');
    });

    test('produces stable NDJSON line', () {
      const event = DiagnosticEvent(
        seq: 0,
        ts: 1700000000000,
        phase: DiagnosticPhase.env,
        probeName: 'test',
      );

      final line = event.toNdjsonLine();

      // Should be valid JSON, single line
      expect(line.contains('\n'), false);
      final parsed = jsonDecode(line) as Map<String, dynamic>;
      expect(parsed['seq'], 0);
      expect(parsed['probeName'], 'test');
    });

    test('round-trips through JSON', () {
      const original = DiagnosticEvent(
        seq: 10,
        ts: 1700000005000,
        phase: DiagnosticPhase.probe,
        probeName: 'GetMyNodeInfoProbe',
        direction: PacketDirection.internal,
        notes: 'start',
      );

      final json = original.toJson();
      final restored = DiagnosticEvent.fromJson(json);

      expect(restored.seq, original.seq);
      expect(restored.ts, original.ts);
      expect(restored.phase, original.phase);
      expect(restored.probeName, original.probeName);
      expect(restored.direction, original.direction);
      expect(restored.notes, original.notes);
    });

    test('round-trips event with packet envelope', () {
      const original = DiagnosticEvent(
        seq: 3,
        ts: 1700000002000,
        phase: DiagnosticPhase.packet,
        direction: PacketDirection.rx,
        packet: PacketEnvelope(id: 77, from: 0xAA, to: 0xBB, wantAck: true),
        payloadB64: 'dGVzdA==',
      );

      final json = original.toJson();
      final restored = DiagnosticEvent.fromJson(json);

      expect(restored.packet, isNotNull);
      expect(restored.packet!.id, 77);
      expect(restored.packet!.from, 0xAA);
      expect(restored.packet!.to, 0xBB);
      expect(restored.packet!.wantAck, true);
      expect(restored.payloadB64, 'dGVzdA==');
    });

    test('round-trips event with decoded payload', () {
      const original = DiagnosticEvent(
        seq: 4,
        ts: 1700000003000,
        phase: DiagnosticPhase.decode,
        decoded: DecodedPayload(
          messageType: 'AdminMessage.getConfigResponse',
          json: {
            'loraConfig': {'region': 'US'},
          },
        ),
      );

      final json = original.toJson();
      final restored = DiagnosticEvent.fromJson(json);

      expect(restored.decoded, isNotNull);
      expect(restored.decoded!.messageType, 'AdminMessage.getConfigResponse');
      expect(restored.decoded!.json, isNotNull);
      expect((restored.decoded!.json!['loraConfig'] as Map)['region'], 'US');
    });
  });
}
