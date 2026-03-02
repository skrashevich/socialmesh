// SPDX-License-Identifier: GPL-3.0-or-later
import 'package:flutter/widgets.dart';

import '../../l10n/app_localizations.dart';

/// Convenience extension on [BuildContext] for accessing [AppLocalizations].
///
/// Usage:
/// ```dart
/// Text(context.l10n.commonCancel)
/// ```
///
/// This is equivalent to `AppLocalizations.of(context)!` but shorter and
/// more readable at every callsite.
extension L10nContext on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
