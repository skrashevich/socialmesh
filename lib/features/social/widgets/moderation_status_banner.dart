// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n_extension.dart';
import '../../../core/widgets/animations.dart';
import '../../../providers/social_providers.dart';
import '../screens/moderation_status_screen.dart';
import 'package:socialmesh/core/theme.dart';

/// Banner showing current moderation status (warnings, strikes).
/// Displayed at top of social screens when user has active moderation items.
class ModerationStatusBanner extends ConsumerWidget {
  const ModerationStatusBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusAsync = ref.watch(moderationStatusProvider);

    return statusAsync.when(
      data: (status) {
        if (status == null) return const SizedBox.shrink();

        // Check for unacknowledged items or active status
        final hasUnacknowledged = status.unacknowledgedCount > 0;
        final hasActiveWarnings = status.activeWarnings > 0;
        final hasActiveStrikes = status.activeStrikes > 0;

        if (!hasUnacknowledged && !hasActiveWarnings && !hasActiveStrikes) {
          return const SizedBox.shrink();
        }

        // Determine severity and colors
        Color backgroundColor;
        Color textColor;
        IconData icon;
        String message;

        if (hasActiveStrikes) {
          backgroundColor = AccentColors.orange.withValues(alpha: 0.15);
          textColor = AccentColors.orange;
          icon = Icons.warning_amber_rounded;
          message = hasUnacknowledged
              ? context.l10n.socialStrikeTapReview(status.activeStrikes)
              : context.l10n.socialStrikesOnAccount(status.activeStrikes);
        } else if (hasActiveWarnings) {
          backgroundColor = AppTheme.warningYellow.withValues(alpha: 0.15);
          textColor = AppTheme.warningYellow;
          icon = Icons.info_outline;
          message = hasUnacknowledged
              ? context.l10n.socialWarningsTapReview(status.activeWarnings)
              : context.l10n.socialWarningsOnAccount(status.activeWarnings);
        } else {
          return const SizedBox.shrink();
        }

        return BouncyTap(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ModerationStatusScreen()),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(AppTheme.radius12),
              border: Border.all(color: textColor.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(icon, color: textColor, size: 20),
                const SizedBox(width: AppTheme.spacing12),
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (hasUnacknowledged) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: textColor,
                      borderRadius: BorderRadius.circular(AppTheme.radius12),
                    ),
                    child: Text(
                      '${status.unacknowledgedCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing8),
                ],
                Icon(
                  Icons.chevron_right,
                  color: textColor.withValues(alpha: 0.7),
                  size: 20,
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}
