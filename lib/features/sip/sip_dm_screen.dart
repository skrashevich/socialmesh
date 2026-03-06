// SPDX-License-Identifier: GPL-3.0-or-later

// SIP DM Screen — ephemeral chat thread for a single SIP session.
//
// Design patterns used (matching the rest of the app):
// - GlassScaffold with resolved peer name in title
// - Card-styled session info bar with sigil + evolution
// - Message bubbles with semantic colors and rounded corners
// - AppBarOverflowMenu for pin/close actions
// - BouncyTap on interactive elements
// - Consistent badge styling (container + color + radius6)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/l10n_extension.dart';
import '../../core/safety/lifecycle_mixin.dart';
import '../../core/theme.dart';
import '../../core/widgets/app_bar_overflow_menu.dart';
import '../../core/widgets/glass_scaffold.dart';
import '../../features/nodedex/models/nodedex_entry.dart';
import '../../features/nodedex/models/sigil_evolution.dart';
import '../../features/nodedex/providers/nodedex_providers.dart';
import '../../features/nodedex/services/patina_score.dart';
import '../../features/nodedex/services/trait_engine.dart';
import '../../features/nodedex/widgets/sigil_painter.dart';
import '../../features/nodes/node_display_name_resolver.dart';
import '../../providers/app_providers.dart';
import '../../providers/sip_providers.dart';
import '../../services/haptic_service.dart';
import '../../services/protocol/sip/sip_codec.dart';
import '../../services/protocol/sip/sip_dm.dart';
import '../../utils/snackbar.dart';

