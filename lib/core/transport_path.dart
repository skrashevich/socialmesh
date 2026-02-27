// SPDX-License-Identifier: GPL-3.0-or-later

/// Transport path classification for mesh packets.
///
/// Indicates how a packet/message arrived at this device. The Meshtastic
/// protobuf sets `via_mqtt = true` on MeshPacket when the packet passed
/// through an MQTT gateway at any point along its path. This is authoritative
/// metadata injected by firmware.
///
/// Classification rules:
///   - `rf`  — `via_mqtt` is explicitly **false** on the packet.
///   - `mqtt` — `via_mqtt` is explicitly **true** on the packet.
///   - `unknown` — No `via_mqtt` field present (legacy firmware, sent
///     messages, or packets where the field wasn't populated).
///
/// There is no "likelyMqtt" heuristic: Meshtastic firmware provides a
/// definitive boolean. When the field is absent, we report "Unknown"
/// rather than guessing.
///
/// See also: `protos/meshtastic/mesh.proto` field `via_mqtt` (tag 14) and
/// `protos/meshtastic/deviceonly.proto` field `via_mqtt` (tag 8).
enum TransportPath {
  /// Arrived exclusively via LoRa RF (no MQTT gateway in path).
  rf,

  /// Passed through an MQTT gateway at some point in its path.
  mqtt,

  /// Transport path is unknown (field not present or not applicable).
  unknown;

  /// Human-readable label for UI display.
  String get label {
    switch (this) {
      case TransportPath.rf:
        return 'RF';
      case TransportPath.mqtt:
        return 'MQTT';
      case TransportPath.unknown:
        return 'Unknown';
    }
  }

  /// Shorter label for compact chips.
  String get chipLabel {
    switch (this) {
      case TransportPath.rf:
        return 'RF';
      case TransportPath.mqtt:
        return 'MQTT';
      case TransportPath.unknown:
        return '—';
    }
  }
}

/// Classify transport path from the `via_mqtt` boolean on a packet.
///
/// - `null`  → [TransportPath.unknown] (field not present)
/// - `true`  → [TransportPath.mqtt]
/// - `false` → [TransportPath.rf]
TransportPath classifyTransport(bool? viaMqtt) {
  if (viaMqtt == null) return TransportPath.unknown;
  return viaMqtt ? TransportPath.mqtt : TransportPath.rf;
}
