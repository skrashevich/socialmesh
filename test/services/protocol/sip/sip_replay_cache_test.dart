// SPDX-License-Identifier: GPL-3.0-or-later

import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:socialmesh/services/protocol/sip/sip_replay_cache.dart';

void main() {
  group('SipReplayCache', () {
    late SipReplayCache cache;

    setUp(() {
      cache = SipReplayCache();
    });

    test('allows first nonce', () {
      expect(cache.isReplay(nodeId: 1, msgType: 0x01, nonce: 100), isFalse);
    });

    test('detects replay after recording', () {
      cache.recordNonce(nodeId: 1, msgType: 0x01, nonce: 100, timestampS: 1000);
      expect(cache.isReplay(nodeId: 1, msgType: 0x01, nonce: 100), isTrue);
    });

    test('allows different nonce from same peer', () {
      cache.recordNonce(nodeId: 1, msgType: 0x01, nonce: 100, timestampS: 1000);
      expect(cache.isReplay(nodeId: 1, msgType: 0x01, nonce: 200), isFalse);
    });

    test('allows same nonce from different peers', () {
      cache.recordNonce(nodeId: 1, msgType: 0x01, nonce: 100, timestampS: 1000);
      expect(cache.isReplay(nodeId: 2, msgType: 0x01, nonce: 100), isFalse);
    });

    test('allows same nonce with different msg_type', () {
      cache.recordNonce(nodeId: 1, msgType: 0x01, nonce: 100, timestampS: 1000);
      expect(cache.isReplay(nodeId: 1, msgType: 0x02, nonce: 100), isFalse);
    });

    test('enforces per-bucket LRU eviction at 64 entries', () {
      cache = SipReplayCache(maxEntriesPerBucket: 4);
      // Fill with 4 nonces.
      for (var i = 0; i < 4; i++) {
        cache.recordNonce(nodeId: 1, msgType: 0x01, nonce: i, timestampS: 1000);
      }
      // All 4 should be replays.
      for (var i = 0; i < 4; i++) {
        expect(cache.isReplay(nodeId: 1, msgType: 0x01, nonce: i), isTrue);
      }
      // Add a 5th -- should evict nonce 0 (oldest).
      cache.recordNonce(nodeId: 1, msgType: 0x01, nonce: 99, timestampS: 1000);
      expect(cache.isReplay(nodeId: 1, msgType: 0x01, nonce: 0), isFalse);
      expect(cache.isReplay(nodeId: 1, msgType: 0x01, nonce: 99), isTrue);
    });

    test('idempotent recording (duplicate nonce does not double-add)', () {
      cache.recordNonce(nodeId: 1, msgType: 0x01, nonce: 100, timestampS: 1000);
      cache.recordNonce(nodeId: 1, msgType: 0x01, nonce: 100, timestampS: 1000);
      // Count should still be 1 for this bucket.
      expect(cache.totalEntries, equals(1));
    });

    test('pubkey-aware keying upgrades from anonymous', () {
      // Record under anonymous key.
      cache.recordNonce(nodeId: 1, msgType: 0x01, nonce: 100, timestampS: 1000);
      cache.recordNonce(nodeId: 1, msgType: 0x02, nonce: 200, timestampS: 1000);

      // Upgrade to pubkey-based.
      final pubkey = Uint8List.fromList([
        0xA1,
        0xB2,
        0xC3,
        0xD4,
        0xE5,
        0xF6,
        0x07,
        0x18,
      ]);
      cache.upgradeToPublicKey(nodeId: 1, pubkeyHint: pubkey);

      // Both nonces should now be detected under pubkey key.
      expect(
        cache.isReplay(
          pubkeyHint: pubkey,
          nodeId: 1,
          msgType: 0x01,
          nonce: 100,
        ),
        isTrue,
      );
      expect(
        cache.isReplay(
          pubkeyHint: pubkey,
          nodeId: 1,
          msgType: 0x02,
          nonce: 200,
        ),
        isTrue,
      );

      // Anonymous keys should be removed.
      expect(cache.isReplay(nodeId: 1, msgType: 0x01, nonce: 100), isFalse);
    });

    test('enforces max buckets with LRU eviction', () {
      cache = SipReplayCache(maxBuckets: 2);
      cache.recordNonce(nodeId: 1, msgType: 0x01, nonce: 100, timestampS: 1000);
      cache.recordNonce(nodeId: 2, msgType: 0x01, nonce: 200, timestampS: 1000);
      // Adding a third should evict nodeId 1 (oldest bucket).
      cache.recordNonce(nodeId: 3, msgType: 0x01, nonce: 300, timestampS: 1000);
      expect(cache.peerCount, equals(2));
      expect(cache.isReplay(nodeId: 1, msgType: 0x01, nonce: 100), isFalse);
      expect(cache.isReplay(nodeId: 2, msgType: 0x01, nonce: 200), isTrue);
      expect(cache.isReplay(nodeId: 3, msgType: 0x01, nonce: 300), isTrue);
    });

    test('clear removes all entries', () {
      cache.recordNonce(nodeId: 1, msgType: 0x01, nonce: 100, timestampS: 1000);
      cache.recordNonce(nodeId: 2, msgType: 0x01, nonce: 200, timestampS: 1000);
      cache.clear();
      expect(cache.peerCount, equals(0));
      expect(cache.totalEntries, equals(0));
      expect(cache.isReplay(nodeId: 1, msgType: 0x01, nonce: 100), isFalse);
    });
  });
}
