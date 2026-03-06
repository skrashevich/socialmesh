// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)

import 'package:flutter_test/flutter_test.dart';
import 'package:socialmesh/services/protocol/sip/sip_constants.dart';
import 'package:socialmesh/services/protocol/sip/sip_rate_limiter.dart';

void main() {
  late int nowMs;
  late SipRateLimiter limiter;

  DateTime clock() => DateTime.fromMillisecondsSinceEpoch(nowMs);

  setUp(() {
    nowMs = DateTime(2026, 3, 5).millisecondsSinceEpoch;
    limiter = SipRateLimiter(clock: clock);
  });

  group('SipRateLimiter', () {
    test('starts with full budget', () {
      expect(limiter.remainingBytes, SipConstants.sipBudgetBytesPer60s);
      expect(limiter.canSend(1024), isTrue);
    });

    test('canSend returns false when budget insufficient', () {
      limiter.recordSend(1000);
      expect(limiter.canSend(100), isFalse);
      expect(limiter.canSend(24), isTrue);
    });

    test('recordSend deducts bytes from bucket', () {
      limiter.recordSend(100);
      expect(limiter.remainingBytes, 924);
      limiter.recordSend(400);
      expect(limiter.remainingBytes, 524);
    });

    test('budget never goes below zero', () {
      limiter.recordSend(1024);
      expect(limiter.remainingBytes, 0);
      limiter.recordSend(100);
      expect(limiter.remainingBytes, 0);
    });

    test('refills proportionally based on elapsed time', () {
      limiter.recordSend(1024);
      expect(limiter.remainingBytes, 0);

      // Advance 30 seconds (half the window).
      nowMs += 30000;
      // Should refill ~512 bytes (1024 * 30 / 60).
      expect(limiter.remainingBytes, 512);
    });

    test('refills fully after one complete window', () {
      limiter.recordSend(1024);
      expect(limiter.remainingBytes, 0);

      // Advance 60 seconds (full window).
      nowMs += 60000;
      expect(limiter.remainingBytes, SipConstants.sipBudgetBytesPer60s);
    });

    test('refill caps at capacity', () {
      // Already full, advance time.
      nowMs += 120000;
      expect(limiter.remainingBytes, SipConstants.sipBudgetBytesPer60s);
    });

    test('partial refill is proportional', () {
      limiter.recordSend(1024);

      // Advance 15 seconds (quarter window).
      nowMs += 15000;
      // Should refill ~256 bytes (1024 * 15 / 60).
      expect(limiter.remainingBytes, 256);
    });

    test('usageFraction tracks correctly', () {
      expect(limiter.usageFraction, 0.0);
      limiter.recordSend(512);
      expect(limiter.usageFraction, closeTo(0.5, 0.01));
      limiter.recordSend(512);
      expect(limiter.usageFraction, 1.0);
    });

    test('isBudgetHigh triggers at 80% usage', () {
      expect(limiter.isBudgetHigh, isFalse);
      limiter.recordSend(819); // ~80%
      expect(limiter.isBudgetHigh, isFalse);
      limiter.recordSend(1); // Push past 80%.
      expect(limiter.isBudgetHigh, isTrue);
    });

    group('congestion detection', () {
      test('not congested by default', () {
        expect(limiter.isCongested, isFalse);
      });

      test('congested after chat traffic observed', () {
        limiter.observeChatTraffic();
        expect(limiter.isCongested, isTrue);
      });

      test('congestion clears after pause duration', () {
        limiter.observeChatTraffic();
        expect(limiter.isCongested, isTrue);

        // Advance past congestion pause.
        nowMs += SipConstants.congestionPause.inMilliseconds;
        expect(limiter.isCongested, isFalse);
      });

      test('shouldSuppressNonEssential when congested', () {
        limiter.observeChatTraffic();
        expect(limiter.shouldSuppressNonEssential, isTrue);
      });

      test('shouldSuppressNonEssential when budget high', () {
        limiter.recordSend(900);
        expect(limiter.shouldSuppressNonEssential, isTrue);
      });
    });

    group('backoff', () {
      test('no backoff initially', () {
        expect(limiter.currentBackoff, Duration.zero);
      });

      test('backoff grows exponentially', () {
        limiter.recordFailedSend();
        final first = limiter.currentBackoff;
        expect(first.inMilliseconds, greaterThanOrEqualTo(2000));
        expect(first.inMilliseconds, lessThanOrEqualTo(2500));

        limiter.recordFailedSend();
        final second = limiter.currentBackoff;
        expect(second.inMilliseconds, greaterThanOrEqualTo(4000));

        limiter.recordFailedSend();
        final third = limiter.currentBackoff;
        expect(third.inMilliseconds, greaterThanOrEqualTo(8000));
      });

      test('backoff caps at max', () {
        for (var i = 0; i < 20; i++) {
          limiter.recordFailedSend();
        }
        final maxBackoff = limiter.currentBackoff;
        expect(
          maxBackoff.inMilliseconds,
          lessThanOrEqualTo(SipConstants.backoffMax.inMilliseconds * 1.25 + 1),
        );
      });

      test('successful send resets backoff', () {
        limiter.recordFailedSend();
        limiter.recordFailedSend();
        expect(limiter.currentBackoff.inMilliseconds, greaterThan(0));

        limiter.recordSend(32);
        expect(limiter.currentBackoff, Duration.zero);
      });
    });

    group('resume safety', () {
      test('restoreFromTimestamp refills proportionally', () {
        limiter.recordSend(1024);
        expect(limiter.remainingBytes, 0);

        // Simulate 30 seconds elapsed since last reset.
        final lastResetMs = nowMs - 30000;
        limiter.restoreFromTimestamp(lastResetMs);

        // Should have ~512 bytes.
        expect(limiter.remainingBytes, 512);
      });

      test('restoreFromTimestamp caps at capacity', () {
        limiter.recordSend(1024);

        // Simulate 120 seconds elapsed.
        final lastResetMs = nowMs - 120000;
        limiter.restoreFromTimestamp(lastResetMs);

        expect(limiter.remainingBytes, SipConstants.sipBudgetBytesPer60s);
      });

      test('no burst after resume', () {
        // Even with long elapsed time, max is capacity.
        final lastResetMs = nowMs - 600000; // 10 minutes.
        limiter.restoreFromTimestamp(lastResetMs);

        expect(limiter.remainingBytes, SipConstants.sipBudgetBytesPer60s);
      });
    });

    group('reset', () {
      test('reset restores full budget', () {
        limiter.recordSend(1024);
        limiter.observeChatTraffic();
        limiter.recordFailedSend();

        limiter.reset();

        expect(limiter.remainingBytes, SipConstants.sipBudgetBytesPer60s);
        expect(limiter.isCongested, isFalse);
        expect(limiter.currentBackoff, Duration.zero);
      });
    });

    group('invariants', () {
      test('rolling 60s bytes never exceeds budget', () {
        // Drain budget completely.
        limiter.recordSend(1024);
        expect(limiter.canSend(1), isFalse);

        // After half window, can send half budget.
        nowMs += 30000;
        expect(limiter.canSend(512), isTrue);
        expect(limiter.canSend(513), isFalse);
      });

      test('beacon interval enforced during congestion', () {
        limiter.observeChatTraffic();
        expect(limiter.shouldSuppressNonEssential, isTrue);

        // After congestion clears, should allow again.
        nowMs += SipConstants.congestionPause.inMilliseconds;
        expect(limiter.shouldSuppressNonEssential, isFalse);
      });
    });
  });
}
