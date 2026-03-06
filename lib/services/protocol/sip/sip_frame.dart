// SPDX-License-Identifier: GPL-3.0-or-later

/// SIP frame data class representing a parsed SIP protocol frame.
///
/// Holds all header fields plus the raw payload bytes. Instances are
/// produced by [SipCodec.decode] and consumed by [SipCodec.encode].
library;

import 'dart:typed_data';

import 'sip_types.dart';

/// A parsed TLV header extension entry.
class SipTlvEntry {
  /// TLV type code.
  final int type;

  /// TLV value bytes.
  final Uint8List value;

  const SipTlvEntry({required this.type, required this.value});

  /// Known TLV type, if recognized.
  SipTlvType? get knownType => SipTlvType.fromCode(type);

  @override
  String toString() =>
      'SipTlvEntry(type=0x${type.toRadixString(16)}, len=${value.length})';
}

/// A single SIP protocol frame.
///
/// The frame consists of a fixed 22-byte header, optional TLV header
/// extensions, and a message-type-specific payload.
class SipFrame {
  /// Protocol major version (byte 2).
  final int versionMajor;

  /// Protocol minor version (byte 3).
  final int versionMinor;

  /// Message type (byte 4).
  final SipMessageType msgType;

  /// Flags bitfield (byte 5).
  final int flags;

  /// Total header length in bytes (bytes 6-7, LE). Minimum 22.
  final int headerLen;

  /// Session context identifier (bytes 8-11, LE).
  /// 0 for discovery messages, handshake session_tag for sessions.
  final int sessionId;

  /// Random nonce for replay protection (bytes 12-15, LE).
  final int nonce;

  /// Unix timestamp in seconds (bytes 16-19, LE).
  final int timestampS;

  /// Payload length in bytes (bytes 20-21, LE).
  final int payloadLen;

  /// Parsed TLV header extensions (empty if no extensions present).
  final List<SipTlvEntry> headerExtensions;

  /// Message-type-specific payload bytes.
  final Uint8List payload;

  const SipFrame({
    required this.versionMajor,
    required this.versionMinor,
    required this.msgType,
    required this.flags,
    required this.headerLen,
    required this.sessionId,
    required this.nonce,
    required this.timestampS,
    required this.payloadLen,
    this.headerExtensions = const [],
    required this.payload,
  });

  /// Whether the HAS_SIGNATURE flag is set.
  bool get hasSignature => (flags & SipFlags.hasSignature) != 0;

  /// Whether the HAS_HEADER_EXT flag is set.
  bool get hasHeaderExt => (flags & SipFlags.hasHeaderExt) != 0;

  /// Whether the ACK_REQUIRED flag is set.
  bool get ackRequired => (flags & SipFlags.ackRequired) != 0;

  /// Whether the IS_RESPONSE flag is set.
  bool get isResponse => (flags & SipFlags.isResponse) != 0;

  /// Look up a TLV extension by known type.
  SipTlvEntry? findExtension(SipTlvType type) {
    for (final ext in headerExtensions) {
      if (ext.type == type.code) return ext;
    }
    return null;
  }

  @override
  String toString() =>
      'SipFrame(v$versionMajor.$versionMinor, '
      'type=${msgType.name}(0x${msgType.code.toRadixString(16)}), '
      'flags=0x${flags.toRadixString(16)}, '
      'hdrLen=$headerLen, '
      'sid=0x${sessionId.toRadixString(16)}, '
      'nonce=0x${nonce.toRadixString(16)}, '
      'ts=$timestampS, '
      'payloadLen=$payloadLen)';
}
