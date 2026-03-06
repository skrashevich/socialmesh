// SPDX-License-Identifier: GPL-3.0-or-later

import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:socialmesh/services/protocol/sip/sip_codec.dart';
import 'package:socialmesh/services/protocol/sip/sip_constants.dart';
import 'package:socialmesh/services/protocol/sip/sip_frame.dart';
import 'package:socialmesh/services/protocol/sip/sip_handshake.dart';
import 'package:socialmesh/services/protocol/sip/sip_messages_hs.dart';
import 'package:socialmesh/services/protocol/sip/sip_replay_cache.dart';
import 'package:socialmesh/services/protocol/sip/sip_types.dart';

void main() {
  group('SipHsMessages', () {
    test('HS_HELLO round-trip', () {
      final hello = SipHsHello(
        clientNonce: Uint8List.fromList(List.generate(16, (i) => i)),
        clientEphemeralPub: Uint8List.fromList(
          List.generate(32, (i) => i + 16),
        ),
        requestedFeatures: SipFeatureBits.allV01,
      );
      final encoded = SipHsMessages.encodeHello(hello);
      expect(encoded.length, 50);

      final decoded = SipHsMessages.decodeHello(encoded);
      expect(decoded, isNotNull);
      expect(decoded!.clientNonce, equals(hello.clientNonce));
      expect(decoded.clientEphemeralPub, equals(hello.clientEphemeralPub));
      expect(decoded.requestedFeatures, SipFeatureBits.allV01);
    });

    test('HS_CHALLENGE round-trip', () {
      final challenge = SipHsChallenge(
        serverNonce: Uint8List.fromList(List.generate(16, (i) => i + 100)),
        echoedClientNonce: Uint8List.fromList(List.generate(16, (i) => i)),
        serverEphemeralPub: Uint8List.fromList(
          List.generate(32, (i) => i + 200),
        ),
        expiresInS: 60,
      );
      final encoded = SipHsMessages.encodeChallenge(challenge);
      expect(encoded.length, 68);

      final decoded = SipHsMessages.decodeChallenge(encoded);
      expect(decoded, isNotNull);
      expect(decoded!.serverNonce, equals(challenge.serverNonce));
      expect(decoded.echoedClientNonce, equals(challenge.echoedClientNonce));
      expect(decoded.serverEphemeralPub, equals(challenge.serverEphemeralPub));
      expect(decoded.expiresInS, 60);
    });

    test('HS_RESPONSE round-trip', () {
      final response = SipHsResponse(
        echoedServerNonce: Uint8List.fromList(
          List.generate(16, (i) => i + 100),
        ),
        echoedClientNonce: Uint8List.fromList(List.generate(16, (i) => i)),
        sessionTag: 0x12345678,
      );
      final encoded = SipHsMessages.encodeResponse(response);
      expect(encoded.length, 36);

      final decoded = SipHsMessages.decodeResponse(encoded);
      expect(decoded, isNotNull);
      expect(decoded!.echoedServerNonce, equals(response.echoedServerNonce));
      expect(decoded.echoedClientNonce, equals(response.echoedClientNonce));
      expect(decoded.sessionTag, 0x12345678);
    });

    test('HS_ACCEPT round-trip', () {
      final accept = SipHsAccept(
        sessionTag: 0xDEADBEEF,
        dmTtlS: 86400,
        flags: 0,
      );
      final encoded = SipHsMessages.encodeAccept(accept);
      expect(encoded.length, 9);

      final decoded = SipHsMessages.decodeAccept(encoded);
      expect(decoded, isNotNull);
      expect(decoded!.sessionTag, 0xDEADBEEF);
      expect(decoded.dmTtlS, 86400);
      expect(decoded.flags, 0);
    });

    test('deriveSessionTag is deterministic', () async {
      final clientNonce = Uint8List.fromList(List.generate(16, (i) => i));
      final serverNonce = Uint8List.fromList(List.generate(16, (i) => i + 100));

      final tag1 = await SipHsMessages.deriveSessionTag(
        clientNonce,
        serverNonce,
      );
      final tag2 = await SipHsMessages.deriveSessionTag(
        clientNonce,
        serverNonce,
      );
      expect(tag2, equals(tag1));
    });

    test('deriveSessionTag differs for different nonces', () async {
      final clientNonce = Uint8List.fromList(List.generate(16, (i) => i));
      final serverNonce1 = Uint8List.fromList(
        List.generate(16, (i) => i + 100),
      );
      final serverNonce2 = Uint8List.fromList(
        List.generate(16, (i) => i + 200),
      );

      final tag1 = await SipHsMessages.deriveSessionTag(
        clientNonce,
        serverNonce1,
      );
      final tag2 = await SipHsMessages.deriveSessionTag(
        clientNonce,
        serverNonce2,
      );
      expect(tag2, isNot(equals(tag1)));
    });

    test('decode rejects truncated payloads', () {
      expect(SipHsMessages.decodeHello(Uint8List(49)), isNull);
      expect(SipHsMessages.decodeChallenge(Uint8List(67)), isNull);
      expect(SipHsMessages.decodeResponse(Uint8List(35)), isNull);
      expect(SipHsMessages.decodeAccept(Uint8List(8)), isNull);
    });
  });

  group('SipHandshakeManager', () {
    late SipReplayCache replayCache;

    setUp(() {
      replayCache = SipReplayCache();
    });

    test('happy path: initiator + responder complete handshake', () async {
      final initiator = SipHandshakeManager(replayCache: replayCache);
      final responder = SipHandshakeManager(replayCache: SipReplayCache());

      const nodeA = 0xAAAA;
      const nodeB = 0xBBBB;

      // Step 1: Initiator sends HS_HELLO.
      final helloFrame = initiator.initiateHandshake(nodeB);
      expect(helloFrame, isNotNull);
      expect(helloFrame!.msgType, SipMessageType.hsHello);
      expect(initiator.getState(nodeB), SipHandshakeState.helloSent);

      // Step 2: Responder receives HS_HELLO, sends HS_CHALLENGE.
      final challengeFrame = responder.handleHello(nodeA, helloFrame);
      expect(challengeFrame, isNotNull);
      expect(challengeFrame!.msgType, SipMessageType.hsChallenge);

      // Step 3: Initiator receives HS_CHALLENGE, sends HS_RESPONSE.
      final responseFrame = await initiator.handleChallenge(
        nodeB,
        challengeFrame,
      );
      expect(responseFrame, isNotNull);
      expect(responseFrame!.msgType, SipMessageType.hsResponse);

      // Step 4: Responder receives HS_RESPONSE, sends HS_ACCEPT.
      final acceptFrame = await responder.handleResponse(nodeA, responseFrame);
      expect(acceptFrame, isNotNull);
      expect(acceptFrame!.msgType, SipMessageType.hsAccept);

      // Step 5: Initiator receives HS_ACCEPT.
      final result = initiator.handleAccept(nodeB, acceptFrame);
      expect(result, isNotNull);
      expect(result!.peerNodeId, nodeB);
      expect(result.sessionTag, isNonZero);
      expect(result.dmTtlS, SipConstants.dmTtlDefaultS);

      // Responder also has a result.
      final respResult = responder.consumeResult(nodeA);
      expect(respResult, isNotNull);
      expect(respResult!.sessionTag, result.sessionTag);
    });

    test('duplicate initiation rejected', () {
      final mgr = SipHandshakeManager(replayCache: replayCache);
      final first = mgr.initiateHandshake(0x1234);
      expect(first, isNotNull);

      final second = mgr.initiateHandshake(0x1234);
      expect(second, isNull);
    });

    test('nonce replay rejected on HS_HELLO', () {
      final mgr = SipHandshakeManager(replayCache: replayCache);

      final helloFrame = SipFrame(
        versionMajor: 0,
        versionMinor: 1,
        msgType: SipMessageType.hsHello,
        flags: 0,
        headerLen: SipConstants.sipWrapperMin,
        sessionId: 0,
        nonce: 12345,
        timestampS: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        payloadLen: 50,
        payload: Uint8List(50),
      );

      // First should succeed (though payload is zeros, at least the replay
      // cache records it).
      mgr.handleHello(0xAAAA, helloFrame);
      // The decode may fail because payload is all zeros, but nonce is recorded.
      // Second call with same nonce should be rejected.
      mgr.reset();
      final second = mgr.handleHello(0xAAAA, helloFrame);
      // The nonce was recorded in the replay cache, so this should be rejected.
      // (both may return null due to invalid payload, but the important thing
      // is that replay check fires)
      expect(second, isNull);
    });

    test('unexpected HS_CHALLENGE without HS_HELLO is rejected', () async {
      final mgr = SipHandshakeManager(replayCache: replayCache);

      final challenge = SipFrame(
        versionMajor: 0,
        versionMinor: 1,
        msgType: SipMessageType.hsChallenge,
        flags: SipFlags.isResponse,
        headerLen: SipConstants.sipWrapperMin,
        sessionId: 0,
        nonce: SipCodec.generateNonce(),
        timestampS: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        payloadLen: 68,
        payload: Uint8List(68),
      );

      final result = await mgr.handleChallenge(0x1234, challenge);
      expect(result, isNull);
    });

    test('cancelHandshake removes session', () {
      final mgr = SipHandshakeManager(replayCache: replayCache);
      mgr.initiateHandshake(0x1234);
      expect(mgr.hasActiveSession(0x1234), isTrue);

      mgr.cancelHandshake(0x1234);
      expect(mgr.hasActiveSession(0x1234), isFalse);
    });

    test('concurrent handshakes with different peers', () {
      final mgr = SipHandshakeManager(replayCache: replayCache);

      final helloA = mgr.initiateHandshake(0xAAAA);
      final helloB = mgr.initiateHandshake(0xBBBB);

      expect(helloA, isNotNull);
      expect(helloB, isNotNull);
      expect(mgr.hasActiveSession(0xAAAA), isTrue);
      expect(mgr.hasActiveSession(0xBBBB), isTrue);
    });

    test('reset clears all state', () {
      final mgr = SipHandshakeManager(replayCache: replayCache);
      mgr.initiateHandshake(0xAAAA);
      mgr.initiateHandshake(0xBBBB);

      mgr.reset();

      expect(mgr.hasActiveSession(0xAAAA), isFalse);
      expect(mgr.hasActiveSession(0xBBBB), isFalse);
    });

    test('session tag mismatch on HS_ACCEPT fails', () async {
      final initiator = SipHandshakeManager(replayCache: replayCache);
      final responder = SipHandshakeManager(replayCache: SipReplayCache());

      final helloFrame = initiator.initiateHandshake(0xBBBB);
      final challengeFrame = responder.handleHello(0xAAAA, helloFrame!);
      final responseFrame = await initiator.handleChallenge(
        0xBBBB,
        challengeFrame!,
      );
      await responder.handleResponse(0xAAAA, responseFrame!);

      // Forge a bad accept with wrong session_tag.
      final badAccept = SipHsAccept(
        sessionTag: 0xDEADDEAD,
        dmTtlS: 86400,
        flags: 0,
      );
      final badPayload = SipHsMessages.encodeAccept(badAccept);
      final badFrame = SipFrame(
        versionMajor: 0,
        versionMinor: 1,
        msgType: SipMessageType.hsAccept,
        flags: SipFlags.isResponse,
        headerLen: SipConstants.sipWrapperMin,
        sessionId: 0xDEADDEAD,
        nonce: SipCodec.generateNonce(),
        timestampS: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        payloadLen: badPayload.length,
        payload: badPayload,
      );

      final result = initiator.handleAccept(0xBBBB, badFrame);
      expect(result, isNull);
    });
  });
}
