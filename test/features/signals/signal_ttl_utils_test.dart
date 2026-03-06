// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)

import 'package:flutter_test/flutter_test.dart';
import 'package:socialmesh/features/signals/utils/signal_utils.dart';
import 'package:socialmesh/l10n/app_localizations.dart';
import 'package:socialmesh/l10n/app_localizations_en.dart';

void main() {
  final AppLocalizations l10n = AppLocalizationsEn();

  group('formatSignalTtlCountdown', () {
    test('returns empty string for null', () {
      expect(formatSignalTtlCountdown(null, l10n), '');
    });

    test('returns Faded for zero or negative', () {
      expect(
        formatSignalTtlCountdown(const Duration(seconds: 0), l10n),
        'Faded',
      );
      expect(
        formatSignalTtlCountdown(const Duration(seconds: -1), l10n),
        'Faded',
      );
    });

    test('uses seconds under 60s', () {
      expect(
        formatSignalTtlCountdown(const Duration(seconds: 59), l10n),
        'Fades in 59s',
      );
    });

    test('uses minutes + seconds under 10m', () {
      expect(
        formatSignalTtlCountdown(const Duration(seconds: 60), l10n),
        'Fades in 1m 0s',
      );
      expect(
        formatSignalTtlCountdown(const Duration(minutes: 1, seconds: 30), l10n),
        'Fades in 1m 30s',
      );
      expect(
        formatSignalTtlCountdown(const Duration(minutes: 9, seconds: 59), l10n),
        'Fades in 9m 59s',
      );
    });

    test('uses minutes only at 10m+', () {
      expect(
        formatSignalTtlCountdown(const Duration(minutes: 10), l10n),
        'Fades in 10m',
      );
      expect(
        formatSignalTtlCountdown(const Duration(minutes: 59), l10n),
        'Fades in 59m',
      );
    });

    test('uses hours under 24h', () {
      expect(
        formatSignalTtlCountdown(const Duration(hours: 1), l10n),
        'Fades in 1h',
      );
    });

    test('uses days at 24h+', () {
      expect(
        formatSignalTtlCountdown(const Duration(days: 2), l10n),
        'Fades in 2d',
      );
    });
  });
}
