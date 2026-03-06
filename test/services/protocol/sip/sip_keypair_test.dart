// SPDX-License-Identifier: GPL-3.0-or-later

import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:socialmesh/services/protocol/sip/sip_keypair.dart';

/// In-memory stub for [FlutterSecureStorage] used in tests.
///
/// Delegates all methods via [noSuchMethod] and overrides only the
/// methods we need, using the exact parameter types from v10.0.0.
class _FakeSecureStorage extends Fake implements FlutterSecureStorage {
  final Map<String, String> _store = {};

  @override
  Future<void> write({
    required String key,
    required String? value,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    if (value != null) {
      _store[key] = value;
    } else {
      _store.remove(key);
    }
  }

  @override
  Future<String?> read({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    return _store[key];
  }

  @override
  Future<void> delete({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    _store.remove(key);
  }

  @override
  Future<Map<String, String>> readAll({
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    return Map.of(_store);
  }

  @override
  Future<void> deleteAll({
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    _store.clear();
  }

  @override
  Future<bool> containsKey({
    required String key,
    AppleOptions? iOptions,
    AndroidOptions? aOptions,
    LinuxOptions? lOptions,
    WebOptions? webOptions,
    AppleOptions? mOptions,
    WindowsOptions? wOptions,
  }) async {
    return _store.containsKey(key);
  }
}

void main() {
  group('SipKeypair', () {
    late _FakeSecureStorage storage;

    setUp(() {
      storage = _FakeSecureStorage();
    });

    test('generates keypair on first access', () async {
      final keypair = SipKeypair(storage: storage);
      expect(keypair.isInitialized, isFalse);

      await keypair.ensureInitialized();
      expect(keypair.isInitialized, isTrue);

      final pubkey = keypair.getPublicKeyBytes();
      expect(pubkey.length, 32);
    });

    test('persists and reloads keypair', () async {
      final keypair1 = SipKeypair(storage: storage);
      await keypair1.ensureInitialized();
      final pubkey1 = keypair1.getPublicKeyBytes();

      // Second instance with same storage should load the same key.
      final keypair2 = SipKeypair(storage: storage);
      await keypair2.ensureInitialized();
      final pubkey2 = keypair2.getPublicKeyBytes();

      expect(pubkey2, equals(pubkey1));
    });

    test('multiple ensureInitialized calls are idempotent', () async {
      final keypair = SipKeypair(storage: storage);
      await keypair.ensureInitialized();
      final pubkey1 = keypair.getPublicKeyBytes();

      await keypair.ensureInitialized();
      final pubkey2 = keypair.getPublicKeyBytes();

      expect(pubkey2, equals(pubkey1));
    });

    test('sign returns 64-byte signature', () async {
      final keypair = SipKeypair(storage: storage);
      await keypair.ensureInitialized();

      final data = Uint8List.fromList([1, 2, 3, 4, 5]);
      final signature = await keypair.sign(data);
      expect(signature.length, 64);
    });

    test('verify validates correct signature', () async {
      final keypair = SipKeypair(storage: storage);
      await keypair.ensureInitialized();

      final data = Uint8List.fromList([1, 2, 3, 4, 5, 6, 7, 8]);
      final signature = await keypair.sign(data);
      final pubkey = keypair.getPublicKeyBytes();

      final valid = await keypair.verify(data, signature, pubkey);
      expect(valid, isTrue);
    });

    test('verify rejects tampered data', () async {
      final keypair = SipKeypair(storage: storage);
      await keypair.ensureInitialized();

      final data = Uint8List.fromList([1, 2, 3, 4]);
      final signature = await keypair.sign(data);
      final pubkey = keypair.getPublicKeyBytes();

      // Tamper with data.
      final tampered = Uint8List.fromList([1, 2, 3, 5]);
      final valid = await keypair.verify(tampered, signature, pubkey);
      expect(valid, isFalse);
    });

    test('verify rejects wrong key', () async {
      final keypair1 = SipKeypair(storage: storage);
      await keypair1.ensureInitialized();

      final data = Uint8List.fromList([10, 20, 30]);
      final signature = await keypair1.sign(data);

      // Generate a different keypair.
      final storage2 = _FakeSecureStorage();
      final keypair2 = SipKeypair(storage: storage2);
      await keypair2.ensureInitialized();
      final wrongPubkey = keypair2.getPublicKeyBytes();

      final valid = await keypair1.verify(data, signature, wrongPubkey);
      expect(valid, isFalse);
    });

    test('persona_id is 16 bytes deterministic from pubkey', () async {
      final keypair = SipKeypair(storage: storage);
      await keypair.ensureInitialized();

      final personaId = keypair.getPersonaId();
      expect(personaId.length, 16);

      // Recompute from same pubkey -- must match.
      final recomputed = await SipKeypair.computePersonaId(
        keypair.getPublicKeyBytes(),
      );
      expect(recomputed, equals(personaId));
    });

    test('sigil_hash is deterministic from persona_id', () async {
      final keypair = SipKeypair(storage: storage);
      await keypair.ensureInitialized();

      final hash1 = keypair.getSigilHash();
      final hash2 = SipKeypair.computeSigilHash(keypair.getPersonaId());
      expect(hash2, equals(hash1));
    });

    test('different pubkeys produce different persona_id', () async {
      final personas = <String>{};
      for (var i = 0; i < 100; i++) {
        final s = _FakeSecureStorage();
        final kp = SipKeypair(storage: s);
        await kp.ensureInitialized();
        personas.add(
          kp
              .getPersonaId()
              .map((b) => b.toRadixString(16).padLeft(2, '0'))
              .join(),
        );
      }
      // All 100 should be unique (collision resistance).
      expect(personas.length, 100);
    });

    test('different pubkeys produce different sigil_hash', () async {
      final hashes = <int>{};
      for (var i = 0; i < 100; i++) {
        final s = _FakeSecureStorage();
        final kp = SipKeypair(storage: s);
        await kp.ensureInitialized();
        hashes.add(kp.getSigilHash());
      }
      // With 100 random keys in a 32-bit space, collisions are extremely unlikely.
      expect(hashes.length, greaterThanOrEqualTo(99));
    });

    test('getPublicKeyHint returns 16-char hex', () async {
      final keypair = SipKeypair(storage: storage);
      await keypair.ensureInitialized();

      final hint = keypair.getPublicKeyHint();
      expect(hint.length, 16);
      expect(RegExp(r'^[0-9a-f]{16}$').hasMatch(hint), isTrue);
    });

    test('deleteKeypair clears stored keys', () async {
      final keypair = SipKeypair(storage: storage);
      await keypair.ensureInitialized();
      expect(keypair.isInitialized, isTrue);

      await keypair.deleteKeypair();
      expect(keypair.isInitialized, isFalse);

      // Verify storage is empty.
      final allKeys = await storage.readAll();
      expect(allKeys.containsKey('sip_ed25519_private'), isFalse);
      expect(allKeys.containsKey('sip_ed25519_public'), isFalse);
    });

    test('throws StateError when not initialized', () {
      final keypair = SipKeypair(storage: storage);
      expect(() => keypair.getPublicKeyBytes(), throwsStateError);
      expect(() => keypair.getPersonaId(), throwsStateError);
      expect(() => keypair.getSigilHash(), throwsStateError);
    });

    test('computePersonaId is deterministic', () async {
      final pubkey = Uint8List.fromList(List.generate(32, (i) => i));
      final id1 = await SipKeypair.computePersonaId(pubkey);
      final id2 = await SipKeypair.computePersonaId(pubkey);
      expect(id2, equals(id1));
    });

    test('computeSigilHash is deterministic', () {
      final personaId = Uint8List.fromList(List.generate(16, (i) => i * 17));
      final h1 = SipKeypair.computeSigilHash(personaId);
      final h2 = SipKeypair.computeSigilHash(personaId);
      expect(h2, equals(h1));
    });
  });
}
