// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)

/// Token-bucket rate limiter enforcing byte-level SIP airtime budgets.
///
/// Implements a proportional-refill token bucket where tokens represent
/// bytes. All SIP message types draw from the same bucket, capped at
/// [SipConstants.sipBudgetBytesPer60s] per rolling 60-second window.
///
/// Congestion detection pauses non-essential SIP transmissions when
/// non-SIP chat traffic is observed on the mesh.
library;

import 'dart:math';

import '../../../core/logging.dart';
import 'sip_constants.dart';

/// Byte-level token-bucket rate limiter for all SIP traffic.
///
/// The bucket starts full at [SipConstants.sipBudgetBytesPer60s] tokens
/// and refills proportionally based on elapsed time since the last refill.
///
/// Congestion heuristic: if non-SIP chat traffic was observed within the
/// last [SipConstants.congestionPause] window, non-essential SIP sends
/// are suppressed.
class SipRateLimiter {
  /// Creates a rate limiter.
  ///
  /// [clock] can be injected for deterministic testing.
  SipRateLimiter({DateTime Function()? clock})
    : _clock = clock ?? DateTime.now,
      _remainingBytes = SipConstants.sipBudgetBytesPer60s,
      _lastRefillMs = (clock ?? DateTime.now).call().millisecondsSinceEpoch,
      _lastChatTrafficMs = 0;

  final DateTime Function() _clock;

  /// Remaining byte budget in the current window.
  int _remainingBytes;

  /// Timestamp (ms) of the last bucket refill.
  int _lastRefillMs;

  /// Timestamp (ms) of the last observed non-SIP chat traffic.
  int _lastChatTrafficMs;

  /// Current retry backoff counter (0 = no backoff active).
  int _backoffCount = 0;

  // ---------------------------------------------------------------------------
  // Budget query
  // ---------------------------------------------------------------------------

  /// Returns the current remaining byte budget after refill.
  int get remainingBytes {
    _refill();
    return _remainingBytes;
  }

  /// Total budget capacity.
  int get capacity => SipConstants.sipBudgetBytesPer60s;

  /// Fraction of budget used (0.0 = empty, 1.0 = fully consumed).
  double get usageFraction {
    _refill();
    return 1.0 - (_remainingBytes / SipConstants.sipBudgetBytesPer60s);
  }

  /// Whether budget usage exceeds 80% of capacity.
  bool get isBudgetHigh => usageFraction > 0.8;

  // ---------------------------------------------------------------------------
  // Send gating
  // ---------------------------------------------------------------------------

  /// Returns true if [bytes] can be sent without exceeding the budget.
  bool canSend(int bytes) {
    _refill();
    return _remainingBytes >= bytes;
  }

  /// Record that [bytes] were sent. Deducts from the bucket.
  ///
  /// Call this after a successful SIP frame transmission.
  void recordSend(int bytes) {
    _refill();
    _remainingBytes = (_remainingBytes - bytes).clamp(0, capacity);
    _backoffCount = 0; // Successful send resets backoff.
    AppLogging.sip(
      'SIP_RATE: send ${bytes}B, remaining=$_remainingBytes/$capacity, '
      'window=${SipConstants.sipBudgetWindow.inSeconds}s',
    );
  }

  /// Record a failed send attempt for backoff tracking.
  void recordFailedSend() {
    _backoffCount++;
    AppLogging.sip('SIP_RATE: send blocked, backoff_count=$_backoffCount');
  }

  // ---------------------------------------------------------------------------
  // Congestion detection
  // ---------------------------------------------------------------------------

  /// Notify the rate limiter that non-SIP chat traffic was observed.
  ///
  /// This triggers the congestion heuristic, which suppresses non-essential
  /// SIP transmissions for [SipConstants.congestionPause].
  void observeChatTraffic() {
    _lastChatTrafficMs = _clock().millisecondsSinceEpoch;
    AppLogging.sip(
      'SIP_RATE: congestion detected (chat traffic in last '
      '${SipConstants.congestionPauseS}s), pausing SIP for '
      '${SipConstants.congestionPauseS}s',
    );
  }

