// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)

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
import 'sip_counters.dart';
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

/// Wrapper for completed handshake results with TTL tracking.
class _CompletedEntry {
  final SipHandshakeResult result;
  final int completedAtMs;

  const _CompletedEntry({required this.result, required this.completedAtMs});
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
    required int localNodeId,
    SipCounters? counters,
    DateTime Function()? clock,
  }) : _replayCache = replayCache,
       _localNodeId = localNodeId,
       _counters = counters,
       _clock = clock ?? DateTime.now;

  final SipReplayCache _replayCache;
  final int _localNodeId;
  final SipCounters? _counters;
  final DateTime Function() _clock;
  final Random _random = Random.secure();

  /// Active sessions keyed by peer node ID.
  final Map<int, _HandshakeSession> _sessions = {};

  /// Completed handshake results waiting to be consumed.
  final Map<int, _CompletedEntry> _completed = {};

  /// Per-peer cooldown timestamps (ms) for handshake failure/timeout.
  ///
  /// Prevents tight retry loops against unreachable or unresponsive peers.
  final Map<int, int> _failCooldownMs = {};

  /// Called whenever any session state changes (progress, accept, fail).
  void Function()? onStateChanged;

  // ---------------------------------------------------------------------------
  // Initiator flow
  // ---------------------------------------------------------------------------

  /// Start a handshake with [peerNodeId].
  ///
  /// Returns the HS_HELLO [SipFrame] to send, or null if a session
  /// already exists for this peer.
  SipFrame? initiateHandshake(int peerNodeId) {
    // Clean up timed-out sessions and stale completed results.
    _cleanExpired();
    _cleanCompletedResults();

    if (_sessions.containsKey(peerNodeId)) {
      AppLogging.sip(
        'SIP_HS: handshake already in progress with '
        'node=0x${peerNodeId.toRadixString(16)}',
      );
      return null;
    }

    // Enforce per-peer cooldown after failure/timeout.
    final cooldownUntilMs = _failCooldownMs[peerNodeId];
    if (cooldownUntilMs != null) {
      final nowMs = _clock().millisecondsSinceEpoch;
      if (nowMs < cooldownUntilMs) {
        final remainingS = (cooldownUntilMs - nowMs) ~/ 1000;
        AppLogging.sip(
          'SIP_HS: handshake initiation to '
          'node=0x${peerNodeId.toRadixString(16)} blocked by '
          'cooldown, ${remainingS}s remaining',
        );
        return null;
      }
      _failCooldownMs.remove(peerNodeId);
    }

    final session = _HandshakeSession(peerNodeId: peerNodeId);
    session.clientNonce = _generateNonce16();
    session.localEphemeralPub = _generateEphemeralPub();
    session.state = SipHandshakeState.helloSent;
    _sessions[peerNodeId] = session;
    _counters?.recordHandshakeInitiated();
    onStateChanged?.call();

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
    onStateChanged?.call();

    // Derive session tag.
    final tag = await SipHsMessages.deriveSessionTag(
      session.clientNonce!,
      session.serverNonce!,
    );
    session.sessionTag = tag;
    session.state = SipHandshakeState.responseSent;
    onStateChanged?.call();

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
    onStateChanged?.call();

    final result = SipHandshakeResult(
      sessionTag: accept.sessionTag,
      peerNodeId: peerNodeId,
      dmTtlS: accept.dmTtlS,
      peerEphemeralPub: session.peerEphemeralPub ?? Uint8List(0),
    );

    _putCompleted(peerNodeId, result);
    _sessions.remove(peerNodeId);
    _failCooldownMs.remove(peerNodeId);
    _counters?.recordHandshakeCompleted();

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
  ///
  /// **Simultaneous-open tie-breaker:** When both peers initiate at the
  /// same time, each receives the other's HS_HELLO while in `helloSent`
  /// state. The node with the higher node ID keeps the initiator role
  /// (ignores the incoming HELLO); the lower node ID yields, discards its
  /// initiator session, and becomes the responder.
  SipFrame? handleHello(int peerNodeId, SipFrame frame) {
    _cleanExpired();
    _cleanCompletedResults();

    final hello = SipHsMessages.decodeHello(frame.payload);
    if (hello == null) return null;

    // Simultaneous-open detection: we already sent HS_HELLO to this peer.
    final existing = _sessions[peerNodeId];
    if (existing != null && existing.state == SipHandshakeState.helloSent) {
      if (_localNodeId > peerNodeId) {
        // We win the tie-break — keep our initiator session, ignore theirs.
        AppLogging.sip(
          'SIP_HS: simultaneous-open with '
          'node=0x${peerNodeId.toRadixString(16)}: '
          'we win tie-break (local=0x${_localNodeId.toRadixString(16)} > '
          'peer=0x${peerNodeId.toRadixString(16)}), keeping initiator role',
        );
        return null;
      } else {
        // We lose the tie-break — discard our initiator session, become
        // the responder for this peer's HELLO.
        AppLogging.sip(
          'SIP_HS: simultaneous-open with '
          'node=0x${peerNodeId.toRadixString(16)}: '
          'we yield (local=0x${_localNodeId.toRadixString(16)} < '
          'peer=0x${peerNodeId.toRadixString(16)}), becoming responder',
        );
        _sessions.remove(peerNodeId);
      }
    }

    // Duplicate HELLO absorption: if we have already sent a CHALLENGE
    // (or are further along), absorb the duplicate without restarting
    // the session. This prevents multi-hop rebroadcast from forking
    // the state machine.
    if (existing != null &&
        existing.state != SipHandshakeState.helloSent &&
        existing.state != SipHandshakeState.idle) {
      AppLogging.sip(
        'SIP_HS: duplicate HELLO ignored for '
        'peer=0x${peerNodeId.toRadixString(16)} '
        'state=${existing.state.name}',
      );
      return null;
    }

    // Already completed — ignore stale HELLO retransmit.
    if (_completed.containsKey(peerNodeId)) {
      AppLogging.sip(
        'SIP_HS: duplicate HELLO ignored for '
        'peer=0x${peerNodeId.toRadixString(16)} (already completed)',
      );
      return null;
    }

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
      _counters?.recordReplayReject();
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
    onStateChanged?.call();

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
    onStateChanged?.call();

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

    _putCompleted(peerNodeId, result);
    _sessions.remove(peerNodeId);
    _failCooldownMs.remove(peerNodeId);
    _counters?.recordHandshakeCompleted();

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
  ///
  /// Also returns [SipHandshakeState.accepted] when a completed result
  /// is waiting to be consumed.
  SipHandshakeState getState(int peerNodeId) {
    final completedEntry = _completed[peerNodeId];
    if (completedEntry != null) {
      return SipHandshakeState.accepted;
    }
    final session = _sessions[peerNodeId];
    if (session != null && session.isTimedOut) {
      _failSession(peerNodeId, 'timeout');
      return SipHandshakeState.timedOut;
    }
    return session?.state ?? SipHandshakeState.idle;
  }

  /// Consume a completed handshake result for a peer.
  SipHandshakeResult? consumeResult(int peerNodeId) {
    return _completed.remove(peerNodeId)?.result;
  }

  /// Whether a handshake is in progress for [peerNodeId].
  bool hasActiveSession(int peerNodeId) => _sessions.containsKey(peerNodeId);

  /// Cancel an in-progress handshake.
  void cancelHandshake(int peerNodeId) {
    _failSession(peerNodeId, 'cancelled');
  }

  /// Whether a peer is in cooldown after a failed handshake.
  bool isInCooldown(int peerNodeId) {
    final cooldownUntilMs = _failCooldownMs[peerNodeId];
    if (cooldownUntilMs == null) return false;
    return _clock().millisecondsSinceEpoch < cooldownUntilMs;
  }

  /// Reset all handshake state.
  void reset() {
    _sessions.clear();
    _completed.clear();
    _failCooldownMs.clear();
  }

  // ---------------------------------------------------------------------------
  // Internal
  // ---------------------------------------------------------------------------

  void _failSession(int peerNodeId, String reason) {
    _sessions.remove(peerNodeId);
    _counters?.recordHandshakeFailed();

    // Set per-peer cooldown to prevent immediate retry.
    final cooldownMs = SipConstants.handshakeCooldownPerPeer.inMilliseconds;
    _failCooldownMs[peerNodeId] = _clock().millisecondsSinceEpoch + cooldownMs;
    _boundFailCooldownMap();

    onStateChanged?.call();
    AppLogging.sip(
      'SIP_HS: handshake FAILED with '
      'node=0x${peerNodeId.toRadixString(16)}: $reason, '
      'cooldown=${cooldownMs ~/ 1000}s',
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

  /// Store a completed result with TTL tracking and enforce bounds.
  void _putCompleted(int peerNodeId, SipHandshakeResult result) {
    _completed[peerNodeId] = _CompletedEntry(
      result: result,
      completedAtMs: _clock().millisecondsSinceEpoch,
    );
    // Enforce max completed results.
    while (_completed.length > SipConstants.maxCompletedResults) {
      int? oldestKey;
      int oldestMs = 0x7FFFFFFFFFFFFFFF;
      for (final entry in _completed.entries) {
        if (entry.value.completedAtMs < oldestMs) {
          oldestMs = entry.value.completedAtMs;
          oldestKey = entry.key;
        }
      }
      if (oldestKey != null) {
        _completed.remove(oldestKey);
      }
    }
  }

  /// Evict completed results that have exceeded their TTL.
  void _cleanCompletedResults() {
    final nowMs = _clock().millisecondsSinceEpoch;
    final ttlMs = SipConstants.completedResultTtl.inMilliseconds;
    _completed.removeWhere((_, entry) => nowMs - entry.completedAtMs > ttlMs);
  }

  /// Bound the per-peer failure cooldown map.
  void _boundFailCooldownMap() {
    while (_failCooldownMs.length > SipConstants.maxTrackedPeers) {
      int? oldestKey;
      int oldestMs = 0x7FFFFFFFFFFFFFFF;
      for (final entry in _failCooldownMs.entries) {
        if (entry.value < oldestMs) {
          oldestMs = entry.value;
          oldestKey = entry.key;
        }
      }
      if (oldestKey != null) {
        _failCooldownMs.remove(oldestKey);
      }
    }
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
