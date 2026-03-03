// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter_test/flutter_test.dart';
import 'package:socialmesh/features/signals/utils/signal_utils.dart';
import 'package:socialmesh/l10n/app_localizations.dart';
import 'package:socialmesh/l10n/app_localizations_en.dart';

void main() {
  final AppLocalizations l10n = AppLocalizationsEn();

  test(
    'formatSignalTtlCountdown uses seconds under a minute and fades at zero',
    () {
      expect(
        formatSignalTtlCountdown(const Duration(seconds: 59), l10n),
        'Fades in 59s',
      );
      expect(
        formatSignalTtlCountdown(const Duration(seconds: 1), l10n),
        'Fades in 1s',
      );
      expect(
        formatSignalTtlCountdown(const Duration(seconds: 0), l10n),
        'Faded',
      );
      expect(
        formatSignalTtlCountdown(const Duration(seconds: -1), l10n),
        'Faded',
      );
    },
  );
}
