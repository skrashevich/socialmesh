// SPDX-License-Identifier: GPL-3.0-or-later

import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:socialmesh/services/protocol/sip/sip_identity_store.dart';
import 'package:socialmesh/services/protocol/sip/sip_types.dart';

void main() {
  late SipIdentityStore store;
  late int nowMs;

  Uint8List makeKey(int seed) {
    final key = Uint8List(32);
    for (var i = 0; i < 32; i++) {
      key[i] = (seed + i) & 0xFF;
    }
    return key;
  }

  Uint8List makePersonaId(int seed) {
    final id = Uint8List(16);
    for (var i = 0; i < 16; i++) {
      id[i] = (seed + i + 100) & 0xFF;
    }
    return id;
  }

  setUp(() {
    nowMs = 1700000000000;
    store = SipIdentityStore(maxPeers: 4, clock: () => nowMs);
  });

  group('SipIdentityStore', () {
    group('TOFU', () {
      test('first claim -> VERIFIED_TOFU', () {
        final state = store.storeClaim(
          nodeId: 0x1234,
          pubkey: makeKey(1),
          personaId: makePersonaId(1),
          displayName: 'Alice',
          status: 'Hello',
          deviceModel: 'T-Beam',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        expect(state, SipIdentityState.verifiedTofu);
        expect(store.peerCount, 1);

        final record = store.getByNodeId(0x1234);
        expect(record, isNotNull);
        expect(record!.displayName, 'Alice');
        expect(record.state, SipIdentityState.verifiedTofu);
        expect(record.seenNodeIds, contains(0x1234));
      });

      test('same key same node -> stays VERIFIED_TOFU, updates fields', () {
        store.storeClaim(
          nodeId: 0x1234,
          pubkey: makeKey(1),
          personaId: makePersonaId(1),
          displayName: 'Alice',
          status: 'Hello',
          deviceModel: 'T-Beam',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        // Advance past rate limit.
        nowMs += 301 * 1000;

        final state = store.storeClaim(
          nodeId: 0x1234,
          pubkey: makeKey(1),
          personaId: makePersonaId(1),
          displayName: 'Alice Updated',
          status: 'New Status',
          deviceModel: 'T-Beam',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        expect(state, SipIdentityState.verifiedTofu);
        expect(store.peerCount, 1);
        expect(store.getByNodeId(0x1234)!.displayName, 'Alice Updated');
        expect(store.getByNodeId(0x1234)!.status, 'New Status');
      });
    });

    group('CHANGED_KEY', () {
      test('different key same node -> CHANGED_KEY', () {
        store.storeClaim(
          nodeId: 0x1234,
          pubkey: makeKey(1),
          personaId: makePersonaId(1),
          displayName: 'Alice',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        nowMs += 301 * 1000;

        final state = store.storeClaim(
          nodeId: 0x1234,
          pubkey: makeKey(2),
          personaId: makePersonaId(2),
          displayName: 'Alice New Key',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        expect(state, SipIdentityState.changedKey);
        expect(store.getByNodeId(0x1234)!.pubkeyHint, isNot(isEmpty));
      });

      test('acceptChangedKey transitions to VERIFIED_TOFU', () {
        store.storeClaim(
          nodeId: 0x1234,
          pubkey: makeKey(1),
          personaId: makePersonaId(1),
          displayName: 'Alice',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        nowMs += 301 * 1000;

        store.storeClaim(
          nodeId: 0x1234,
          pubkey: makeKey(2),
          personaId: makePersonaId(2),
          displayName: 'Alice',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        expect(store.getByNodeId(0x1234)!.state, SipIdentityState.changedKey);

        final accepted = store.acceptChangedKey(0x1234);
        expect(accepted, isTrue);
        expect(store.getByNodeId(0x1234)!.state, SipIdentityState.verifiedTofu);
      });

      test('acceptChangedKey returns false for non-CHANGED_KEY state', () {
        store.storeClaim(
          nodeId: 0x1234,
          pubkey: makeKey(1),
          personaId: makePersonaId(1),
          displayName: 'Alice',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        expect(store.acceptChangedKey(0x1234), isFalse);
      });
    });

    group('Pinning', () {
      test('pin VERIFIED_TOFU -> PINNED', () {
        store.storeClaim(
          nodeId: 0x1234,
          pubkey: makeKey(1),
          personaId: makePersonaId(1),
          displayName: 'Alice',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        expect(store.pinIdentity(0x1234), isTrue);
        expect(store.getByNodeId(0x1234)!.state, SipIdentityState.pinned);
      });

      test('unpin PINNED -> VERIFIED_TOFU', () {
        store.storeClaim(
          nodeId: 0x1234,
          pubkey: makeKey(1),
          personaId: makePersonaId(1),
          displayName: 'Alice',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        store.pinIdentity(0x1234);
        expect(store.unpinIdentity(0x1234), isTrue);
        expect(store.getByNodeId(0x1234)!.state, SipIdentityState.verifiedTofu);
      });

      test('pin unknown node returns false', () {
        expect(store.pinIdentity(0x9999), isFalse);
      });

      test('unpin non-pinned returns false', () {
        store.storeClaim(
          nodeId: 0x1234,
          pubkey: makeKey(1),
          personaId: makePersonaId(1),
          displayName: 'Alice',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        expect(store.unpinIdentity(0x1234), isFalse);
      });
    });

    group('Node migration', () {
      test('same pubkey different node -> node migration', () {
        final key = makeKey(1);
        store.storeClaim(
          nodeId: 0x1234,
          pubkey: key,
          personaId: makePersonaId(1),
          displayName: 'Alice',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        nowMs += 301 * 1000;

        final state = store.storeClaim(
          nodeId: 0x5678,
          pubkey: key,
          personaId: makePersonaId(1),
          displayName: 'Alice Migrated',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        expect(state, SipIdentityState.verifiedTofu);

        // Both node IDs should resolve to the same record.
        final r1 = store.getByNodeId(0x1234);
        final r2 = store.getByNodeId(0x5678);
        expect(r1, same(r2));
        expect(r1!.seenNodeIds, containsAll([0x1234, 0x5678]));
        expect(r1.displayName, 'Alice Migrated');
      });
    });

    group('Rate limiting', () {
      test('same node within 300s -> rate-limited (null)', () {
        store.storeClaim(
          nodeId: 0x1234,
          pubkey: makeKey(1),
          personaId: makePersonaId(1),
          displayName: 'Alice',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        nowMs += 200 * 1000; // Only 200s elapsed (< 300s).

        final state = store.storeClaim(
          nodeId: 0x1234,
          pubkey: makeKey(1),
          personaId: makePersonaId(1),
          displayName: 'Alice',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        expect(state, isNull);
      });

      test('same node after 300s -> accepted', () {
        store.storeClaim(
          nodeId: 0x1234,
          pubkey: makeKey(1),
          personaId: makePersonaId(1),
          displayName: 'Alice',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        nowMs += 301 * 1000;

        final state = store.storeClaim(
          nodeId: 0x1234,
          pubkey: makeKey(1),
          personaId: makePersonaId(1),
          displayName: 'Alice',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        expect(state, SipIdentityState.verifiedTofu);
      });
    });

    group('STALE', () {
      test('expired claim marked STALE', () {
        store.storeClaim(
          nodeId: 0x1234,
          pubkey: makeKey(1),
          personaId: makePersonaId(1),
          displayName: 'Alice',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 3600, // 1 hour TTL
        );

        // Advance past TTL.
        nowMs += 3601 * 1000;

        final count = store.markStaleRecords();
        expect(count, 1);
        expect(store.getByNodeId(0x1234)!.state, SipIdentityState.stale);
      });

      test('STALE record reverts to VERIFIED_TOFU on fresh claim', () {
        store.storeClaim(
          nodeId: 0x1234,
          pubkey: makeKey(1),
          personaId: makePersonaId(1),
          displayName: 'Alice',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 3600,
        );

        nowMs += 3601 * 1000;
        store.markStaleRecords();
        expect(store.getByNodeId(0x1234)!.state, SipIdentityState.stale);

        final state = store.storeClaim(
          nodeId: 0x1234,
          pubkey: makeKey(1),
          personaId: makePersonaId(1),
          displayName: 'Alice Fresh',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        expect(state, SipIdentityState.verifiedTofu);
        expect(store.getByNodeId(0x1234)!.displayName, 'Alice Fresh');
      });

      test('non-expired claim not marked as stale', () {
        store.storeClaim(
          nodeId: 0x1234,
          pubkey: makeKey(1),
          personaId: makePersonaId(1),
          displayName: 'Alice',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        nowMs += 3600 * 1000; // 1 hour (< 24h TTL)

        final count = store.markStaleRecords();
        expect(count, 0);
        expect(store.getByNodeId(0x1234)!.state, SipIdentityState.verifiedTofu);
      });
    });

    group('Eviction', () {
      test('evicts oldest non-pinned when full', () {
        // Fill to maxPeers (4).
        for (var i = 0; i < 4; i++) {
          nowMs += 301 * 1000;
          store.storeClaim(
            nodeId: 0x1000 + i,
            pubkey: makeKey(i + 10),
            personaId: makePersonaId(i + 10),
            displayName: 'Peer $i',
            status: '',
            deviceModel: '',
            createdAt: nowMs ~/ 1000,
            claimTtlS: 86400,
          );
        }

        expect(store.peerCount, 4);

        // Add one more -> should evict oldest (0x1000).
        nowMs += 301 * 1000;
        store.storeClaim(
          nodeId: 0x9999,
          pubkey: makeKey(99),
          personaId: makePersonaId(99),
          displayName: 'New Peer',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        expect(store.peerCount, 4);
        expect(store.getByNodeId(0x1000), isNull); // Evicted.
        expect(store.getByNodeId(0x9999), isNotNull); // New entry.
      });

      test('pinned records not evicted', () {
        for (var i = 0; i < 4; i++) {
          nowMs += 301 * 1000;
          store.storeClaim(
            nodeId: 0x1000 + i,
            pubkey: makeKey(i + 10),
            personaId: makePersonaId(i + 10),
            displayName: 'Peer $i',
            status: '',
            deviceModel: '',
            createdAt: nowMs ~/ 1000,
            claimTtlS: 86400,
          );
        }

        // Pin the oldest.
        store.pinIdentity(0x1000);

        // Add one more -> should evict second oldest (0x1001), not pinned (0x1000).
        nowMs += 301 * 1000;
        store.storeClaim(
          nodeId: 0x9999,
          pubkey: makeKey(99),
          personaId: makePersonaId(99),
          displayName: 'New Peer',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        expect(store.getByNodeId(0x1000), isNotNull); // Pinned, not evicted.
        expect(store.getByNodeId(0x1001), isNull); // Second oldest, evicted.
        expect(store.getByNodeId(0x9999), isNotNull);
      });
    });

    group('Lookup', () {
      test('getByPubkey returns record', () {
        final key = makeKey(1);
        store.storeClaim(
          nodeId: 0x1234,
          pubkey: key,
          personaId: makePersonaId(1),
          displayName: 'Alice',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        final record = store.getByPubkey(key);
        expect(record, isNotNull);
        expect(record!.nodeId, 0x1234);
      });

      test('allRecords returns all stored', () {
        store.storeClaim(
          nodeId: 0x1234,
          pubkey: makeKey(1),
          personaId: makePersonaId(1),
          displayName: 'Alice',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        nowMs += 301 * 1000;

        store.storeClaim(
          nodeId: 0x5678,
          pubkey: makeKey(2),
          personaId: makePersonaId(2),
          displayName: 'Bob',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        expect(store.allRecords.length, 2);
      });
    });

    group('Serialization', () {
      test('export and import round-trip', () {
        store.storeClaim(
          nodeId: 0x1234,
          pubkey: makeKey(1),
          personaId: makePersonaId(1),
          displayName: 'Alice',
          status: 'Hello World',
          deviceModel: 'T-Beam',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        store.pinIdentity(0x1234);

        final exported = store.exportRecords();
        expect(exported.length, 1);
        expect(exported.first['display_name'], 'Alice');
        expect(exported.first['state'], 'pinned');

        // Import into a fresh store.
        final store2 = SipIdentityStore(clock: () => nowMs);
        store2.importRecords(exported);

        expect(store2.peerCount, 1);
        final record = store2.getByNodeId(0x1234);
        expect(record, isNotNull);
        expect(record!.displayName, 'Alice');
        expect(record.state, SipIdentityState.pinned);
        expect(record.status, 'Hello World');
        expect(record.deviceModel, 'T-Beam');
      });
    });

    group('Cleanup', () {
      test('removeByNodeId removes record', () {
        store.storeClaim(
          nodeId: 0x1234,
          pubkey: makeKey(1),
          personaId: makePersonaId(1),
          displayName: 'Alice',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        store.removeByNodeId(0x1234);
        expect(store.peerCount, 0);
        expect(store.getByNodeId(0x1234), isNull);
        expect(store.getByPubkey(makeKey(1)), isNull);
      });

      test('clear removes all records', () {
        for (var i = 0; i < 3; i++) {
          nowMs += 301 * 1000;
          store.storeClaim(
            nodeId: 0x1000 + i,
            pubkey: makeKey(i + 10),
            personaId: makePersonaId(i + 10),
            displayName: 'Peer $i',
            status: '',
            deviceModel: '',
            createdAt: nowMs ~/ 1000,
            claimTtlS: 86400,
          );
        }

        store.clear();
        expect(store.peerCount, 0);
      });
    });

    group('isExpired', () {
      test('record within TTL is not expired', () {
        store.storeClaim(
          nodeId: 0x1234,
          pubkey: makeKey(1),
          personaId: makePersonaId(1),
          displayName: 'Alice',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 86400,
        );

        final record = store.getByNodeId(0x1234)!;
        expect(record.isExpired(nowMs ~/ 1000), isFalse);
      });

      test('record past TTL is expired', () {
        store.storeClaim(
          nodeId: 0x1234,
          pubkey: makeKey(1),
          personaId: makePersonaId(1),
          displayName: 'Alice',
          status: '',
          deviceModel: '',
          createdAt: nowMs ~/ 1000,
          claimTtlS: 100,
        );

        final futureS = (nowMs ~/ 1000) + 101;
        final record = store.getByNodeId(0x1234)!;
        expect(record.isExpired(futureS), isTrue);
      });
    });
  });
}
