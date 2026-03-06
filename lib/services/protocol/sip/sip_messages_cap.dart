// SPDX-License-Identifier: GPL-3.0-or-later

/// SIP-0 capability message payload encode/decode.
///
/// Handles CAP_BEACON, CAP_REQ, CAP_RESP, ROLLCALL_REQ, and
/// ROLLCALL_RESP payload serialization.
library;

import 'dart:typed_data';

import '../../../core/logging.dart';
import 'sip_constants.dart';
import 'sip_types.dart';

/// Decoded CAP_BEACON payload (10 bytes).
class SipCapBeacon {
  final int features;
  final int deviceClass;
  final int maxProtoMinor;
  final int mtuHint;
  final int rxWindowS;

  const SipCapBeacon({
    required this.features,
    required this.deviceClass,
    required this.maxProtoMinor,
    required this.mtuHint,
    required this.rxWindowS,
  });

  /// Create a default beacon for this device.
  factory SipCapBeacon.local() => SipCapBeacon(
    features: SipFeatureBits.allV01,
    deviceClass: SipConstants.deviceClassPhoneApp,
    maxProtoMinor: SipConstants.sipVersionMinor,
    mtuHint: SipConstants.sipMaxPayload,
    rxWindowS: SipConstants.defaultRxWindowS,
  );
}

/// Decoded ROLLCALL_RESP payload (same format as CAP_BEACON + caps_hash).
class SipRollcallResp {
  final SipCapBeacon capabilities;
  final int capsHash;

  const SipRollcallResp({required this.capabilities, required this.capsHash});
}

/// Encode/decode SIP-0 message payloads.
abstract final class SipCapMessages {
  // ---------------------------------------------------------------------------
  // CAP_BEACON (10 bytes)
  // ---------------------------------------------------------------------------

  /// Encode a [SipCapBeacon] into a 10-byte payload.
  static Uint8List encodeCapBeacon(SipCapBeacon beacon) {
    final data = ByteData(SipConstants.capBeaconPayloadSize);
    data.setUint16(0, beacon.features, Endian.little);
    data.setUint8(2, beacon.deviceClass);
    data.setUint8(3, beacon.maxProtoMinor);
    data.setUint16(4, beacon.mtuHint, Endian.little);
    data.setUint16(6, beacon.rxWindowS, Endian.little);
    data.setUint16(8, 0, Endian.little); // reserved
    return data.buffer.asUint8List();
  }

  /// Decode a CAP_BEACON payload. Returns null on invalid data.
  static SipCapBeacon? decodeCapBeacon(Uint8List payload) {
    if (payload.length < SipConstants.capBeaconPayloadSize) {
      AppLogging.sip(
        'SIP_CAP: CAP_BEACON decode failed: payload too short '
        '(${payload.length} < ${SipConstants.capBeaconPayloadSize})',
      );
      return null;
    }
    final bd = ByteData.sublistView(payload);
    return SipCapBeacon(
      features: bd.getUint16(0, Endian.little),
      deviceClass: bd.getUint8(2),
      maxProtoMinor: bd.getUint8(3),
      mtuHint: bd.getUint16(4, Endian.little),
      rxWindowS: bd.getUint16(6, Endian.little),
    );
  }

  // ---------------------------------------------------------------------------
  // ROLLCALL_REQ (0 bytes payload -- empty)
  // ---------------------------------------------------------------------------

  /// Encode a ROLLCALL_REQ (empty payload).
  static Uint8List encodeRollcallReq() => Uint8List(0);

  // ---------------------------------------------------------------------------
  // ROLLCALL_RESP (12 bytes: beacon + caps_hash)
  // ---------------------------------------------------------------------------

  /// Encode a ROLLCALL_RESP: beacon capabilities (10 bytes) + caps_hash (2 bytes).
  static Uint8List encodeRollcallResp(SipRollcallResp resp) {
    final beacon = encodeCapBeacon(resp.capabilities);
    final data = ByteData(12);
    for (var i = 0; i < 10; i++) {
      data.setUint8(i, beacon[i]);
    }
    data.setUint16(10, resp.capsHash & 0xFFFF, Endian.little);
    return data.buffer.asUint8List();
  }

  /// Decode a ROLLCALL_RESP payload. Returns null on invalid data.
  static SipRollcallResp? decodeRollcallResp(Uint8List payload) {
    if (payload.length < 12) {
      AppLogging.sip(
        'SIP_CAP: ROLLCALL_RESP decode failed: payload too short '
        '(${payload.length} < 12)',
      );
      return null;
    }
    final beacon = decodeCapBeacon(payload);
    if (beacon == null) return null;
    final bd = ByteData.sublistView(payload);
    final capsHash = bd.getUint16(10, Endian.little);
    return SipRollcallResp(capabilities: beacon, capsHash: capsHash);
  }

  /// Compute a simple caps_hash from a beacon's features + version.
  static int computeCapsHash(SipCapBeacon beacon) {
    var hash = beacon.features & 0xFFFF;
    hash ^= (beacon.maxProtoMinor << 8) | beacon.deviceClass;
    return hash & 0xFFFF;
  }
}
