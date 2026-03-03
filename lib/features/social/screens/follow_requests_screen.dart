// SPDX-License-Identifier: GPL-3.0-or-later
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n_extension.dart';
import '../../../core/safety/lifecycle_mixin.dart';
import '../../../core/widgets/glass_scaffold.dart';
import '../../../core/widgets/user_avatar.dart';
import '../../../core/widgets/verified_badge.dart';
import '../../../models/social.dart';
import '../../../providers/social_providers.dart';
import '../../../utils/snackbar.dart';
import 'profile_social_screen.dart';
import 'package:socialmesh/core/theme.dart';

/// Screen showing pending follow requests for the current user to approve/decline.
class FollowRequestsScreen extends ConsumerWidget {
  const FollowRequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsAsync = ref.watch(pendingFollowRequestsProvider);

    return GlassScaffold(
      title: context.l10n.socialFollowRequestsTitle,
      slivers: [
        requestsAsync.when(
          data: (requests) {
            if (requests.isEmpty) {
              return SliverFillRemaining(child: _buildEmptyState(context));
            }

            return SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final request = requests[index];
                return _RequestTile(
                  request: request,
                  onAccept: () => _handleAccept(context, ref, request),
                  onDecline: () => _handleDecline(context, ref, request),
                  onTap: () =>
                      _navigateToProfile(context, request.request.requesterId),
                );
              }, childCount: requests.length),
            );
          },
          loading: () => const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (error, _) => SliverFillRemaining(
            child: _buildErrorState(
              context,
              error,
              () => ref.invalidate(pendingFollowRequestsProvider),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleAccept(
    BuildContext context,
    WidgetRef ref,
    FollowRequestWithProfile request,
  ) async {
    final l10n = context.l10n;
    try {
      await acceptFollowRequest(ref, request.request.requesterId);
      if (context.mounted) {
        showSuccessSnackBar(
          context,
          l10n.socialFollowRequestAccepted(
            request.profile?.displayName ?? 'user',
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        showErrorSnackBar(context, l10n.socialFollowRequestAcceptFailed);
      }
    }
  }

  Future<void> _handleDecline(
    BuildContext context,
    WidgetRef ref,
    FollowRequestWithProfile request,
  ) async {
    final l10n = context.l10n;
    try {
      await declineFollowRequest(ref, request.request.requesterId);
      if (context.mounted) {
        showInfoSnackBar(
          context,
          l10n.socialFollowRequestDeclined(
            request.profile?.displayName ?? 'user',
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        showErrorSnackBar(context, l10n.socialFollowRequestDeclineFailed);
      }
    }
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.person_add_disabled_outlined,
            size: 64,
            color: theme.colorScheme.primary.withAlpha(100),
          ),
          const SizedBox(height: AppTheme.spacing16),
          Text(
            context.l10n.socialFollowRequestsEmpty,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.textTheme.bodyLarge?.color?.withAlpha(150),
            ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          Text(
            context.l10n.socialFollowRequestsEmptyDesc,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodyMedium?.color?.withAlpha(100),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    Object error,
    VoidCallback onRetry,
  ) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.error_outline, size: 48),
          const SizedBox(height: AppTheme.spacing16),
          Text(context.l10n.socialFollowRequestsError(error.toString())),
          const SizedBox(height: AppTheme.spacing16),
          FilledButton(
            onPressed: onRetry,
            child: Text(context.l10n.socialRetry),
          ),
        ],
      ),
    );
  }

  void _navigateToProfile(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileSocialScreen(userId: userId),
      ),
    );
  }
}

class _RequestTile extends ConsumerStatefulWidget {
  const _RequestTile({
    required this.request,
    required this.onAccept,
    required this.onDecline,
    required this.onTap,
  });

  final FollowRequestWithProfile request;
  final Future<void> Function() onAccept;
  final Future<void> Function() onDecline;
  final VoidCallback onTap;

  @override
  ConsumerState<_RequestTile> createState() => _RequestTileState();
}

class _RequestTileState extends ConsumerState<_RequestTile>
    with LifecycleSafeMixin {
  bool _isAccepting = false;
  bool _isDeclining = false;

  bool get _isProcessing => _isAccepting || _isDeclining;

  Future<void> _handleAccept() async {
    if (_isProcessing) return;
    safeSetState(() => _isAccepting = true);
    try {
      await widget.onAccept();
    } finally {
      safeSetState(() => _isAccepting = false);
    }
  }

  Future<void> _handleDecline() async {
    if (_isProcessing) return;
    safeSetState(() => _isDeclining = true);
    try {
      await widget.onDecline();
    } finally {
      safeSetState(() => _isDeclining = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final profile = widget.request.profile;
    final createdAt = widget.request.request.createdAt;

    return ListTile(
      onTap: widget.onTap,
      leading: UserAvatar(
        imageUrl: profile?.avatarUrl,
        initials: (profile?.displayName ?? 'U').isNotEmpty
            ? (profile?.displayName ?? 'U')[0]
            : '?',
        size: 40,
      ),
      title: Row(
        children: [
          Flexible(
            child: Text(
              profile?.displayName ?? context.l10n.socialUnknownUser,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (profile?.isVerified == true) ...[
            const SizedBox(width: AppTheme.spacing4),
            const SimpleVerifiedBadge(size: 16),
          ],
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (profile?.callsign != null)
            Text(
              profile!.callsign!,
              style: TextStyle(color: theme.colorScheme.secondary),
            ),
          Text(
            _formatTimeAgo(context, createdAt),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withAlpha(150),
            ),
          ),
        ],
      ),
      isThreeLine: profile?.callsign != null,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 32,
            width: 80,
            child: FilledButton(
              onPressed: _isProcessing ? null : _handleAccept,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
              child: _isAccepting
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(context.l10n.socialConfirm, maxLines: 1),
            ),
          ),
          const SizedBox(width: AppTheme.spacing8),
          SizedBox(
            height: 32,
            width: 70,
            child: FilledButton(
              onPressed: _isProcessing ? null : _handleDecline,
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                backgroundColor: SemanticColors.disabled,
                foregroundColor: Colors.white,
              ),
              child: _isDeclining
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : Text(context.l10n.socialDelete, maxLines: 1),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimeAgo(BuildContext context, DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 7) {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } else if (difference.inDays > 0) {
      return context.l10n.socialTimeDaysAgo(difference.inDays);
    } else if (difference.inHours > 0) {
      return context.l10n.socialTimeHoursAgo(difference.inHours);
    } else if (difference.inMinutes > 0) {
      return context.l10n.socialTimeMinutesAgo(difference.inMinutes);
    } else {
      return context.l10n.socialTimeJustNow;
    }
  }
}