  /// Whether the mesh is currently congested (chat traffic observed recently).
  bool get isCongested {
    if (_lastChatTrafficMs == 0) return false;
    final nowMs = _clock().millisecondsSinceEpoch;
    return (nowMs - _lastChatTrafficMs) <
        SipConstants.congestionPause.inMilliseconds;
  }

  /// Whether non-essential SIP sends should be suppressed.
  ///
  /// Returns true if congested OR budget > 80% used.
  bool get shouldSuppressNonEssential => isCongested || isBudgetHigh;

  // ---------------------------------------------------------------------------
  // Backoff
  // ---------------------------------------------------------------------------

  /// Current exponential backoff duration based on retry count.
  ///
  /// Uses base [SipConstants.backoffBase] with exponential growth up to
  /// [SipConstants.backoffMax], plus random jitter of 0-25%.
  Duration get currentBackoff {
    if (_backoffCount == 0) return Duration.zero;
    final baseMs = SipConstants.backoffBase.inMilliseconds;
    final maxMs = SipConstants.backoffMax.inMilliseconds;
    final expMs = (baseMs * (1 << (_backoffCount - 1).clamp(0, 15))).clamp(
      baseMs,
      maxMs,
    );
    // Add 0-25% jitter.
    final jitterMs = (expMs * 0.25 * _jitterFraction()).round();
    return Duration(milliseconds: expMs + jitterMs);
  }

  /// Reset backoff counter (e.g., after a successful send).
  void resetBackoff() => _backoffCount = 0;

  // ---------------------------------------------------------------------------
  // Resume safety
  // ---------------------------------------------------------------------------

  /// Apply a persisted timestamp to prevent burst after app resume.
  ///
  /// Call this on app start with the timestamp of the last known budget
  /// reset. The bucket refills proportionally from that point.
  void restoreFromTimestamp(int lastResetMs) {
    final nowMs = _clock().millisecondsSinceEpoch;
    final elapsedMs = (nowMs - lastResetMs).clamp(0, double.maxFinite.toInt());
    final refillBytes = _computeRefill(elapsedMs);
    _remainingBytes = refillBytes.clamp(0, capacity);
    _lastRefillMs = nowMs;
    AppLogging.sip(
      'SIP_RATE: restored from timestamp, elapsed=${elapsedMs}ms, '
      'remaining=$_remainingBytes/$capacity',
    );
  }

  /// The timestamp (ms) of the last refill, for persistence.
  int get lastRefillTimestampMs => _lastRefillMs;

  // ---------------------------------------------------------------------------
  // Reset
  // ---------------------------------------------------------------------------

  /// Reset the limiter to a full bucket.
  void reset() {
    _remainingBytes = capacity;
    _lastRefillMs = _clock().millisecondsSinceEpoch;
    _lastChatTrafficMs = 0;
    _backoffCount = 0;
  }

  // ---------------------------------------------------------------------------
  // Internal
  // ---------------------------------------------------------------------------

  /// Proportional refill based on elapsed time.
  void _refill() {
    final nowMs = _clock().millisecondsSinceEpoch;
    final elapsedMs = nowMs - _lastRefillMs;
    if (elapsedMs <= 0) return;

    final refillBytes = _computeRefill(elapsedMs);
    if (refillBytes > 0) {
      final before = _remainingBytes;
      _remainingBytes = (_remainingBytes + refillBytes).clamp(0, capacity);
      _lastRefillMs = nowMs;
      if (_remainingBytes != before) {
        AppLogging.sip(
          'SIP_RATE: refill +${_remainingBytes - before}B after '
          '${elapsedMs}ms elapsed, remaining=$_remainingBytes/$capacity',
        );
      }
    }
  }

  /// Compute how many bytes to refill for a given elapsed time.
  int _computeRefill(int elapsedMs) {
    // Proportional: capacity bytes per window duration.
    final windowMs = SipConstants.sipBudgetWindow.inMilliseconds;
    return (SipConstants.sipBudgetBytesPer60s * elapsedMs) ~/ windowMs;
  }

  /// Returns a jitter fraction in [0.0, 1.0).
  double _jitterFraction() => Random().nextDouble();
}
