// SPDX-License-Identifier: GPL-3.0-or-later

/// SIP-1 handshake state machine (initiator + responder).
///
/// Manages the consent-first handshake flow:
/// 1. Initiator sends HS_HELLO
/// 2. Responder sends HS_CHALLENGE
/// 3. Initiator sends HS_RESPONSE
/// 4. Responder sends HS_ACCEPT
///
/// Each peer tracks handshake state per remote node.
library;

import 'dart:math';
import 'dart:typed_data';

import '../../../core/logging.dart';
import 'sip_codec.dart';
import 'sip_constants.dart';
import 'sip_frame.dart';
import 'sip_messages_hs.dart';
import 'sip_replay_cache.dart';
import 'sip_types.dart';

/// Handshake states for initiator and responder.
enum SipHandshakeState {
  idle,
  helloSent,
  challengeReceived,
  responseSent,
  helloReceived,
  challengeSent,
  responseReceived,
  accepted,
  failed,
  timedOut,
}

/// Result of a completed handshake.
class SipHandshakeResult {
  final int sessionTag;
  final int peerNodeId;
  final int dmTtlS;
  final Uint8List peerEphemeralPub;

  const SipHandshakeResult({
    required this.sessionTag,
    required this.peerNodeId,
    required this.dmTtlS,
    required this.peerEphemeralPub,
  });
}

/// A single handshake session with one peer.
class _HandshakeSession {
  SipHandshakeState state = SipHandshakeState.idle;
  int peerNodeId;
  Uint8List? clientNonce;
  Uint8List? serverNonce;
  Uint8List? localEphemeralPub;
  Uint8List? peerEphemeralPub;
  int? sessionTag;
  int? expiresInS;
  DateTime startedAt;

  _HandshakeSession({required this.peerNodeId}) : startedAt = DateTime.now();

  bool get isTimedOut {
    return DateTime.now().difference(startedAt) > SipConstants.handshakeTimeout;
  }
}

/// Manages handshake sessions with multiple peers.
///
/// Tracks both initiator and responder state, validates nonces against
/// the [SipReplayCache], and drives the handshake state machine to
/// completion or failure.
class SipHandshakeManager {
  /// Creates a handshake manager.
  ///
  /// [replayCache] is used to reject replayed nonces.
  /// [clock] can be injected for testing.
  SipHandshakeManager({
    required SipReplayCache replayCache,
    DateTime Function()? clock,
  }) : _replayCache = replayCache,
       _clock = clock ?? DateTime.now;

  final SipReplayCache _replayCache;
  final DateTime Function() _clock;
  final Random _random = Random.secure();

  /// Active sessions keyed by peer node ID.
  final Map<int, _HandshakeSession> _sessions = {};

  /// Completed handshake results waiting to be consumed.
  final Map<int, SipHandshakeResult> _completed = {};

  // ---------------------------------------------------------------------------
  // Initiator flow
  // ---------------------------------------------------------------------------

  /// Start a handshake with [peerNodeId].
  ///
  /// Returns the HS_HELLO [SipFrame] to send, or null if a session
  /// already exists for this peer.
  SipFrame? initiateHandshake(int peerNodeId) {
    // Clean up timed-out sessions.
    _cleanExpired();

    if (_sessions.containsKey(peerNodeId)) {
      AppLogging.sip(
        'SIP_HS: handshake already in progress with '
        'node=0x${peerNodeId.toRadixString(16)}',
      );
      return null;
    }

    final session = _HandshakeSession(peerNodeId: peerNodeId);
    session.clientNonce = _generateNonce16();
    session.localEphemeralPub = _generateEphemeralPub();
    session.state = SipHandshakeState.helloSent;
    _sessions[peerNodeId] = session;

    final hello = SipHsHello(
      clientNonce: session.clientNonce!,
      clientEphemeralPub: session.localEphemeralPub!,
      requestedFeatures: SipFeatureBits.allV01,
    );

    final payload = SipHsMessages.encodeHello(hello);

    AppLogging.sip(
      'SIP_HS: -> HS_HELLO to node=0x${peerNodeId.toRadixString(16)}, '
      'client_nonce=${_hexPrefix(session.clientNonce!)}',
    );

    return SipFrame(
      versionMajor: SipConstants.sipVersionMajor,
      versionMinor: SipConstants.sipVersionMinor,
      msgType: SipMessageType.hsHello,
      flags: 0,
      headerLen: SipConstants.sipWrapperMin,
      sessionId: 0,
      nonce: SipCodec.generateNonce(),
      timestampS: _nowS(),
      payloadLen: payload.length,
      payload: payload,
    );
  }

