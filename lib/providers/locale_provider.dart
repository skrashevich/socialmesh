// SPDX-License-Identifier: GPL-3.0-or-later
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/logging.dart';
import 'app_providers.dart';

/// Provider for the user's preferred locale.
///
/// Returns `null` when "System Default" is selected, meaning the app
/// should use the device locale. Returns a [Locale] when the user has
/// explicitly chosen a language.
class LocaleNotifier extends Notifier<Locale?> {
  @override
  Locale? build() {
    final settings = ref.watch(settingsServiceProvider).asData?.value;
    if (settings == null) return null;

    final code = settings.preferredLocale;
    if (code == null) return null;

    return Locale(code);
  }

  /// Set the preferred locale. Pass `null` for system default.
  Future<void> setLocale(Locale? locale) async {
    final settings = await ref.read(settingsServiceProvider.future);
    await settings.setPreferredLocale(locale?.languageCode);
    state = locale;
    AppLogging.settings(
      'Locale changed to ${locale?.languageCode ?? "system"}',
    );
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale?>(
  LocaleNotifier.new,
);
