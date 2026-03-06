// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)
import 'package:flutter/material.dart';
import 'package:socialmesh/core/theme.dart';
import 'package:socialmesh/l10n/app_localizations.dart';

/// Utility functions for signal-related UI components.
///
/// These functions provide consistent styling and formatting across
/// all signal-related screens and widgets.

// =============================================================================
// Age-Based Colors
// =============================================================================

/// Get age-based color for a signal based on creation time.
///
/// Returns:
/// - Green: < 5 minutes old
/// - Amber: < 30 minutes old
/// - Orange: < 2 hours old
/// - Red: > 2 hours old
Color getSignalAgeColor(DateTime createdAt) {
  final age = DateTime.now().difference(createdAt);
  if (age.inMinutes < 5) {
    return AppTheme.successGreen;
  } else if (age.inMinutes < 30) {
    return AppTheme.warningYellow;
  } else if (age.inHours < 2) {
    return AccentColors.orange;
  } else {
    return AppTheme.errorRed;
  }
}

/// Get color for hop count indicator.
///
/// Returns:
/// - Green: 0 hops (local)
/// - Amber: 1-2 hops (nearby)
/// - Orange: 3+ hops (distant)
Color getHopCountColor(int? hopCount) {
  if (hopCount == null) return SemanticColors.disabled;
  if (hopCount == 0) return AppTheme.successGreen;
  if (hopCount <= 2) return AppTheme.warningYellow;
  return AccentColors.orange;
}

// =============================================================================
// Time Formatting
// =============================================================================

/// Format relative time (e.g., "5m ago", "2h ago").
///
/// [compact] - If true, omits "ago" suffix (e.g., "5m" instead of "5m ago")
String formatTimeAgo(
  DateTime time,
  AppLocalizations l10n, {
  bool compact = false,
}) {
  final diff = DateTime.now().difference(time);

  if (diff.inMinutes < 1) {
    return compact ? l10n.signalTimeNowCompact : l10n.signalTimeJustNow;
  } else if (diff.inMinutes < 60) {
    return l10n.signalTimeMinutesAgo(diff.inMinutes);
  } else if (diff.inHours < 24) {
    return l10n.signalTimeHoursAgo(diff.inHours);
  } else if (diff.inDays < 7) {
    return l10n.signalTimeDaysAgo(diff.inDays);
  } else {
    return l10n.signalTimeWeeksAgo((diff.inDays / 7).floor());
  }
}

/// Format time as "Active Xm" style for signal cards.
String formatActiveTime(DateTime time, AppLocalizations l10n) {
  final diff = DateTime.now().difference(time);

  if (diff.inMinutes < 1) return l10n.signalActiveNow;
  if (diff.inMinutes < 60) return l10n.signalActiveMinutes(diff.inMinutes);
  if (diff.inHours < 24) return l10n.signalActiveHours(diff.inHours);
  return l10n.signalActiveDays(diff.inDays);
}

// =============================================================================
// TTL (Time-To-Live) Formatting
// =============================================================================

/// Format TTL remaining (e.g., "5m left" or "5m" for compact).
///
/// [compact] - If true, omits "left" suffix
String formatTtlRemaining(
  DateTime? expiresAt,
  AppLocalizations l10n, {
  bool compact = false,
}) {
  if (expiresAt == null) return '';
  final remaining = expiresAt.difference(DateTime.now());
  if (remaining.isNegative) return l10n.signalTtlExpired;

  if (compact) {
    if (remaining.inSeconds < 60) return '${remaining.inSeconds}s';
    if (remaining.inMinutes < 60) return '${remaining.inMinutes}m';
    if (remaining.inHours < 24) return '${remaining.inHours}h';
    return '${remaining.inDays}d';
  }
  if (remaining.inSeconds < 60) {
    return l10n.signalTtlSecondsLeft(remaining.inSeconds);
  }
  if (remaining.inMinutes < 60) {
    return l10n.signalTtlMinutesLeft(remaining.inMinutes);
  }
  if (remaining.inHours < 24) {
    return l10n.signalTtlHoursLeft(remaining.inHours);
  }
  return l10n.signalTtlDaysLeft(remaining.inDays);
}

/// Get TTL color based on urgency.
///
/// Returns:
/// - Red: expired or < 30 minutes remaining
/// - Orange: < 2 hours remaining
/// - Grey: more time remaining or no TTL
Color getTtlColor(DateTime? expiresAt) {
  if (expiresAt == null) return Colors.white38;
  final remaining = expiresAt.difference(DateTime.now());
  if (remaining.isNegative) return AppTheme.errorRed;
  if (remaining.inMinutes < 30) return AppTheme.errorRed;
  if (remaining.inHours < 2) return AccentColors.orange;
  return Colors.white38;
}

/// Check if a signal has expired.
bool isSignalExpired(DateTime? expiresAt) {
  if (expiresAt == null) return false;
  return DateTime.now().isAfter(expiresAt);
}

/// Format a TTL countdown string for signal cards.
/// Uses seconds when remaining < 60s, minutes + seconds when < 10m,
/// and returns "Faded" at or below 0.
String formatSignalTtlCountdown(Duration? remaining, AppLocalizations l10n) {
  if (remaining == null) return '';
  if (remaining.inSeconds <= 0) return l10n.signalFaded;
  if (remaining.inSeconds < 60) {
    return l10n.signalFadesInSeconds(remaining.inSeconds);
  }
  if (remaining.inMinutes < 10) {
    final mins = remaining.inMinutes;
    final secs = remaining.inSeconds % 60;
    return l10n.signalFadesInMinutesSeconds(mins, secs);
  }
  if (remaining.inMinutes < 60) {
    return l10n.signalFadesInMinutes(remaining.inMinutes);
  }
  if (remaining.inHours < 24) return l10n.signalFadesInHours(remaining.inHours);
  return l10n.signalFadesInDays(remaining.inDays);
}
