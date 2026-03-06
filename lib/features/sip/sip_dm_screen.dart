// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/l10n_extension.dart';
import '../../core/safety/lifecycle_mixin.dart';
import '../../core/theme.dart';
import '../../core/widgets/app_bar_overflow_menu.dart';
import '../../core/widgets/glass_scaffold.dart';
import '../../providers/sip_providers.dart';
import '../../services/haptic_service.dart';
import '../../services/protocol/sip/sip_dm.dart';
import '../../utils/snackbar.dart';

/// Ephemeral DM thread screen for a single SIP session.
///
/// Displays the message history with an expiry countdown and
/// input field for composing new messages. Feature-flagged via
/// [sipEnabledProvider].
class SipDmScreen extends ConsumerStatefulWidget {
  /// Session tag of the DM session to display.
  final int sessionTag;

  const SipDmScreen({super.key, required this.sessionTag});

  @override
  ConsumerState<SipDmScreen> createState() => _SipDmScreenState();
}

class _SipDmScreenState extends ConsumerState<SipDmScreen>
    with LifecycleSafeMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final dm = ref.read(sipDmManagerProvider);
    if (dm == null) return;

    final haptics = ref.read(hapticServiceProvider);

    final result = dm.buildDmMessage(sessionTag: widget.sessionTag, text: text);

    if (result.isOk) {
      haptics.trigger(HapticType.light);
      _messageController.clear();
      setState(() {}); // Refresh message list.
      _scrollToBottom();
    } else {
      haptics.trigger(HapticType.error);
      _showSendError(result.error);
    }
  }

  void _showSendError(SipDmSendError? error) {
    if (!mounted) return;
    final l10n = context.l10n;
    final message = switch (error) {
      SipDmSendError.budgetExhausted => l10n.sipDmBudgetExhausted,
      SipDmSendError.sessionClosed => l10n.sipDmSessionClosed,
      SipDmSendError.sessionNotFound => l10n.sipDmSessionClosed,
      _ => l10n.sipDmSessionClosed,
    };

    showErrorSnackBar(context, message);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _onPin() {
    final dm = ref.read(sipDmManagerProvider);
    if (dm == null) return;

    final session = dm.getSession(widget.sessionTag);
    if (session == null) return;

    final haptics = ref.read(hapticServiceProvider);

    if (session.isPinned) {
      dm.unpinSession(widget.sessionTag);
    } else {
      dm.pinSession(widget.sessionTag);
    }
    haptics.trigger(HapticType.light);
    setState(() {});
  }

  void _onClose() {
    final dm = ref.read(sipDmManagerProvider);
    if (dm == null) return;

    ref.read(hapticServiceProvider).trigger(HapticType.medium);
    dm.closeSession(widget.sessionTag);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dm = ref.watch(sipDmManagerProvider);
    final session = dm?.getSession(widget.sessionTag);

    return GestureDetector(
      onTap: _dismissKeyboard,
      child: GlassScaffold.body(
        title: l10n.sipDmTitle,
        actions: [
          if (session != null)
            AppBarOverflowMenu<String>(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'pin', // lint-allow: hardcoded-string
                  child: ListTile(
                    leading: Icon(
                      session.isPinned
                          ? Icons.push_pin
                          : Icons.push_pin_outlined,
                    ),
                    title: Text(
                      session.isPinned
                          ? l10n.sipDmUnpinAction
                          : l10n.sipDmPinAction,
                    ),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                PopupMenuItem(
                  value: 'close', // lint-allow: hardcoded-string
                  child: ListTile(
                    leading: const Icon(Icons.close),
                    title: Text(l10n.sipDmCloseAction),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
              onSelected: (value) {
                if (value == 'pin') {
                  _onPin(); // lint-allow: hardcoded-string
                }
                if (value == 'close') {
                  _onClose(); // lint-allow: hardcoded-string
                }
              },
            ),
        ],
        hasScrollBody: true,
        body: Column(
          children: [
            // Session info bar
            if (session != null) _buildSessionInfo(context, session),

            // Messages
            Expanded(child: _buildMessageList(context, dm, session)),

            // Input
            _buildInputBar(context, session),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionInfo(BuildContext context, SipDmSession session) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final peerHex = '0x${session.peerNodeId.toRadixString(16).toUpperCase()}';
    final expiryText = session.isPinned
        ? l10n.sipDmPinned
        : l10n.sipDmExpiry(_formatTtl(session));

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing16,
        vertical: AppTheme.spacing8,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      ),
      child: Row(
        children: [
          Icon(Icons.sensors, size: 16, color: theme.colorScheme.primary),
          const SizedBox(width: AppTheme.spacing8),
          Expanded(child: Text(peerHex, style: theme.textTheme.bodySmall)),
          Text(
            expiryText,
            style: theme.textTheme.bodySmall?.copyWith(
              color: session.isPinned
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList(
    BuildContext context,
    SipDmManager? dm,
    SipDmSession? session,
  ) {
    if (session == null || dm == null) {
      return _buildEmptyState(context);
    }

    final history = dm.getHistory(widget.sessionTag) ?? [];

    if (history.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(AppTheme.spacing16),
      itemCount: history.length,
      itemBuilder: (context, index) {
        final entry = history[index];
        return _MessageBubble(entry: entry);
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.chat_bubble_outline,
            size: 48,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
          ),
          const SizedBox(height: AppTheme.spacing12),
          Text(l10n.sipDmEmptyState, style: theme.textTheme.titleMedium),
          const SizedBox(height: AppTheme.spacing4),
          Text(
            l10n.sipDmEmptyDescription,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBar(BuildContext context, SipDmSession? session) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final enabled =
        session != null && session.status == SipDmSessionStatus.active;

    return Container(
      padding: EdgeInsets.only(
        left: AppTheme.spacing16,
        right: AppTheme.spacing8,
        top: AppTheme.spacing8,
        bottom: MediaQuery.of(context).padding.bottom + AppTheme.spacing8,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              enabled: enabled,
              maxLength: 180,
              maxLines: null,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _sendMessage(),
              decoration: InputDecoration(
                hintText: l10n.sipDmInputHint,
                counterText: '', // Hide character counter
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing12,
                  vertical: AppTheme.spacing8,
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: enabled ? _sendMessage : null,
            icon: const Icon(Icons.send),
            tooltip: l10n.sipDmSendButton,
          ),
        ],
      ),
    );
  }

  String _formatTtl(SipDmSession session) {
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    final expiresAtMs = session.createdAtMs + (session.ttlS * 1000);
    final remainingS = ((expiresAtMs - nowMs) / 1000).clamp(0, double.infinity);

    if (remainingS > 3600) {
      return '${(remainingS / 3600).floor()}h';
    } else if (remainingS > 60) {
      return '${(remainingS / 60).floor()}m';
    } else {
      return '${remainingS.floor()}s';
    }
  }
}

class _MessageBubble extends StatelessWidget {
  final SipDmHistoryEntry entry;

  const _MessageBubble({required this.entry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOutbound = entry.direction == SipDmDirection.outbound;

    return Align(
      alignment: isOutbound ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing12,
          vertical: AppTheme.spacing8,
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isOutbound
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(AppTheme.radius12),
        ),
        child: Column(
          crossAxisAlignment: isOutbound
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              entry.text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isOutbound
                    ? theme.colorScheme.onPrimaryContainer
                    : theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: AppTheme.spacing2),
            Text(
              _formatTime(entry.timestampMs),
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 10,
                color:
                    (isOutbound
                            ? theme.colorScheme.onPrimaryContainer
                            : theme.colorScheme.onSurface)
                        .withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(int ms) {
    final dt = DateTime.fromMillisecondsSinceEpoch(ms);
    return '${dt.hour.toString().padLeft(2, '0')}:'
        '${dt.minute.toString().padLeft(2, '0')}';
  }
}
