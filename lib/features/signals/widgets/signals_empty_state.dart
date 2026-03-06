// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)

import 'package:flutter/material.dart';

import '../../../core/l10n/l10n_extension.dart';
import '../../../core/widgets/animated_empty_state.dart';

/// Animated empty state for the signals screen.
/// Uses the reusable AnimatedEmptyState widget for consistency across Social screens.
class SignalsEmptyState extends StatelessWidget {
  const SignalsEmptyState({
    super.key,
    required this.canGoActive,
    required this.blockedReason,
    required this.onGoActive,
  });

  final bool canGoActive;
  final String? blockedReason;
  final VoidCallback onGoActive;

  static const _icons = [
    Icons.sensors_off,
    Icons.near_me,
    Icons.router,
    Icons.image,
    Icons.location_on,
    Icons.chat_bubble_outline,
    Icons.schedule,
    Icons.bookmark_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final taglines = [
      l10n.signalEmptyTagline1,
      l10n.signalEmptyTagline2,
      l10n.signalEmptyTagline3,
      l10n.signalEmptyTagline4,
    ];

    return AnimatedEmptyState(
      config: AnimatedEmptyStateConfig(
        icons: _icons,
        taglines: taglines,
        titlePrefix: l10n.signalEmptyTitlePrefix,
        titleKeyword: l10n.signalEmptyTitleKeyword,
        titleSuffix: l10n.signalEmptyTitleSuffix,
        actionLabel: l10n.signalGoActiveAction,
        actionIcon: Icons.sensors,
        onAction: onGoActive,
        actionEnabled: canGoActive,
        actionDisabledReason: blockedReason,
      ),
    );
  }
}
