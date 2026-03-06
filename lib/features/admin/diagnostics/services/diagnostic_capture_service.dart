// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)
import 'dart:convert';

import '../../../../core/logging.dart';
import '../../../../generated/meshtastic/mesh.pb.dart' as pb;
import '../../../../generated/meshtastic/portnums.pbenum.dart' as pn;
import '../../../../generated/meshtastic/admin.pb.dart' as admin;
import '../models/diagnostic_event.dart';

/// Lightweight packet capture layer for diagnostic sessions.
///
/// Instruments ProtocolService at the narrowest choke points:
/// - TX: after building a MeshPacket, before transport send
/// - RX: after decoding an incoming MeshPacket
///
/// Events are recorded to an in-memory list and correlated by packet ID.
class DiagnosticCaptureService {
  final List<DiagnosticEvent> _events = [];
  int _seq = 0;
  bool _active = false;

  /// Correlation map: packetId -> { probeName, txTimestamp, targetNode }
  final Map<int, _PendingCorrelation> _pending = {};

  /// Whether capture is actively recording.
  bool get isActive => _active;

  /// All recorded events.
  List<DiagnosticEvent> get events => List.unmodifiable(_events);

  /// Start a capture session.
  void start() {
    _events.clear();
    _seq = 0;
    _pending.clear();
    _active = true;
    AppLogging.adminDiag('Capture started');
  }

  /// Stop the capture session.
  void stop() {
    _active = false;
    AppLogging.adminDiag('Capture stopped. ${_events.length} events recorded');
  }

  /// Record an arbitrary event.
  void recordEvent(DiagnosticEvent event) {
    if (!_active) return;
    _events.add(event);
  }

  /// Record a TX event when sending a packet.
  ///
  /// [packet] is the MeshPacket about to be sent.
  /// [rawBytes] are the serialized protobuf bytes (pre-framing).
  /// [probeName] is the diagnostic probe that initiated this send.
  void recordTx({
    required pb.MeshPacket packet,
    required List<int> rawBytes,
    String? probeName,
  }) {
    if (!_active) return;

    final envelope = _extractEnvelope(packet);
    final payloadB64 = base64Encode(rawBytes);
    final decoded = _tryDecodeAdminPayload(packet);

    final event = DiagnosticEvent(
      seq: _seq++,
      ts: DateTime.now().millisecondsSinceEpoch,
      phase: DiagnosticPhase.packet,
      probeName: probeName,
      direction: PacketDirection.tx,
      packet: envelope,
      payloadB64: payloadB64,
      decoded: decoded,
    );

    _events.add(event);

    // Store correlation
    if (packet.id != 0) {
      _pending[packet.id] = _PendingCorrelation(
        probeName: probeName,
        txTimestamp: event.ts,
        targetNode: packet.to,
      );
    }

    AppLogging.adminDiag(
      'TX seq=${event.seq} id=${packet.id} to=0x${packet.to.toRadixString(16)}'
      '${probeName != null ? " probe=$probeName" : ""}',
    );
  }

  /// Record an RX event when receiving a packet.
  ///
  /// [packet] is the decoded MeshPacket received.
  /// [rawBytes] are the raw bytes that were decoded.
  /// [targetNodeNum] is the expected source node for the active probe.
  void recordRx({
    required pb.MeshPacket packet,
    required List<int> rawBytes,
    int? targetNodeNum,
  }) {
    if (!_active) return;

    final envelope = _extractEnvelope(packet);
    final payloadB64 = base64Encode(rawBytes);
    final decoded = _tryDecodeAdminPayload(packet);

    // Correlate with pending TX
    String? probeName;
    final correlation = _pending[packet.id];
    if (correlation != null) {
      probeName = correlation.probeName;
    }

    // Check if this RX is from an unexpected source
    String? notes;
    if (targetNodeNum != null && packet.from != targetNodeNum) {
      notes =
          'Unexpected source: expected 0x${targetNodeNum.toRadixString(16)}, '
          'got 0x${packet.from.toRadixString(16)}';
    }

    final event = DiagnosticEvent(
      seq: _seq++,
      ts: DateTime.now().millisecondsSinceEpoch,
      phase: DiagnosticPhase.packet,
      probeName: probeName,
      direction: PacketDirection.rx,
      packet: envelope,
      payloadB64: payloadB64,
      decoded: decoded,
      notes: notes,
    );

    _events.add(event);

    AppLogging.adminDiag(
      'RX seq=${event.seq} id=${packet.id} from=0x${packet.from.toRadixString(16)}'
      '${probeName != null ? " probe=$probeName" : ""}'
      '${notes != null ? " [$notes]" : ""}',
    );
  }

