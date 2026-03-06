// SPDX-License-Identifier: GPL-3.0-or-later

/// SIP ephemeral DM session manager.
///
/// Manages session-scoped DM threads created after successful SIP-1
/// handshakes. Sessions are identified by the handshake-derived
/// session_tag and expire after a configurable TTL (default 24h).
///
/// Key constraints:
/// - Messages are channel-encrypted (PSK) + session-tag-scoped.
/// - All sends counted against the SIP token-bucket budget.
/// - User can pin sessions to prevent expiry.
/// - Expired sessions are lazily cleaned up on access.
library;

import '../../../core/logging.dart';
import 'sip_codec.dart';
import 'sip_constants.dart';
import 'sip_counters.dart';
import 'sip_frame.dart';
import 'sip_messages_dm.dart';
import 'sip_rate_limiter.dart';
import 'sip_types.dart';

/// Status of a DM session.
enum SipDmSessionStatus {
  /// Active session, messages can be sent/received.
  active,

  /// Session has expired and will be cleaned up.
  expired,

  /// Session was explicitly closed by the user.
  closed,
}

/// A single ephemeral DM session.
class SipDmSession {
  /// Session tag from the handshake.
  final int sessionTag;

  /// Peer node ID.
  final int peerNodeId;

  /// Session creation timestamp (ms since epoch).
  final int createdAtMs;

  /// TTL in seconds.
  final int ttlS;

  /// Whether this session is pinned (no expiry).
  bool isPinned;

  /// Current session status.
  SipDmSessionStatus status;

  /// Message history for this session.
  final List<SipDmHistoryEntry> messages;

  SipDmSession({
    required this.sessionTag,
    required this.peerNodeId,
    required this.createdAtMs,
    required this.ttlS,
    this.isPinned = false,
    this.status = SipDmSessionStatus.active,
    List<SipDmHistoryEntry>? messages,
  }) : messages = messages ?? [];

  /// Check if this session has expired based on [nowMs].
  bool isExpired(int nowMs) {
    if (isPinned) return false;
    if (status == SipDmSessionStatus.closed) return true;
    final expiresAtMs = createdAtMs + (ttlS * 1000);
    return nowMs >= expiresAtMs;
  }
}

/// Direction of a DM message.
enum SipDmDirection {
  /// Message sent by the local user.
  outbound,

  /// Message received from the peer.
  inbound,
}

/// A single message in the DM history.
class SipDmHistoryEntry {
  /// The text content.
  final String text;

  /// Timestamp of the message (ms since epoch).
  final int timestampMs;

  /// Whether this message was sent or received.
  final SipDmDirection direction;

  const SipDmHistoryEntry({
    required this.text,
    required this.timestampMs,
    required this.direction,
  });
}

/// Result of trying to send a DM.
class SipDmSendResult {
  /// The encoded SIP frame ready to transmit, or null on failure.
  final SipFrame? frame;

  /// Error reason if frame is null.
  final SipDmSendError? error;

  const SipDmSendResult._({this.frame, this.error});

  /// Successful send.
  factory SipDmSendResult.ok(SipFrame frame) => SipDmSendResult._(frame: frame);

  /// Failed send.
  factory SipDmSendResult.fail(SipDmSendError error) =>
      SipDmSendResult._(error: error);

  bool get isOk => frame != null;
}

/// Reasons a DM send can fail.
enum SipDmSendError {
  /// Session tag not found or expired.
  sessionNotFound,

  /// Text is empty.
  emptyText,

  /// Text exceeds max byte length.
  textTooLong,

  /// Rate limiter rejected the send.
  budgetExhausted,

  /// Session has been closed.
  sessionClosed,

  /// Encoding failed.
  encodingFailed,
}

/// Manages ephemeral DM sessions and message exchange.
///
/// Sessions are created from [SipHandshakeResult] data after a
/// successful handshake. Each session has a TTL (default 24h) and
/// can be pinned to prevent expiry.
class SipDmManager {
  /// Creates a DM manager.
  ///
  /// [rateLimiter] is used to enforce the SIP airtime budget.
  /// [clock] can be injected for testing (returns ms since epoch).
  SipDmManager({
    required SipRateLimiter rateLimiter,
    SipCounters? counters,
    int Function()? clock,
  }) : _rateLimiter = rateLimiter,
       _counters = counters,
       _clock = clock ?? _defaultClock;

  final SipRateLimiter _rateLimiter;
  final SipCounters? _counters;
  final int Function() _clock;