  /// Process a received HS_CHALLENGE (initiator receives this).
  ///
  /// Returns the HS_RESPONSE [SipFrame] to send, or null on error.
  Future<SipFrame?> handleChallenge(int peerNodeId, SipFrame frame) async {
    final session = _sessions[peerNodeId];
    if (session == null || session.state != SipHandshakeState.helloSent) {
      AppLogging.sip(
        'SIP_HS: unexpected HS_CHALLENGE from '
        'node=0x${peerNodeId.toRadixString(16)} '
        '(state=${session?.state})',
      );
      return null;
    }

    if (session.isTimedOut) {
      _failSession(peerNodeId, 'timeout');
      return null;
    }

    final challenge = SipHsMessages.decodeChallenge(frame.payload);
    if (challenge == null) return null;

    // Verify echoed client nonce matches.
    if (!_bytesEqual(challenge.echoedClientNonce, session.clientNonce!)) {
      AppLogging.sip(
        'SIP_HS: HS_CHALLENGE nonce mismatch from '
        'node=0x${peerNodeId.toRadixString(16)}',
      );
      _failSession(peerNodeId, 'nonce mismatch');
      return null;
    }

    session.serverNonce = challenge.serverNonce;
    session.peerEphemeralPub = challenge.serverEphemeralPub;
    session.expiresInS = challenge.expiresInS;
    session.state = SipHandshakeState.challengeReceived;

    // Derive session tag.
    final tag = await SipHsMessages.deriveSessionTag(
      session.clientNonce!,
      session.serverNonce!,
    );
    session.sessionTag = tag;
    session.state = SipHandshakeState.responseSent;

    final response = SipHsResponse(
      echoedServerNonce: session.serverNonce!,
      echoedClientNonce: session.clientNonce!,
      sessionTag: tag,
    );

    final payload = SipHsMessages.encodeResponse(response);

    AppLogging.sip(
      'SIP_HS: <- HS_CHALLENGE from '
      'node=0x${peerNodeId.toRadixString(16)}, '
      'server_nonce=${_hexPrefix(challenge.serverNonce)}\n'
      'SIP_HS: -> HS_RESPONSE, session_tag=0x${tag.toRadixString(16)}',
    );

    return SipFrame(
      versionMajor: SipConstants.sipVersionMajor,
      versionMinor: SipConstants.sipVersionMinor,
      msgType: SipMessageType.hsResponse,
      flags: SipFlags.isResponse,
      headerLen: SipConstants.sipWrapperMin,
      sessionId: tag,
      nonce: SipCodec.generateNonce(),
      timestampS: _nowS(),
      payloadLen: payload.length,
      payload: payload,
    );
  }

  /// Process a received HS_ACCEPT (initiator receives this).
  ///
  /// Returns the [SipHandshakeResult] if handshake is complete.
  SipHandshakeResult? handleAccept(int peerNodeId, SipFrame frame) {
    final session = _sessions[peerNodeId];
    if (session == null || session.state != SipHandshakeState.responseSent) {
      AppLogging.sip(
        'SIP_HS: unexpected HS_ACCEPT from '
        'node=0x${peerNodeId.toRadixString(16)} '
        '(state=${session?.state})',
      );
      return null;
    }

    if (session.isTimedOut) {
      _failSession(peerNodeId, 'timeout');
      return null;
    }

    final accept = SipHsMessages.decodeAccept(frame.payload);
    if (accept == null) return null;

    // Verify session tag matches.
    if (accept.sessionTag != session.sessionTag) {
      AppLogging.sip(
        'SIP_HS: HS_ACCEPT session_tag mismatch from '
        'node=0x${peerNodeId.toRadixString(16)}',
      );
      _failSession(peerNodeId, 'session_tag mismatch');
      return null;
    }

    session.state = SipHandshakeState.accepted;

    final result = SipHandshakeResult(
      sessionTag: accept.sessionTag,
      peerNodeId: peerNodeId,
      dmTtlS: accept.dmTtlS,
      peerEphemeralPub: session.peerEphemeralPub ?? Uint8List(0),
    );

    _completed[peerNodeId] = result;
    _sessions.remove(peerNodeId);

    AppLogging.sip(
      'SIP_HS: <- HS_ACCEPT, session_tag=0x${accept.sessionTag.toRadixString(16)}, '
      'dm_ttl=${accept.dmTtlS}s\n'
      'SIP_HS: handshake COMPLETE with '
      'node=0x${peerNodeId.toRadixString(16)}',
    );

    return result;
  }