  /// Record an internal event (probe lifecycle, assertions, etc.).
  void recordInternal({
    required DiagnosticPhase phase,
    required String probeName,
    String? notes,
    DecodedPayload? decoded,
  }) {
    if (!_active) return;

    final event = DiagnosticEvent(
      seq: _seq++,
      ts: DateTime.now().millisecondsSinceEpoch,
      phase: phase,
      probeName: probeName,
      direction: PacketDirection.internal,
      decoded: decoded,
      notes: notes,
    );

    _events.add(event);
  }

  /// Get latency between TX and RX for a given packet ID.
  int? getLatencyMs(int packetId) {
    final correlation = _pending[packetId];
    if (correlation == null) return null;

    // Find the RX event for this packet ID
    final rxEvent = _events.where(
      (e) => e.direction == PacketDirection.rx && e.packet?.id == packetId,
    );
    if (rxEvent.isEmpty) return null;

    return rxEvent.first.ts - correlation.txTimestamp;
  }

  /// Produce NDJSON content from all events.
  String toNdjson() {
    final buffer = StringBuffer();
    for (final event in _events) {
      buffer.writeln(event.toNdjsonLine());
    }
    return buffer.toString();
  }

  /// Produce filtered log lines (Protocol: and AdminDiag: prefixed).
  String toFilteredLog() {
    final buffer = StringBuffer();
    for (final event in _events) {
      final line =
          '[${DateTime.fromMillisecondsSinceEpoch(event.ts).toIso8601String()}] '
          '${event.phase.name.toUpperCase()} '
          '${event.direction?.name.toUpperCase() ?? ""} '
          '${event.probeName ?? ""} '
          '${event.notes ?? ""}';
      buffer.writeln(line.trimRight());
    }
    return buffer.toString();
  }

  // --- Private helpers ---

  PacketEnvelope _extractEnvelope(pb.MeshPacket packet) {
    String? portnum;
    if (packet.hasDecoded() &&
        packet.decoded.portnum != pn.PortNum.UNKNOWN_APP) {
      portnum = packet.decoded.portnum.name;
    }

    return PacketEnvelope(
      id: packet.id,
      from: packet.from,
      to: packet.to,
      wantAck: packet.wantAck,
      priority: packet.priority.name,
      channel: packet.channel,
      portnum: portnum,
    );
  }

  DecodedPayload? _tryDecodeAdminPayload(pb.MeshPacket packet) {
    if (!packet.hasDecoded()) return null;
    final data = packet.decoded;
    if (data.portnum != pn.PortNum.ADMIN_APP) {
      return DecodedPayload(
        messageType: data.portnum.name,
        json: {'payloadLength': data.payload.length},
      );
    }

    try {
      final adminMsg = admin.AdminMessage.fromBuffer(data.payload);
      final variant = adminMsg.whichPayloadVariant().name;
      return DecodedPayload(
        messageType: 'AdminMessage.$variant',
        json: _adminToMap(adminMsg),
      );
    } catch (e) {
      return DecodedPayload(
        messageType: 'AdminMessage',
        error: 'Decode failed: $e',
      );
    }
  }

  Map<String, dynamic> _adminToMap(admin.AdminMessage msg) {
    try {
      // Use protobuf's JSON serialization
      return msg.toProto3Json() as Map<String, dynamic>? ?? {};
    } catch (_) {
      return {'variant': msg.whichPayloadVariant().name};
    }
  }
}

class _PendingCorrelation {
  final String? probeName;
  final int txTimestamp;
  final int targetNode;

  _PendingCorrelation({
    this.probeName,
    required this.txTimestamp,
    required this.targetNode,
  });
}