  /// Active sessions keyed by session_tag.
  final Map<int, SipDmSession> _sessions = {};

  static int _defaultClock() => DateTime.now().millisecondsSinceEpoch;

  // ---------------------------------------------------------------------------
  // Session lifecycle
  // ---------------------------------------------------------------------------

  /// Create a new DM session from a completed handshake.
  ///
  /// Returns the created session, or null if a session with this
  /// tag already exists.
  SipDmSession? createSession({
    required int sessionTag,
    required int peerNodeId,
    int? ttlS,
  }) {
    if (_sessions.containsKey(sessionTag)) {
      AppLogging.sip(
        'SIP_DM: session already exists for '
        'tag=0x${sessionTag.toRadixString(16)}',
      );
      return null;
    }

    final session = SipDmSession(
      sessionTag: sessionTag,
      peerNodeId: peerNodeId,
      createdAtMs: _clock(),
      ttlS: ttlS ?? SipConstants.dmTtlDefaultS,
    );
    _sessions[sessionTag] = session;

    AppLogging.sip(
      'SIP_DM: session created, tag=0x${sessionTag.toRadixString(16)}, '
      'ttl=${session.ttlS}s, peer=0x${peerNodeId.toRadixString(16)}',
    );

    return session;
  }

  /// Get a session by tag. Returns null if not found or expired.
  SipDmSession? getSession(int sessionTag) {
    final session = _sessions[sessionTag];
    if (session == null) return null;

    if (session.isExpired(_clock())) {
      _expireSession(sessionTag);
      return null;
    }

    return session;
  }

  /// Get all active (non-expired) sessions.
  List<SipDmSession> get activeSessions {
    _cleanExpired();
    return List.unmodifiable(
      _sessions.values.where((s) => s.status == SipDmSessionStatus.active),
    );
  }

  /// Pin a session to prevent expiry.
  ///
  /// Returns false if session not found.
  bool pinSession(int sessionTag) {
    final session = _sessions[sessionTag];
    if (session == null) return false;

    if (session.isExpired(_clock())) {
      _expireSession(sessionTag);
      return false;
    }

    session.isPinned = true;
    AppLogging.sip(
      'SIP_DM: session pinned, tag=0x${sessionTag.toRadixString(16)}',
    );
    return true;
  }

  /// Unpin a session (re-enables TTL expiry).
  ///
  /// Returns false if session not found or not pinned.
  bool unpinSession(int sessionTag) {
    final session = _sessions[sessionTag];
    if (session == null) return false;

    if (!session.isPinned) return false;

    session.isPinned = false;
    AppLogging.sip(
      'SIP_DM: session unpinned, tag=0x${sessionTag.toRadixString(16)}',
    );
    return true;
  }

  /// Close a session explicitly.
  ///
  /// Returns false if session not found.
  bool closeSession(int sessionTag) {
    final session = _sessions[sessionTag];
    if (session == null) return false;

    session.status = SipDmSessionStatus.closed;
    AppLogging.sip(
      'SIP_DM: session closed, tag=0x${sessionTag.toRadixString(16)}',
    );
    return true;
  }

  // ---------------------------------------------------------------------------
  // Message sending
  // ---------------------------------------------------------------------------

  /// Build a DM_MSG frame for the given session.
  ///
  /// Returns a [SipDmSendResult] with either the frame or an error.
  /// The message is also added to the session's history on success.
  SipDmSendResult buildDmMessage({
    required int sessionTag,
    required String text,
  }) {
    final session = _sessions[sessionTag];
    if (session == null || session.isExpired(_clock())) {
      if (session != null) _expireSession(sessionTag);
      return SipDmSendResult.fail(SipDmSendError.sessionNotFound);
    }

    if (session.status != SipDmSessionStatus.active) {
      return SipDmSendResult.fail(SipDmSendError.sessionClosed);
    }

    if (text.isEmpty) {
      return SipDmSendResult.fail(SipDmSendError.emptyText);
    }

    final payload = SipDmMessages.encodeDm(text);
    if (payload == null) {
      // Text exceeds max length after UTF-8 encoding.
      return SipDmSendResult.fail(SipDmSendError.textTooLong);
    }

    // Check airtime budget.
    final frameSize = SipConstants.sipWrapperMin + payload.length;
    if (!_rateLimiter.canSend(frameSize)) {
      AppLogging.sip(
        'SIP_DM: send blocked by budget for '
        'tag=0x${sessionTag.toRadixString(16)}',
      );
      _counters?.recordBudgetThrottle();
      return SipDmSendResult.fail(SipDmSendError.budgetExhausted);
    }

    // Deduct budget.
    _rateLimiter.recordSend(frameSize);

    final frame = SipFrame(
      versionMajor: SipConstants.sipVersionMajor,
      versionMinor: SipConstants.sipVersionMinor,
      msgType: SipMessageType.dmMsg,
      flags: 0,
      headerLen: SipConstants.sipWrapperMin,
      sessionId: sessionTag,
      nonce: SipCodec.generateNonce(),
      timestampS: _clock() ~/ 1000,
      payloadLen: payload.length,
      payload: payload,
    );

    // Add to history.
    session.messages.add(
      SipDmHistoryEntry(
        text: text,
        timestampMs: _clock(),
        direction: SipDmDirection.outbound,
      ),
    );

    AppLogging.sip(
      'SIP_DM: -> DM ${payload.length}B to '
      'session=0x${sessionTag.toRadixString(16)}',
    );

    return SipDmSendResult.ok(frame);
  }