  // ---------------------------------------------------------------------------
  // Responder flow
  // ---------------------------------------------------------------------------

  /// Process a received HS_HELLO (responder receives this).
  ///
  /// Returns the HS_CHALLENGE [SipFrame] to send, or null on error.
  SipFrame? handleHello(int peerNodeId, SipFrame frame) {
    _cleanExpired();

    final hello = SipHsMessages.decodeHello(frame.payload);
    if (hello == null) return null;

    // Check replay.
    if (_replayCache.isReplay(
      nodeId: peerNodeId,
      nonce: frame.nonce,
      msgType: frame.msgType.code,
    )) {
      AppLogging.sip(
        'SIP_HS: HS_HELLO replay from '
        'node=0x${peerNodeId.toRadixString(16)}',
      );
      return null;
    }
    _replayCache.recordNonce(
      nodeId: peerNodeId,
      nonce: frame.nonce,
      msgType: frame.msgType.code,
      timestampS: frame.timestampS,
    );

    final session = _HandshakeSession(peerNodeId: peerNodeId);
    session.clientNonce = hello.clientNonce;
    session.peerEphemeralPub = hello.clientEphemeralPub;
    session.serverNonce = _generateNonce16();
    session.localEphemeralPub = _generateEphemeralPub();
    session.state = SipHandshakeState.challengeSent;
    _sessions[peerNodeId] = session;

    final challenge = SipHsChallenge(
      serverNonce: session.serverNonce!,
      echoedClientNonce: session.clientNonce!,
      serverEphemeralPub: session.localEphemeralPub!,
      expiresInS: SipConstants.handshakeTimeoutS,
    );

    final payload = SipHsMessages.encodeChallenge(challenge);

    AppLogging.sip(
      'SIP_HS: <- HS_HELLO from '
      'node=0x${peerNodeId.toRadixString(16)}, '
      'client_nonce=${_hexPrefix(hello.clientNonce)}\n'
      'SIP_HS: -> HS_CHALLENGE, '
      'server_nonce=${_hexPrefix(session.serverNonce!)}',
    );

    return SipFrame(
      versionMajor: SipConstants.sipVersionMajor,
      versionMinor: SipConstants.sipVersionMinor,
      msgType: SipMessageType.hsChallenge,
      flags: SipFlags.isResponse,
      headerLen: SipConstants.sipWrapperMin,
      sessionId: 0,
      nonce: SipCodec.generateNonce(),
      timestampS: _nowS(),
      payloadLen: payload.length,
      payload: payload,
    );
  }

