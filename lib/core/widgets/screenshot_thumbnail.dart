// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme.dart';
import 'fullscreen_gallery.dart';

/// Reusable screenshot thumbnail with shimmer loading, error state, and
/// a fullscreen expand overlay. Tapping opens [FullscreenGallery].
///
/// Used in both the admin bug reports screen and the user bug reports screen.
class ScreenshotThumbnail extends StatelessWidget {
  const ScreenshotThumbnail({
    super.key,
    required this.imageUrl,
    this.height = 200,
    this.onTapOverride,
  });

  /// The network URL of the screenshot image.
  final String imageUrl;

  /// Height of the thumbnail container. Defaults to 200.
  final double height;

  /// Optional tap override. When null, opens [FullscreenGallery].
  final VoidCallback? onTapOverride;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        if (onTapOverride != null) {
          onTapOverride!();
        } else {
          FullscreenGallery.show(context, images: [imageUrl]);
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        child: Container(
          height: height,
          width: double.infinity,
          decoration: BoxDecoration(
            color: context.background,
            border: Border.all(color: context.border.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(AppTheme.radius8),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: height,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return _ScreenshotSkeleton(borderColor: context.border);
                },
                errorBuilder: (_, _, _) => Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.broken_image_outlined,
                        size: 20,
                        color: context.textTertiary,
                      ),
                      const SizedBox(width: AppTheme.spacing8),
                      Text(
                        'Screenshot unavailable', // lint-allow: hardcoded-string
                        style: TextStyle(
                          fontSize: 13,
                          color: context.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 8,
                bottom: 8,
                child: Container(
                  padding: const EdgeInsets.all(AppTheme.spacing4),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(AppTheme.radius6),
                  ),
                  child: const Icon(
                    Icons.fullscreen_rounded,
                    color: Colors.white70,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shimmer skeleton shown while a screenshot is loading.
class _ScreenshotSkeleton extends StatefulWidget {
  const _ScreenshotSkeleton({required this.borderColor});

  final Color borderColor;

  @override
  State<_ScreenshotSkeleton> createState() => _ScreenshotSkeletonState();
}

class _ScreenshotSkeletonState extends State<_ScreenshotSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final shimmerOpacity = 0.04 + (_animation.value * 0.08);
        return Container(
          decoration: BoxDecoration(
            color: context.card,
            borderRadius: BorderRadius.circular(AppTheme.radius8),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppTheme.radius8),
                    gradient: LinearGradient(
                      begin: Alignment(-1.0 + (_animation.value * 3), -0.3),
                      end: Alignment(-0.5 + (_animation.value * 3), 0.3),
                      colors: [
                        Colors.transparent,
                        Colors.white.withValues(alpha: shimmerOpacity),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_outlined,
                      size: 32,
                      color: context.textTertiary.withValues(alpha: 0.4),
                    ),
                    const SizedBox(height: AppTheme.spacing8),
                    Text(
                      'Loading screenshot...', // lint-allow: hardcoded-string
                      style: TextStyle(
                        fontSize: 12,
                        color: context.textTertiary.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
