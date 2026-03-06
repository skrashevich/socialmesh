// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)

/// Malformed and boundary-condition SIP frames for robustness testing.
///
/// Every case here must be handled gracefully by [SipCodec.decode]:
/// return null or generate an ERROR frame, never throw an exception.
library;

import 'dart:typed_data';

import 'sip_test_vectors.dart';

/// Fuzz cases for SIP codec robustness testing.
abstract final class SipFuzzCases {
  /// Empty input (0 bytes).
  static final Uint8List empty = Uint8List(0);

  /// Single byte.
  static final Uint8List oneByte = Uint8List.fromList([0x53]);

  /// Valid magic bytes but truncated (only 2 bytes).
  static final Uint8List magicOnly = Uint8List.fromList([0x53, 0x4D]);

  /// Invalid magic bytes.
  static final Uint8List invalidMagic = Uint8List.fromList([
    0xDE, 0xAD, 0x00, 0x01, 0x01, 0x00, 0x16, 0x00, //
    0x00, 0x00, 0x00, 0x00, 0x04, 0x03, 0x02, 0x01, //
    0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
  ]);

  /// Valid magic + truncated header (only 10 bytes, need 22).
  static final Uint8List truncatedHeader = Uint8List.fromList([
    0x53, 0x4D, 0x00, 0x01, 0x01, 0x00, 0x16, 0x00, //
    0x00, 0x00,
  ]);

  /// header_len < 22 (set to 10).
  static final Uint8List headerLenTooSmall = () {
    final data = Uint8List.fromList(SipTestVectors.rollcallReq);
    // Bytes 6-7 are header_len (LE). Set to 10 (0x000A).
    data[6] = 0x0A;
    data[7] = 0x00;
    return data;
  }();

  /// header_len > total data length.
  static final Uint8List headerLenExceedsData = () {
    final data = Uint8List.fromList(SipTestVectors.rollcallReq);
    // Set header_len to 100 (0x0064 LE).
    data[6] = 0x64;
    data[7] = 0x00;
    return data;
  }();

  /// payload_len > remaining bytes after header.
  static final Uint8List payloadLenExceedsRemaining = () {
    final data = Uint8List.fromList(SipTestVectors.rollcallReq);
    // Set payload_len to 100 (0x0064 LE) but data only has 0 payload bytes.
    data[20] = 0x64;
    data[21] = 0x00;
    return data;
  }();

  /// payload_len = 0 with trailing bytes (data longer than header + payload).
  static final Uint8List trailingBytesAfterPayload = () {
    final data = Uint8List(30);
    // Copy a valid ROLLCALL_REQ (22 bytes, payload_len=0).
    final src = SipTestVectors.rollcallReq;
    for (var i = 0; i < src.length; i++) {
      data[i] = src[i];
    }
    // Trailing garbage.
    for (var i = src.length; i < 30; i++) {
      data[i] = 0xFF;
    }
    return data;
  }();

  /// version_major = 255 (unsupported).
  static final Uint8List versionMajor255 = () {
    final data = Uint8List.fromList(SipTestVectors.rollcallReq);
    data[2] = 0xFF; // version_major
    return data;
  }();

  /// All-zero frame (22 bytes of zeroes).
  static final Uint8List allZero = Uint8List(22);

  /// Max-size frame (237 bytes, valid structure).
  static final Uint8List maxSize = () {
    final data = Uint8List(237);
    // Magic
    data[0] = 0x53;
    data[1] = 0x4D;
    // Version
    data[2] = 0x00;
    data[3] = 0x01;
    // msg_type: CAP_BEACON
    data[4] = 0x01;
    // flags
    data[5] = 0x00;
    // header_len: 22 (LE)
    data[6] = 0x16;
    data[7] = 0x00;
    // session_id: 0
    // nonce: 0x01020304
    data[12] = 0x04;
    data[13] = 0x03;
    data[14] = 0x02;
    data[15] = 0x01;
    // timestamp_s: 0
    // payload_len: 215 (0x00D7 LE)
    data[20] = 0xD7;
    data[21] = 0x00;
    // Fill payload with 0xAA.
    for (var i = 22; i < 237; i++) {
      data[i] = 0xAA;
    }
    return data;
  }();

  /// Frame exceeding MTU (238 bytes).
  static final Uint8List exceedsMtu = () {
    final data = Uint8List(238);
    data[0] = 0x53;
    data[1] = 0x4D;
    data[2] = 0x00;
    data[3] = 0x01;
    data[4] = 0x01;
    data[5] = 0x00;
    data[6] = 0x16;
    data[7] = 0x00;
    data[12] = 0x04;
    data[13] = 0x03;
    data[14] = 0x02;
    data[15] = 0x01;
    // payload_len: 216 (0x00D8 LE) -- exceeds SIP_MAX_PAYLOAD
    data[20] = 0xD8;
    data[21] = 0x00;
    for (var i = 22; i < 238; i++) {
      data[i] = 0xBB;
    }
    return data;
  }();

  /// Unknown msg_type (0xFE).
  static final Uint8List unknownMsgType = () {
    final data = Uint8List.fromList(SipTestVectors.rollcallReq);
    data[4] = 0xFE; // Unknown type
    return data;
  }();

  /// Random byte sequences (not SIP at all).
  static final Uint8List randomBytes = hexToBytes(
    'DE AD BE EF CA FE BA BE 01 23 45 67 89 AB CD EF'
    'FE DC BA 98 76 54 32 10',
  );
}
