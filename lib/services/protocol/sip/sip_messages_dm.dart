// SPDX-License-Identifier: GPL-3.0-or-later

/// SIP DM_MSG message encode/decode.
///
/// DM messages carry UTF-8 text scoped to a session_tag from a
/// completed SIP-1 handshake. The session_tag is carried in the
/// SIP frame header's session_id field, not the payload.
///
/// Payload layout:
///   bytes 0..N: UTF-8 text content (max [SipDmConstants.maxDmTextBytes])
library;

import 'dart:convert';
import 'dart:typed_data';

import '../../../core/logging.dart';
import 'sip_constants.dart';

/// DM-specific constants.
abstract final class SipDmConstants {
  /// Maximum UTF-8 bytes for a DM text payload.
  ///
  /// The SIP frame header is [SipConstants.sipWrapperMin] = 22 bytes.
  /// SIP_MTU_APP = 237 bytes. So max payload = 215 bytes.
  /// We cap DM text at 180 bytes to leave headroom for future
  /// envelope fields (e.g. sequence number, flags).
  static const int maxDmTextBytes = 180;
}

/// A parsed DM message.
class SipDmMessage {
  /// UTF-8 text content.
  final String text;

  /// Raw payload bytes (the encoded UTF-8).
  final Uint8List rawPayload;

  const SipDmMessage({required this.text, required this.rawPayload});

  @override
  String toString() => 'SipDmMessage(text=${text.length} chars)';
}

/// Encode/decode helpers for DM_MSG payloads.
abstract final class SipDmMessages {
  /// Encode a DM text message into a payload [Uint8List].
  ///
  /// Returns null if the text exceeds [SipDmConstants.maxDmTextBytes]
  /// after UTF-8 encoding, or if the text is empty.
  static Uint8List? encodeDm(String text) {
    if (text.isEmpty) {
      AppLogging.sip('SIP_DM: encode rejected: empty text');
      return null;
    }

    final encoded = utf8.encode(text);
    if (encoded.length > SipDmConstants.maxDmTextBytes) {
      AppLogging.sip(
        'SIP_DM: encode rejected: ${encoded.length}B > '
        '${SipDmConstants.maxDmTextBytes}B max',
      );
      return null;
    }

    return Uint8List.fromList(encoded);
  }

  /// Decode a DM payload into a [SipDmMessage].
  ///
  /// Returns null if the payload is empty or not valid UTF-8.
  static SipDmMessage? decodeDm(Uint8List payload) {
    if (payload.isEmpty) {
      AppLogging.sip('SIP_DM: decode rejected: empty payload');
      return null;
    }

    if (payload.length > SipDmConstants.maxDmTextBytes) {
      AppLogging.sip(
        'SIP_DM: decode rejected: ${payload.length}B > '
        '${SipDmConstants.maxDmTextBytes}B max',
      );
      return null;
    }

    try {
      final text = utf8.decode(payload);
      return SipDmMessage(text: text, rawPayload: Uint8List.fromList(payload));
    } on FormatException {
      AppLogging.sip('SIP_DM: decode rejected: invalid UTF-8');
      return null;
    }
  }

  /// Calculate the UTF-8 byte length of a string without allocating
  /// the full encoded buffer. Useful for pre-flight size checks.
  static int utf8ByteLength(String text) => utf8.encode(text).length;
}
