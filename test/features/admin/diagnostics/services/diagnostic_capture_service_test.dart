// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:socialmesh/features/admin/diagnostics/models/diagnostic_event.dart';
import 'package:socialmesh/features/admin/diagnostics/services/diagnostic_capture_service.dart';
import 'package:socialmesh/generated/meshtastic/mesh.pb.dart' as pb;
import 'package:socialmesh/generated/meshtastic/portnums.pbenum.dart' as pn;
import 'package:socialmesh/generated/meshtastic/admin.pb.dart' as admin;

void main() {
  group('DiagnosticCaptureService', () {
    late DiagnosticCaptureService capture;

    setUp(() {
      capture = DiagnosticCaptureService();
    });

    test('starts inactive', () {
      expect(capture.isActive, false);
      expect(capture.events, isEmpty);
    });

    test('start activates capture', () {
      capture.start();
      expect(capture.isActive, true);
    });

    test('stop deactivates capture', () {
      capture.start();
      capture.stop();
      expect(capture.isActive, false);
    });

    test('does not record events when inactive', () {
      capture.recordInternal(phase: DiagnosticPhase.env, probeName: 'test');
      expect(capture.events, isEmpty);
    });

    test('records internal events when active', () {
      capture.start();
      capture.recordInternal(
        phase: DiagnosticPhase.probe,
        probeName: 'GetMyNodeInfoProbe',
        notes: 'start',
      );

      expect(capture.events.length, 1);
      expect(capture.events.first.phase, DiagnosticPhase.probe);
      expect(capture.events.first.probeName, 'GetMyNodeInfoProbe');
      expect(capture.events.first.direction, PacketDirection.internal);
      expect(capture.events.first.notes, 'start');
    });

    test('internal events get sequential seq numbers', () {
      capture.start();
      capture.recordInternal(phase: DiagnosticPhase.env, probeName: 'A');
      capture.recordInternal(phase: DiagnosticPhase.env, probeName: 'B');
      capture.recordInternal(phase: DiagnosticPhase.env, probeName: 'C');

      expect(capture.events[0].seq, 0);
      expect(capture.events[1].seq, 1);
      expect(capture.events[2].seq, 2);
    });

    test('records TX event with envelope and base64', () {
      capture.start();

      final packet = pb.MeshPacket()
        ..id = 42
        ..from = 0x100
        ..to = 0x200
        ..wantAck = true
        ..decoded = (pb.Data()
          ..portnum = pn.PortNum.ADMIN_APP
          ..payload = admin.AdminMessage().writeToBuffer());

      final rawBytes = packet.writeToBuffer();

      capture.recordTx(
        packet: packet,
        rawBytes: rawBytes,
        probeName: 'TestProbe',
      );

      expect(capture.events.length, 1);
      final event = capture.events.first;
      expect(event.direction, PacketDirection.tx);
      expect(event.packet, isNotNull);
      expect(event.packet!.id, 42);
      expect(event.packet!.from, 0x100);
      expect(event.packet!.to, 0x200);
      expect(event.packet!.wantAck, true);
      expect(event.packet!.portnum, 'ADMIN_APP');
      expect(event.payloadB64, isNotNull);
      expect(event.payloadB64!.isNotEmpty, true);
      // Verify base64 is valid
      expect(() => base64Decode(event.payloadB64!), returnsNormally);
    });

    test('records RX event and correlates with TX', () {
      capture.start();

      // Send a TX packet
      final txPacket = pb.MeshPacket()
        ..id = 99
        ..from = 0x100
        ..to = 0x200
        ..decoded = (pb.Data()
          ..portnum = pn.PortNum.ADMIN_APP
          ..payload = admin.AdminMessage().writeToBuffer());

      capture.recordTx(
        packet: txPacket,
        rawBytes: txPacket.writeToBuffer(),
        probeName: 'CorrelationTest',
      );

      // Receive a correlated RX packet
      final rxPacket = pb.MeshPacket()
        ..id = 99
        ..from = 0x200
        ..to = 0x100
        ..decoded = (pb.Data()
          ..portnum = pn.PortNum.ADMIN_APP
          ..payload = admin.AdminMessage().writeToBuffer());

      capture.recordRx(
        packet: rxPacket,
        rawBytes: rxPacket.writeToBuffer(),
        targetNodeNum: 0x200,
      );

      expect(capture.events.length, 2);

      // TX event
      expect(capture.events[0].direction, PacketDirection.tx);
      expect(capture.events[0].probeName, 'CorrelationTest');

      // RX event should be correlated
      expect(capture.events[1].direction, PacketDirection.rx);
      expect(capture.events[1].probeName, 'CorrelationTest');
    });

    test('notes unexpected source in RX event', () {
      capture.start();

      final packet = pb.MeshPacket()
        ..id = 55
        ..from = 0xDEAD
        ..to = 0x100
        ..decoded = (pb.Data()..portnum = pn.PortNum.ADMIN_APP);

      capture.recordRx(
        packet: packet,
        rawBytes: packet.writeToBuffer(),
        targetNodeNum: 0xBEEF, // Expected source
      );

      expect(capture.events.length, 1);
      expect(capture.events.first.notes, isNotNull);
      expect(capture.events.first.notes!, contains('Unexpected source'));
      expect(capture.events.first.notes!, contains('dead'));
      expect(capture.events.first.notes!, contains('beef'));
    });

    test('does not note unexpected source when sources match', () {
      capture.start();

      final packet = pb.MeshPacket()
        ..id = 55
        ..from = 0xBEEF
        ..to = 0x100
        ..decoded = (pb.Data()..portnum = pn.PortNum.ADMIN_APP);

      capture.recordRx(
        packet: packet,
        rawBytes: packet.writeToBuffer(),
        targetNodeNum: 0xBEEF,
      );

      expect(capture.events.first.notes, isNull);
    });

    test('toNdjson produces valid NDJSON', () {
      capture.start();
      capture.recordInternal(
        phase: DiagnosticPhase.env,
        probeName: 'A',
        notes: 'first',
      );
      capture.recordInternal(
        phase: DiagnosticPhase.probe,
        probeName: 'B',
        notes: 'second',
      );

      final ndjson = capture.toNdjson();
      final lines = ndjson
          .trim()
          .split('\n')
          .where((l) => l.isNotEmpty)
          .toList();

      expect(lines.length, 2);

      // Each line should be valid JSON
      for (final line in lines) {
        final parsed = jsonDecode(line);
        expect(parsed, isA<Map<String, dynamic>>());
      }

      final first = jsonDecode(lines.first) as Map<String, dynamic>;
      expect(first['probeName'], 'A');
      expect(first['notes'], 'first');
    });

    test('toFilteredLog produces readable log', () {
      capture.start();
      capture.recordInternal(
        phase: DiagnosticPhase.env,
        probeName: 'EnvProbe',
        notes: 'started',
      );

      final log = capture.toFilteredLog();

      expect(log, contains('ENV'));
      expect(log, contains('INTERNAL'));
      expect(log, contains('EnvProbe'));
    });

    test('start clears previous events', () {
      capture.start();
      capture.recordInternal(phase: DiagnosticPhase.env, probeName: 'old');
      expect(capture.events.length, 1);

      capture.start(); // restart
      expect(capture.events, isEmpty);
    });

    test('records decoded payload for internal events', () {
      capture.start();
      capture.recordInternal(
        phase: DiagnosticPhase.env,
        probeName: 'test',
        decoded: const DecodedPayload(
          messageType: 'DiagnosticRun',
          json: {'runId': 'test_001'},
        ),
      );

      expect(capture.events.first.decoded, isNotNull);
      expect(capture.events.first.decoded!.messageType, 'DiagnosticRun');
    });

    test('recordEvent works when active', () {
      capture.start();
      const event = DiagnosticEvent(
        seq: 0,
        ts: 1700000000000,
        phase: DiagnosticPhase.env,
      );
      capture.recordEvent(event);
      expect(capture.events.length, 1);
    });

    test('recordEvent does nothing when inactive', () {
      const event = DiagnosticEvent(
        seq: 0,
        ts: 1700000000000,
        phase: DiagnosticPhase.env,
      );
      capture.recordEvent(event);
      expect(capture.events, isEmpty);
    });

    test('events list is unmodifiable', () {
      capture.start();
      capture.recordInternal(phase: DiagnosticPhase.env, probeName: 'test');
      expect(
        () => capture.events.add(
          const DiagnosticEvent(seq: 99, ts: 0, phase: DiagnosticPhase.error),
        ),
        throwsA(isA<UnsupportedError>()),
      );
    });
  });
}