  // ---------------------------------------------------------------------------
  // Message receiving
  // ---------------------------------------------------------------------------

  /// Handle an inbound DM_MSG frame.
  ///
  /// Returns the parsed [SipDmMessage] if the session_tag matches
  /// an active session, or null if dropped.
  SipDmMessage? handleInboundDm(SipFrame frame) {
    if (frame.msgType != SipMessageType.dmMsg) {
      AppLogging.sip('SIP_DM: handleInboundDm called with wrong msg_type');
      return null;
    }

    final sessionTag = frame.sessionId;
    final session = _sessions[sessionTag];

    if (session == null) {
      AppLogging.sip(
        'SIP_DM: inbound DM dropped: unknown '
        'session=0x${sessionTag.toRadixString(16)}',
      );
      return null;
    }

    if (session.isExpired(_clock())) {
      _expireSession(sessionTag);
      AppLogging.sip(
        'SIP_DM: inbound DM dropped: expired '
        'session=0x${sessionTag.toRadixString(16)}',
      );
      return null;
    }

    if (session.status != SipDmSessionStatus.active) {
      AppLogging.sip(
        'SIP_DM: inbound DM dropped: closed '
        'session=0x${sessionTag.toRadixString(16)}',
      );
      return null;
    }

    final message = SipDmMessages.decodeDm(frame.payload);
    if (message == null) return null;

    // Add to history.
    session.messages.add(
      SipDmHistoryEntry(
        text: message.text,
        timestampMs: _clock(),
        direction: SipDmDirection.inbound,
      ),
    );

    AppLogging.sip(
      'SIP_DM: <- DM ${frame.payload.length}B from '
      'session=0x${sessionTag.toRadixString(16)}',
    );

    return message;
  }

  // ---------------------------------------------------------------------------
  // Cleanup
  // ---------------------------------------------------------------------------

  /// Remove all expired sessions.
  int cleanExpired() => _cleanExpired();

  /// Reset all state (disconnect/reconnect scenario).
  void reset() {
    _sessions.clear();
    AppLogging.sip('SIP_DM: all sessions cleared');
  }

  /// Number of currently tracked sessions (including expired not yet cleaned).
  int get sessionCount => _sessions.length;

  /// Get message history for a session.
  List<SipDmHistoryEntry>? getHistory(int sessionTag) {
    final session = _sessions[sessionTag];
    if (session == null) return null;
    return List.unmodifiable(session.messages);
  }

  // ---------------------------------------------------------------------------
  // Internal helpers
  // ---------------------------------------------------------------------------

  int _cleanExpired() {
    final nowMs = _clock();
    final expired = <int>[];
    for (final entry in _sessions.entries) {
      if (entry.value.isExpired(nowMs)) {
        expired.add(entry.key);
      }
    }
    for (final tag in expired) {
      _expireSession(tag);
    }
    return expired.length;
  }

  void _expireSession(int sessionTag) {
    final session = _sessions[sessionTag];
    if (session != null && session.status == SipDmSessionStatus.active) {
      session.status = SipDmSessionStatus.expired;
      AppLogging.sip(
        'SIP_DM: session 0x${sessionTag.toRadixString(16)} expired '
        'after ${session.ttlS}s, cleaned up',
      );
    }
    _sessions.remove(sessionTag);
  }
}
