// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/theme.dart';

/// Sticky header delegate for drawer section headers.
///
/// Renders a frosted-glass header that pins to the top of the
/// [CustomScrollView] inside the navigation drawer as the user scrolls.
class DrawerStickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final ThemeData theme;

  DrawerStickyHeaderDelegate({required this.title, required this.theme});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          color: theme.scaffoldBackgroundColor.withValues(alpha: 0.8),
          padding: const EdgeInsets.only(left: 24, top: 8, bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              fontFamily: AppTheme.fontFamily,
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 32;

  @override
  double get minExtent => 32;

  @override
  bool shouldRebuild(covariant DrawerStickyHeaderDelegate oldDelegate) {
    return title != oldDelegate.title;
  }
}
