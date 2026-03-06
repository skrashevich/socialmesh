// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)
import 'dart:convert';

/// Phase of the diagnostic event.
enum DiagnosticPhase { env, probe, packet, decode, assert_, error }

/// Direction of a packet event.
enum PacketDirection { tx, rx, internal }

/// Envelope metadata extracted from a MeshPacket.
class PacketEnvelope {
  final int id;
  final int from;
  final int to;
  final bool wantAck;
  final String? priority;
  final int? channel;
  final String? portnum;

  const PacketEnvelope({
    required this.id,
    required this.from,
    required this.to,
    this.wantAck = false,
    this.priority,
    this.channel,
    this.portnum,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'from': from,
    'to': to,
    'wantAck': wantAck,
    if (priority != null) 'priority': priority,
    if (channel != null) 'channel': channel,
    if (portnum != null) 'portnum': portnum,
  };

  factory PacketEnvelope.fromJson(Map<String, dynamic> json) => PacketEnvelope(
    id: json['id'] as int,
    from: json['from'] as int,
    to: json['to'] as int,
    wantAck: json['wantAck'] as bool? ?? false,
    priority: json['priority'] as String?,
    channel: json['channel'] as int?,
    portnum: json['portnum'] as String?,
  );
}

/// Decoded protobuf payload information.
class DecodedPayload {
  final String? messageType;
  final Map<String, dynamic>? json;
  final String? error;

  const DecodedPayload({this.messageType, this.json, this.error});

  Map<String, dynamic> toJson() => {
    if (messageType != null) 'messageType': messageType,
    if (json != null) 'json': json,
    if (error != null) 'error': error,
  };

  factory DecodedPayload.fromJson(Map<String, dynamic> j) => DecodedPayload(
    messageType: j['messageType'] as String?,
    json: j['json'] as Map<String, dynamic>?,
    error: j['error'] as String?,
  );
}

/// A single diagnostic event — one NDJSON line.
class DiagnosticEvent {
  final int seq;
  final int ts;
  final DiagnosticPhase phase;
  final String? probeName;
  final PacketDirection? direction;
  final PacketEnvelope? packet;
  final String? payloadB64;
  final DecodedPayload? decoded;
  final String? notes;

  const DiagnosticEvent({
    required this.seq,
    required this.ts,
    required this.phase,
    this.probeName,
    this.direction,
    this.packet,
    this.payloadB64,
    this.decoded,
    this.notes,
  });

  /// Serialize to a single-line JSON string (NDJSON).
  String toNdjsonLine() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => {
    'seq': seq,
    'ts': ts,
    'phase': phase.name,
    if (probeName != null) 'probeName': probeName,
    if (direction != null) 'direction': direction!.name,
    if (packet != null) 'packet': packet!.toJson(),
    if (payloadB64 != null) 'payloadB64': payloadB64,
    if (decoded != null) 'decoded': decoded!.toJson(),
    if (notes != null) 'notes': notes,
  };

  factory DiagnosticEvent.fromJson(
    Map<String, dynamic> json,
  ) => DiagnosticEvent(
    seq: json['seq'] as int,
    ts: json['ts'] as int,
    phase: DiagnosticPhase.values.firstWhere((e) => e.name == json['phase']),
    probeName: json['probeName'] as String?,
    direction: json['direction'] != null
        ? PacketDirection.values.firstWhere((e) => e.name == json['direction'])
        : null,
    packet: json['packet'] != null
        ? PacketEnvelope.fromJson(json['packet'] as Map<String, dynamic>)
        : null,
    payloadB64: json['payloadB64'] as String?,
    decoded: json['decoded'] != null
        ? DecodedPayload.fromJson(json['decoded'] as Map<String, dynamic>)
        : null,
    notes: json['notes'] as String?,
  );
}