  /// Process a received HS_RESPONSE (responder receives this).
  ///
  /// Returns the HS_ACCEPT [SipFrame] to send, or null on error.
  Future<SipFrame?> handleResponse(int peerNodeId, SipFrame frame) async {
    final session = _sessions[peerNodeId];
    if (session == null || session.state != SipHandshakeState.challengeSent) {
      AppLogging.sip(
        'SIP_HS: unexpected HS_RESPONSE from '
        'node=0x${peerNodeId.toRadixString(16)} '
        '(state=${session?.state})',
      );
      return null;
    }

    if (session.isTimedOut) {
      _failSession(peerNodeId, 'timeout');
      return null;
    }

    final response = SipHsMessages.decodeResponse(frame.payload);
    if (response == null) return null;

    // Verify echoed nonces.
    if (!_bytesEqual(response.echoedServerNonce, session.serverNonce!)) {
      AppLogging.sip(
        'SIP_HS: HS_RESPONSE server_nonce mismatch from '
        'node=0x${peerNodeId.toRadixString(16)}',
      );
      _failSession(peerNodeId, 'server_nonce mismatch');
      return null;
    }
    if (!_bytesEqual(response.echoedClientNonce, session.clientNonce!)) {
      AppLogging.sip(
        'SIP_HS: HS_RESPONSE client_nonce mismatch from '
        'node=0x${peerNodeId.toRadixString(16)}',
      );
      _failSession(peerNodeId, 'client_nonce mismatch');
      return null;
    }

    // Verify session tag.
    final expectedTag = await SipHsMessages.deriveSessionTag(
      session.clientNonce!,
      session.serverNonce!,
    );
    if (response.sessionTag != expectedTag) {
      AppLogging.sip(
        'SIP_HS: HS_RESPONSE session_tag mismatch from '
        'node=0x${peerNodeId.toRadixString(16)}',
      );
      _failSession(peerNodeId, 'session_tag mismatch');
      return null;
    }

    session.sessionTag = expectedTag;
    session.state = SipHandshakeState.accepted;

    final accept = SipHsAccept(
      sessionTag: expectedTag,
      dmTtlS: SipConstants.dmTtlDefaultS,
      flags: 0,
    );

    final payload = SipHsMessages.encodeAccept(accept);

    final result = SipHandshakeResult(
      sessionTag: expectedTag,
      peerNodeId: peerNodeId,
      dmTtlS: SipConstants.dmTtlDefaultS,
      peerEphemeralPub: session.peerEphemeralPub ?? Uint8List(0),
    );

    _completed[peerNodeId] = result;
    _sessions.remove(peerNodeId);

    AppLogging.sip(
      'SIP_HS: <- HS_RESPONSE, session_tag=0x${expectedTag.toRadixString(16)}\n'
      'SIP_HS: -> HS_ACCEPT, session_tag=0x${expectedTag.toRadixString(16)}, '
      'dm_ttl=${SipConstants.dmTtlDefaultS}s\n'
      'SIP_HS: handshake COMPLETE with '
      'node=0x${peerNodeId.toRadixString(16)}',
    );

    return SipFrame(
      versionMajor: SipConstants.sipVersionMajor,
      versionMinor: SipConstants.sipVersionMinor,
      msgType: SipMessageType.hsAccept,
      flags: SipFlags.isResponse,
      headerLen: SipConstants.sipWrapperMin,
      sessionId: expectedTag,
      nonce: SipCodec.generateNonce(),
      timestampS: _nowS(),
      payloadLen: payload.length,
      payload: payload,
    );
  }

  // ---------------------------------------------------------------------------
  // Query
  // ---------------------------------------------------------------------------

  /// Get the current handshake state for a peer.
  SipHandshakeState getState(int peerNodeId) {
    return _sessions[peerNodeId]?.state ?? SipHandshakeState.idle;
  }

  /// Consume a completed handshake result for a peer.
  SipHandshakeResult? consumeResult(int peerNodeId) {
    return _completed.remove(peerNodeId);
  }

  /// Whether a handshake is in progress for [peerNodeId].
  bool hasActiveSession(int peerNodeId) => _sessions.containsKey(peerNodeId);

  /// Cancel an in-progress handshake.
  void cancelHandshake(int peerNodeId) {
    _failSession(peerNodeId, 'cancelled');
  }

  /// Reset all handshake state.
  void reset() {
    _sessions.clear();
    _completed.clear();
  }

  // ---------------------------------------------------------------------------
  // Internal
  // ---------------------------------------------------------------------------

  void _failSession(int peerNodeId, String reason) {
    _sessions.remove(peerNodeId);
    AppLogging.sip(
      'SIP_HS: handshake FAILED with '
      'node=0x${peerNodeId.toRadixString(16)}: $reason',
    );
  }

  void _cleanExpired() {
    final expired = <int>[];
    for (final entry in _sessions.entries) {
      if (entry.value.isTimedOut) {
        expired.add(entry.key);
      }
    }
    for (final nodeId in expired) {
      _failSession(nodeId, 'timeout');
    }
  }

  Uint8List _generateNonce16() {
    final bytes = Uint8List(16);
    for (var i = 0; i < 16; i++) {
      bytes[i] = _random.nextInt(256);
    }
    return bytes;
  }

  Uint8List _generateEphemeralPub() {
    // v0.1: placeholder ephemeral key (32 random bytes).
    // Full X25519 ECDH is a v0.2 consideration.
    final bytes = Uint8List(32);
    for (var i = 0; i < 32; i++) {
      bytes[i] = _random.nextInt(256);
    }
    return bytes;
  }

  int _nowS() => _clock().millisecondsSinceEpoch ~/ 1000;

  String _hexPrefix(Uint8List bytes) {
    final prefix = bytes.sublist(0, bytes.length.clamp(0, 4));
    return prefix.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  bool _bytesEqual(Uint8List a, Uint8List b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