/// Ephemeral DM thread screen for a single SIP session.
///
/// Displays the message history with the peer's sigil avatar and
/// resolved name, expiry countdown, and input field for composing
/// new messages.
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
      final encoded = SipCodec.encode(result.frame!);
      if (encoded == null) {
        haptics.trigger(HapticType.error);
        _showSendError(SipDmSendError.textTooLong);
        return;
      }
      final protocol = ref.read(protocolServiceProvider);
      protocol.sendSipPacket(encoded);
      ref
          .read(sipCountersProvider)
          .recordTx(result.frame!.msgType, encoded.length);
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

  // Resolve the peer's display name.
  String _resolvePeerName(SipDmSession session) {
    final entry = ref.read(nodeDexEntryProvider(session.peerNodeId));
    final nodes = ref.read(nodesProvider);
    final node = nodes[session.peerNodeId];

    return entry?.localNickname ??
        entry?.sipDisplayName ??
        node?.displayName ??
        entry?.lastKnownName ??
        NodeDisplayNameResolver.defaultName(session.peerNodeId);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final dm = ref.watch(sipDmManagerProvider);
    final session = dm?.getSession(widget.sessionTag);
    ref.watch(sipDmEpochProvider); // Rebuild on new messages

    final title = session != null ? _resolvePeerName(session) : l10n.sipDmTitle;

    return GestureDetector(
      onTap: _dismissKeyboard,
      child: GlassScaffold.body(
        title: title,
        hasScrollBody: true,
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
        body: Column(
          children: [
            // Session info bar (card-styled)
            if (session != null) _SessionInfoBar(session: session),

            // Messages
            Expanded(child: _buildMessageList(context, dm, session)),

            // Input
            _buildInputBar(context, session),
          ],
        ),
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

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacing32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 48,
              color: context.textTertiary.withValues(alpha: 0.4),
            ),
            const SizedBox(height: AppTheme.spacing12),
            Text(
              l10n.sipDmEmptyState,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: context.textSecondary,
              ),
            ),
            const SizedBox(height: AppTheme.spacing4),
            Text(
              l10n.sipDmEmptyDescription,
              style: TextStyle(fontSize: 13, color: context.textTertiary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputBar(BuildContext context, SipDmSession? session) {
    final l10n = context.l10n;
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
        color: context.card.withValues(alpha: 0.5),
        border: Border(
          top: BorderSide(color: context.textTertiary.withValues(alpha: 0.1)),
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
                counterText:
                    '', // Hide character counter // lint-allow: hardcoded-string
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
}

// =============================================================================
// Session info bar — card-styled with sigil + evolution + badges
// =============================================================================

class _SessionInfoBar extends ConsumerWidget {
  final SipDmSession session;

  const _SessionInfoBar({required this.session});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final entry = ref.watch(nodeDexEntryProvider(session.peerNodeId));
    final patinaResult = ref.watch(nodeDexPatinaProvider(session.peerNodeId));
    final traitResult = ref.watch(nodeDexTraitProvider(session.peerNodeId));
    final hexId =
        '!${session.peerNodeId.toRadixString(16).toUpperCase().padLeft(4, '0')}';

    return Container(
      margin: const EdgeInsets.all(AppTheme.spacing12),
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: context.border),
      ),
      child: Row(
        children: [
          // Sigil avatar (small) with evolution
          _buildSmallAvatar(context, entry, patinaResult, traitResult),
          const SizedBox(width: AppTheme.spacing10),

          // Hex ID
          Expanded(
            child: Text(
              hexId,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: context.textTertiary,
                fontFamily: AppTheme.fontFamily,
              ),
            ),
          ),

          // Expiry or pinned badge
          _buildStatusBadge(context, l10n),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, dynamic l10n) {
    if (session.isPinned) {
      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing6,
          vertical: AppTheme.spacing2,
        ),
        decoration: BoxDecoration(
          color: context.accentColor.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(AppTheme.radius6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.push_pin, size: 12, color: context.accentColor),
            const SizedBox(width: AppTheme.spacing4),
            Text(
              l10n.sipDmPinned,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: context.accentColor,
              ),
            ),
          ],
        ),
      );
    }

    final expiryText = l10n.sipDmExpiry(_formatTtl(session));
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing6,
        vertical: AppTheme.spacing2,
      ),
      decoration: BoxDecoration(
        color: context.textTertiary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppTheme.radius6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.timer_outlined, size: 11, color: context.textTertiary),
          const SizedBox(width: AppTheme.spacing4),
          Text(
            expiryText,
            style: TextStyle(fontSize: 11, color: context.textTertiary),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallAvatar(
    BuildContext context,
    NodeDexEntry? entry,
    PatinaResult patinaResult,
    TraitResult traitResult,
  ) {
    if (entry?.sigil != null) {
      return SigilAvatar(
        sigil: entry!.sigil,
        nodeNum: session.peerNodeId,
        size: 32,
        evolution: SigilEvolution.fromPatina(
          patinaResult.score,
          trait: traitResult.primary,
        ),
      );
    }

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: context.accentColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radius8),
      ),
      child: Icon(
        Icons.sensors,
        size: 16,
        color: context.accentColor.withValues(alpha: 0.7),
      ),
    );
  }

  static String _formatTtl(SipDmSession session) {
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

// =============================================================================
// Message bubble — semantic colors with proper card styling
// =============================================================================

class _MessageBubble extends StatelessWidget {
  final SipDmHistoryEntry entry;

  const _MessageBubble({required this.entry});

  @override
  Widget build(BuildContext context) {
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
              ? context.accentColor.withValues(alpha: 0.15)
              : context.card,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(AppTheme.radius12),
            topRight: const Radius.circular(AppTheme.radius12),
            bottomLeft: isOutbound
                ? const Radius.circular(AppTheme.radius12)
                : const Radius.circular(AppTheme.radius4),
            bottomRight: isOutbound
                ? const Radius.circular(AppTheme.radius4)
                : const Radius.circular(AppTheme.radius12),
          ),
          border: isOutbound
              ? null
              : Border.all(color: context.border.withValues(alpha: 0.5)),
        ),
        child: Column(
          crossAxisAlignment: isOutbound
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              entry.text,
              style: TextStyle(fontSize: 14, color: context.textPrimary),
            ),
            const SizedBox(height: AppTheme.spacing2),
            Text(
              _formatTime(entry.timestampMs),
              style: TextStyle(fontSize: 10, color: context.textTertiary),
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
