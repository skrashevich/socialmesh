// SPDX-License-Identifier: GPL-3.0-or-later

import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:socialmesh/services/protocol/sip/sip_constants.dart';
import 'package:socialmesh/services/protocol/sip/sip_messages_tx.dart';
import 'package:socialmesh/services/protocol/sip/sip_types.dart';

void main() {
  // ---------------------------------------------------------------------------
  // TX_START
  // ---------------------------------------------------------------------------
  group('SipTxMessages TX_START', () {
    test('encode/decode round-trip without mime/filename', () {
      final sha = Uint8List(32);
      for (var i = 0; i < 32; i++) {
        sha[i] = i;
      }

      final msg = SipTxStart(
        fileHash32: 0xDEADBEEF,
        totalLen: 4096,
        chunkSize: SipConstants.sipChunkSize,
        totalChunks: 20,
        fullSha256: sha,
      );

      final encoded = SipTxMessages.encodeTxStart(msg);
      final decoded = SipTxMessages.decodeTxStart(encoded);

      expect(decoded, isNotNull);
      expect(decoded!.fileHash32, equals(0xDEADBEEF));
      expect(decoded.totalLen, equals(4096));
      expect(decoded.chunkSize, equals(SipConstants.sipChunkSize));
      expect(decoded.totalChunks, equals(20));
      expect(decoded.mime, isNull);
      expect(decoded.filename, isNull);
      expect(decoded.fullSha256, equals(sha));
    });

    test('encode/decode round-trip with mime and filename', () {
      final sha = Uint8List.fromList(List.generate(32, (i) => 0xAA));

      final msg = SipTxStart(
        fileHash32: 0x12345678,
        totalLen: 8192,
        chunkSize: 207,
        totalChunks: 40,
        mime: 'text/plain',
        filename: 'hello.txt',
        fullSha256: sha,
      );

      final encoded = SipTxMessages.encodeTxStart(msg);
      final decoded = SipTxMessages.decodeTxStart(encoded);

      expect(decoded, isNotNull);
      expect(decoded!.fileHash32, equals(0x12345678));
      expect(decoded.totalLen, equals(8192));
      expect(decoded.mime, equals('text/plain'));
      expect(decoded.filename, equals('hello.txt'));
      expect(decoded.fullSha256, equals(sha));
    });

    test('decode rejects too-short payload', () {
      expect(SipTxMessages.decodeTxStart(Uint8List(10)), isNull);
    });

    test('decode rejects totalLen > maxTransferSize', () {
      final sha = Uint8List(32);
      final msg = SipTxStart(
        fileHash32: 0x01,
        totalLen: SipConstants.maxTransferSize + 1,
        chunkSize: 207,
        totalChunks: 50,
        fullSha256: sha,
      );
      final encoded = SipTxMessages.encodeTxStart(msg);
      expect(SipTxMessages.decodeTxStart(encoded), isNull);
    });
  });

  // ---------------------------------------------------------------------------
  // TX_CHUNK
  // ---------------------------------------------------------------------------
  group('SipTxMessages TX_CHUNK', () {
    test('encode/decode round-trip', () {
      final data = Uint8List.fromList(List.generate(100, (i) => i));
      final msg = SipTxChunk(
        fileHash32: 0xDEADBEEF,
        chunkIndex: 5,
        chunkLen: 100,
        chunkData: data,
      );

      final encoded = SipTxMessages.encodeTxChunk(msg);
      final decoded = SipTxMessages.decodeTxChunk(encoded);

      expect(decoded, isNotNull);
      expect(decoded!.fileHash32, equals(0xDEADBEEF));
      expect(decoded.chunkIndex, equals(5));
      expect(decoded.chunkLen, equals(100));
      expect(decoded.chunkData, equals(data));
    });

    test('encode/decode max-size chunk', () {
      final data = Uint8List(SipConstants.sipChunkSize);
      for (var i = 0; i < data.length; i++) {
        data[i] = i & 0xFF;
      }
      final msg = SipTxChunk(
        fileHash32: 0x11,
        chunkIndex: 0,
        chunkLen: SipConstants.sipChunkSize,
        chunkData: data,
      );

      final encoded = SipTxMessages.encodeTxChunk(msg);
      final decoded = SipTxMessages.decodeTxChunk(encoded);
      expect(decoded, isNotNull);
      expect(decoded!.chunkLen, equals(SipConstants.sipChunkSize));
      expect(decoded.chunkData, equals(data));
    });

    test('decode rejects too-short payload', () {
      expect(SipTxMessages.decodeTxChunk(Uint8List(4)), isNull);
    });

    test('decode rejects oversized chunk', () {
      // Create a chunk claiming to be larger than sipChunkSize
      final bd = ByteData(8 + SipConstants.sipChunkSize + 1);
      bd.setUint32(0, 0x11, Endian.little);
      bd.setUint16(4, 0, Endian.little);
      bd.setUint16(6, SipConstants.sipChunkSize + 1, Endian.little);

      expect(SipTxMessages.decodeTxChunk(bd.buffer.asUint8List()), isNull);
    });
  });

  // ---------------------------------------------------------------------------
  // TX_ACK
  // ---------------------------------------------------------------------------
  group('SipTxMessages TX_ACK', () {
    test('encode/decode round-trip', () {
      final bitmap = Uint8List.fromList([
        0x0F,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
        0x00,
      ]);
      final msg = SipTxAck(
        fileHash32: 0xDEADBEEF,
        highestContiguous: 3,
        receivedBitmap: bitmap,
      );

      final encoded = SipTxMessages.encodeTxAck(msg);
      final decoded = SipTxMessages.decodeTxAck(encoded);

      expect(decoded, isNotNull);
      expect(decoded!.fileHash32, equals(0xDEADBEEF));
      expect(decoded.highestContiguous, equals(3));
      expect(decoded.receivedBitmap, equals(bitmap));
    });

    test('encode/decode with empty bitmap', () {
      final msg = SipTxAck(
        fileHash32: 0x22,
        highestContiguous: 0,
        receivedBitmap: Uint8List(0),
      );

      final encoded = SipTxMessages.encodeTxAck(msg);
      final decoded = SipTxMessages.decodeTxAck(encoded);
      expect(decoded, isNotNull);
      expect(decoded!.receivedBitmap, isEmpty);
    });

    test('decode rejects too-short payload', () {
      expect(SipTxMessages.decodeTxAck(Uint8List(3)), isNull);
    });
  });

  // ---------------------------------------------------------------------------
  // TX_NACK
  // ---------------------------------------------------------------------------
  group('SipTxMessages TX_NACK', () {
    test('encode/decode round-trip', () {
      final deltas = Uint8List.fromList([2, 3, 1]);
      final msg = SipTxNack(
        fileHash32: 0xDEADBEEF,
        baseIndex: 10,
        missingCount: 3,
        missingIndicesDeltas: deltas,
      );

      final encoded = SipTxMessages.encodeTxNack(msg);
      final decoded = SipTxMessages.decodeTxNack(encoded);

      expect(decoded, isNotNull);
      expect(decoded!.fileHash32, equals(0xDEADBEEF));
      expect(decoded.baseIndex, equals(10));
      expect(decoded.missingCount, equals(3));
      expect(decoded.missingIndicesDeltas, equals(deltas));
    });

    test('decode rejects too-short payload', () {
      expect(SipTxMessages.decodeTxNack(Uint8List(4)), isNull);
    });
  });

  // ---------------------------------------------------------------------------
  // TX_DONE
  // ---------------------------------------------------------------------------
  group('SipTxMessages TX_DONE', () {
    test('encode/decode round-trip', () {
      final msg = SipTxDone(fileHash32: 0xDEADBEEF, totalLen: 8192);

      final encoded = SipTxMessages.encodeTxDone(msg);
      final decoded = SipTxMessages.decodeTxDone(encoded);

      expect(decoded, isNotNull);
      expect(decoded!.fileHash32, equals(0xDEADBEEF));
      expect(decoded.totalLen, equals(8192));
    });

    test('decode rejects too-short payload', () {
      expect(SipTxMessages.decodeTxDone(Uint8List(4)), isNull);
    });
  });

  // ---------------------------------------------------------------------------
  // TX_CANCEL
  // ---------------------------------------------------------------------------
  group('SipTxMessages TX_CANCEL', () {
    test('encode/decode round-trip for each reason', () {
      for (final reason in SipCancelReason.values) {
        final msg = SipTxCancel(fileHash32: 0xDEADBEEF, reason: reason);
        final encoded = SipTxMessages.encodeTxCancel(msg);
        final decoded = SipTxMessages.decodeTxCancel(encoded);

        expect(decoded, isNotNull, reason: 'Failed for ${reason.name}');
        expect(decoded!.fileHash32, equals(0xDEADBEEF));
        expect(decoded.reason, equals(reason));
      }
    });

    test('decode rejects too-short payload', () {
      expect(SipTxMessages.decodeTxCancel(Uint8List(2)), isNull);
    });

    test('decode rejects unknown reason code', () {
      final bd = ByteData(5);
      bd.setUint32(0, 0x11, Endian.little);
      bd.setUint8(4, 0xFF); // Unknown reason
      expect(SipTxMessages.decodeTxCancel(bd.buffer.asUint8List()), isNull);
    });
  });
}
