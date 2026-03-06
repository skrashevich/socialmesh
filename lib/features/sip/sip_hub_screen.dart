// SPDX-License-Identifier: GPL-3.0-or-later

// SIP Hub Screen — Socialmesh peer discovery and ephemeral DM hub.
//
// Design patterns used (matching the rest of the app):
// - GlassScaffold with slivers and SectionHeaderDelegates
// - BouncyTap card containers (like Channels, Signals)
// - Card styling: context.card + border + radius12 (like _FlightTile)
// - SigilAvatar with SigilEvolution (like NodeDex)
// - Timestamps on conversation tiles (like Channels)
// - AppBarOverflowMenu for secondary actions
// - Debug counters behind overflow menu, not inline

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/l10n_extension.dart';
import '../../core/logging.dart';
import '../../core/theme.dart';
import '../../core/widgets/animations.dart';
import '../../core/widgets/app_bar_overflow_menu.dart';
import '../../core/widgets/glass_scaffold.dart';
import '../../core/widgets/section_header.dart';
import '../../features/nodedex/models/nodedex_entry.dart';
import '../../features/nodedex/models/sigil_evolution.dart';
import '../../features/nodedex/providers/nodedex_providers.dart';
import '../../features/nodedex/services/patina_score.dart';
import '../../features/nodedex/services/trait_engine.dart';
import '../../features/nodedex/widgets/sigil_painter.dart';
import '../../features/nodes/node_display_name_resolver.dart';
import '../../models/mesh_models.dart';
import '../../providers/app_providers.dart';
import '../../providers/sip_providers.dart';
import '../../services/haptic_service.dart';
import '../../services/protocol/sip/sip_discovery.dart';
import '../../services/protocol/sip/sip_dm.dart';
import '../../services/protocol/sip/sip_handshake.dart';
import 'sip_dm_screen.dart';
import 'sip_peer_detail_sheet.dart';

/// SIP Hub — discover nearby Socialmesh peers, handshake, and chat.
///
/// Entry point for all SIP UI. Gated behind SIP_ENABLED feature flag
/// at the drawer level — this screen assumes SIP is enabled.
class SipHubScreen extends ConsumerStatefulWidget {
  const SipHubScreen({super.key});

  @override
  ConsumerState<SipHubScreen> createState() => _SipHubScreenState();
}

class _SipHubScreenState extends ConsumerState<SipHubScreen> {
  bool _scanning = false;

  void _onScan() {
    final discovery = ref.read(sipDiscoveryProvider);
    AppLogging.sip('SIP_HUB: scan tapped, discovery=${discovery != null}');
    if (discovery == null) return;

    ref.read(hapticServiceProvider).trigger(HapticType.light);

    final outbound = discovery.buildRollcallReq();
    if (outbound != null) {
      final protocol = ref.read(protocolServiceProvider);
      protocol.sendSipPacket(outbound.encoded);
      AppLogging.sip(
        'SIP_HUB: ROLLCALL_REQ dispatched ${outbound.encoded.length}B',
      );
      setState(() => _scanning = true);
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) setState(() => _scanning = false);
      });
    }
  }

  void _showCounters() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: context.card,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.radius16),
        ),
      ),
      builder: (ctx) => const _SipCountersSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final sipEnabled = ref.watch(sipEnabledProvider);
    final peers = ref.watch(sipDiscoveredPeersProvider);
    final sessions = ref.watch(sipActiveSessionsProvider);
    final peerCount = ref.watch(sipPeerCountProvider);

    AppLogging.sip(
      'SIP_HUB: build — enabled=$sipEnabled, peers=$peerCount, '
      'sessions=${sessions.length}',
    );

    final hasPeers = peers.isNotEmpty;
    final hasSessions = sessions.isNotEmpty;
    final isEmpty = !hasPeers && !hasSessions;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: GlassScaffold(
        title: l10n.sipHubTitle,
        actions: [
          // Scan button
          IconButton(
            icon: _scanning
                ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: context.textSecondary,
                    ),
                  )
                : const Icon(Icons.radar, size: 22),
            tooltip: l10n.sipDiscoveryScanButton,
            onPressed: _scanning ? null : _onScan,
          ),
          // Overflow menu
          AppBarOverflowMenu<String>(
            onSelected: (value) {
              if (value == 'counters') {
                _showCounters(); // lint-allow: hardcoded-string
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'counters', // lint-allow: hardcoded-string
                child: ListTile(
                  leading: const Icon(Icons.analytics_outlined),
                  title: Text(l10n.sipCountersTitle),
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
        ],
        slivers: isEmpty
            ? _buildEmptySlivers(context)
            : _buildContentSlivers(context, peers, sessions),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Empty state — icon + headline + description + scan button
  // ---------------------------------------------------------------------------

  List<Widget> _buildEmptySlivers(BuildContext context) {
    final l10n = context.l10n;

    return [
      SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacing32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.wifi_tethering,
                  size: 56,
                  color: context.textTertiary.withValues(alpha: 0.4),
                ),
                const SizedBox(height: AppTheme.spacing16),
                Text(
                  l10n.sipHubEmptyTitle,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: context.textSecondary,
                  ),
                ),
                const SizedBox(height: AppTheme.spacing8),
                Text(
                  l10n.sipHubEmptyDescription,
                  style: TextStyle(fontSize: 13, color: context.textTertiary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.spacing24),
                FilledButton.icon(
                  onPressed: _scanning ? null : _onScan,
                  icon: const Icon(Icons.radar, size: 18),
                  label: Text(l10n.sipDiscoveryScanButton),
                ),
              ],
            ),
          ),
        ),
      ),
    ];
  }

  // ---------------------------------------------------------------------------
  // Content slivers: conversations + peers (with horizontal padding)
  // ---------------------------------------------------------------------------

  List<Widget> _buildContentSlivers(
    BuildContext context,
    List<SipPeerCapability> peers,
    List<SipDmSession> sessions,
  ) {
    return [
      const SliverToBoxAdapter(child: SizedBox(height: AppTheme.spacing8)),

      // Active conversations (shown first — most important)
      if (sessions.isNotEmpty) ...[
        SliverPersistentHeader(
          pinned: true,
          delegate: SectionHeaderDelegate(
            title: context.l10n.sipHubSectionConversations,
            count: sessions.length,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _ConversationTile(session: sessions[index]),
              childCount: sessions.length,
            ),
          ),
        ),
      ],

      // Discovered peers
      if (peers.isNotEmpty) ...[
        SliverPersistentHeader(
          pinned: true,
          delegate: SectionHeaderDelegate(
            title: context.l10n.sipHubSectionPeers,
            count: peers.length,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _PeerTile(peer: peers[index]),
              childCount: peers.length,
            ),
          ),
        ),
      ],

      // Bottom safe area
      SliverToBoxAdapter(
        child: SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
      ),
    ];
  }
}

// =============================================================================
// Peer tile — card container + BouncyTap (matches Channels pattern)
// =============================================================================

class _PeerTile extends ConsumerWidget {
  final SipPeerCapability peer;

  const _PeerTile({required this.peer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entry = ref.watch(nodeDexEntryProvider(peer.nodeId));
    final nodes = ref.watch(nodesProvider);
    final node = nodes[peer.nodeId];
    final hsState = ref.watch(sipHandshakeStateProvider(peer.nodeId));
    final patinaResult = ref.watch(nodeDexPatinaProvider(peer.nodeId));
    final traitResult = ref.watch(nodeDexTraitProvider(peer.nodeId));

    final displayName = _resolveDisplayName(entry, node, peer.nodeId);
    final hexId =
        '!${peer.nodeId.toRadixString(16).toUpperCase().padLeft(4, '0')}';

    return BouncyTap(
      onTap: () {
        ref.read(hapticServiceProvider).trigger(HapticType.selection);
        SipPeerDetailSheet.show(context, peer);
      },
      onLongPress: () {
        ref.read(hapticServiceProvider).trigger(HapticType.medium);
        SipPeerDetailSheet.show(context, peer);
      },
      scaleFactor: 0.98,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
        decoration: BoxDecoration(
          color: context.card,
          borderRadius: BorderRadius.circular(AppTheme.radius12),
          border: Border.all(color: context.border),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacing14),
          child: Row(
            children: [
              // Sigil avatar with evolution
              _buildAvatar(context, entry, patinaResult, traitResult),
              const SizedBox(width: AppTheme.spacing14),

              // Name, hex ID, and status badges
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name row
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            displayName,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: context.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: AppTheme.spacing6),
                        Text(
                          hexId,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: context.textTertiary,
                            fontFamily: AppTheme.fontFamily,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacing6),

                    // Status row: handshake state + last seen
                    Row(
                      children: [
                        _HandshakeChip(state: hsState),
                        const SizedBox(width: AppTheme.spacing8),
                        _LastSeenChip(lastSeenMs: peer.lastSeenMs),
                      ],
                    ),
                  ],
                ),
              ),

              // Chevron
              const SizedBox(width: AppTheme.spacing4),
              Icon(
                Icons.chevron_right,
                size: 20,
                color: context.textTertiary.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(
    BuildContext context,
    NodeDexEntry? entry,
    PatinaResult patinaResult,
    TraitResult traitResult,
  ) {
    if (entry?.sigil != null) {
      return SigilAvatar(
        sigil: entry!.sigil,
        nodeNum: peer.nodeId,
        size: 48,
        evolution: SigilEvolution.fromPatina(
          patinaResult.score,
          trait: traitResult.primary,
        ),
      );
    }

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: context.accentColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      child: Icon(
        Icons.sensors,
        size: 24,
        color: context.accentColor.withValues(alpha: 0.7),
      ),
    );
  }

  static String _resolveDisplayName(
    NodeDexEntry? entry,
    MeshNode? node,
    int nodeId,
  ) {
    return entry?.localNickname ??
        entry?.sipDisplayName ??
        node?.displayName ??
        entry?.lastKnownName ??
        NodeDisplayNameResolver.defaultName(nodeId);
  }
}

// =============================================================================
// Handshake chip — styled container badge (like channel encryption badge)
// =============================================================================

class _HandshakeChip extends StatelessWidget {
  final SipHandshakeState state;

  const _HandshakeChip({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final (label, color, icon) = switch (state) {
      SipHandshakeState.idle => (
        l10n.sipHandshakeAction,
        context.textTertiary,
        Icons.handshake_outlined,
      ),
      SipHandshakeState.accepted => (
        l10n.sipHubReady,
        AccentColors.green,
        Icons.check_circle_outline,
      ),
      SipHandshakeState.failed || SipHandshakeState.timedOut => (
        l10n.sipHandshakeFailed,
        AccentColors.red,
        Icons.error_outline,
      ),
      _ => (l10n.sipHubHandshaking, AccentColors.yellow, Icons.hourglass_top),
    };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing6,
        vertical: AppTheme.spacing2,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppTheme.radius6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: AppTheme.spacing4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Last seen chip — styled like handshake chip
// =============================================================================

class _LastSeenChip extends StatelessWidget {
  final int lastSeenMs;

  const _LastSeenChip({required this.lastSeenMs});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    final diffMs = nowMs - lastSeenMs;
    final diffMinutes = diffMs ~/ 60000;

    final String timeText;
    if (diffMinutes < 1) {
      timeText = l10n.sipPeerDetailJustNow;
    } else if (diffMinutes < 60) {
      timeText = l10n.sipPeerDetailMinutesAgo(diffMinutes);
    } else {
      timeText = l10n.sipPeerDetailHoursAgo(diffMinutes ~/ 60);
    }

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
          Icon(Icons.schedule, size: 11, color: context.textTertiary),
          const SizedBox(width: AppTheme.spacing4),
          Text(
            timeText,
            style: TextStyle(fontSize: 11, color: context.textTertiary),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Conversation tile — card container with last message + timestamp
// =============================================================================

class _ConversationTile extends ConsumerWidget {
  final SipDmSession session;

  const _ConversationTile({required this.session});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final entry = ref.watch(nodeDexEntryProvider(session.peerNodeId));
    final nodes = ref.watch(nodesProvider);
    final node = nodes[session.peerNodeId];
    final dm = ref.watch(sipDmManagerProvider);
    final patinaResult = ref.watch(nodeDexPatinaProvider(session.peerNodeId));
    final traitResult = ref.watch(nodeDexTraitProvider(session.peerNodeId));
    ref.watch(sipDmEpochProvider); // Rebuild on new messages

    final displayName = _resolveDisplayName(entry, node, session.peerNodeId);
    final history = dm?.getHistory(session.sessionTag) ?? [];
    final lastMessage = history.isNotEmpty ? history.last : null;

    return BouncyTap(
      onTap: () {
        AppLogging.sip('SIP_HUB: Opening DM session ${session.sessionTag}');
        ref.read(hapticServiceProvider).trigger(HapticType.light);
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => SipDmScreen(sessionTag: session.sessionTag),
          ),
        );
      },
      onLongPress: () {
        ref.read(hapticServiceProvider).trigger(HapticType.medium);
        // Long press also opens the DM
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => SipDmScreen(sessionTag: session.sessionTag),
          ),
        );
      },
      scaleFactor: 0.98,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
        decoration: BoxDecoration(
          color: context.card,
          borderRadius: BorderRadius.circular(AppTheme.radius12),
          border: Border.all(color: context.border),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacing14),
          child: Row(
            children: [
              // Avatar with evolution
              _buildAvatar(context, entry, patinaResult, traitResult),
              const SizedBox(width: AppTheme.spacing14),

              // Name + last message + badges
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name row with timestamp
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            displayName,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: context.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: AppTheme.spacing8),
                        // Timestamp of last message
                        if (lastMessage != null)
                          Text(
                            _formatTimestamp(lastMessage.timestampMs),
                            style: TextStyle(
                              fontSize: 11,
                              color: context.textTertiary,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacing4),

                    // Last message preview or empty hint
                    Text(
                      lastMessage != null
                          ? lastMessage.text
                          : l10n.sipHubNoMessages,
                      style: TextStyle(
                        fontSize: 13,
                        color: lastMessage != null
                            ? context.textSecondary
                            : context.textTertiary,
                        fontStyle: lastMessage != null
                            ? FontStyle.normal
                            : FontStyle.italic,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppTheme.spacing6),

                    // Session badges row
                    Row(
                      children: [
                        _buildSessionBadge(context, l10n),
                        if (session.isPinned) ...[
                          const SizedBox(width: AppTheme.spacing8),
                          _buildPinnedBadge(context, l10n),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              // Chevron
              const SizedBox(width: AppTheme.spacing4),
              Icon(
                Icons.chevron_right,
                size: 20,
                color: context.textTertiary.withValues(alpha: 0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(
    BuildContext context,
    NodeDexEntry? entry,
    PatinaResult patinaResult,
    TraitResult traitResult,
  ) {
    if (entry?.sigil != null) {
      return SigilAvatar(
        sigil: entry!.sigil,
        nodeNum: session.peerNodeId,
        size: 48,
        evolution: SigilEvolution.fromPatina(
          patinaResult.score,
          trait: traitResult.primary,
        ),
      );
    }

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: context.accentColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      child: Icon(
        Icons.chat_bubble_outline,
        size: 22,
        color: context.accentColor.withValues(alpha: 0.7),
      ),
    );
  }

  Widget _buildSessionBadge(BuildContext context, dynamic l10n) {
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    final expiresAtMs = session.createdAtMs + (session.ttlS * 1000);
    final remainingS = ((expiresAtMs - nowMs) / 1000).clamp(0, double.infinity);
    final timeText = remainingS > 3600
        ? '${(remainingS / 3600).floor()}h'
        : remainingS > 60
        ? '${(remainingS / 60).floor()}m'
        : '${remainingS.floor()}s';

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
            timeText,
            style: TextStyle(fontSize: 10, color: context.textTertiary),
          ),
        ],
      ),
    );
  }

  Widget _buildPinnedBadge(BuildContext context, dynamic l10n) {
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
          Icon(Icons.push_pin, size: 11, color: context.accentColor),
          const SizedBox(width: AppTheme.spacing4),
          Text(
            l10n.sipHubSessionPinned,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: context.accentColor,
            ),
          ),
        ],
      ),
    );
  }

  static String _formatTimestamp(int ms) {
    final dt = DateTime.fromMillisecondsSinceEpoch(ms);
    final now = DateTime.now();
    final diff = now.difference(dt);

    if (diff.inMinutes < 1) {
      return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    }
    if (diff.inHours < 24 && dt.day == now.day) {
      return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    }
    return '${dt.day}/${dt.month}'; // lint-allow: hardcoded-string
  }

  static String _resolveDisplayName(
    NodeDexEntry? entry,
    MeshNode? node,
    int nodeId,
  ) {
    return entry?.localNickname ??
        entry?.sipDisplayName ??
        node?.displayName ??
        entry?.lastKnownName ??
        NodeDisplayNameResolver.defaultName(nodeId);
  }
}

// =============================================================================
// Debug counters — shown in a modal bottom sheet (not inline)
// =============================================================================

class _SipCountersSheet extends ConsumerWidget {
  const _SipCountersSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final counters = ref.watch(sipCountersProvider);
    final entries = counters.toDisplayEntries();
    final nonZero = entries.where((e) => e.value > 0).toList();

    return Padding(
      padding: EdgeInsets.only(
        left: AppTheme.spacing16,
        right: AppTheme.spacing16,
        top: AppTheme.spacing16,
        bottom: MediaQuery.of(context).padding.bottom + AppTheme.spacing16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(Icons.analytics_outlined, color: context.accentColor),
              const SizedBox(width: AppTheme.spacing8),
              Text(
                l10n.sipCountersTitle,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: context.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),

          // Counter rows
          if (nonZero.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacing24),
                child: Text(
                  l10n.sipHubNoMessages,
                  style: TextStyle(
                    fontSize: 14,
                    color: context.textTertiary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            )
          else
            ...nonZero.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: AppTheme.spacing8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        e.label,
                        style: TextStyle(
                          fontSize: 13,
                          color: context.textSecondary,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacing8,
                        vertical: AppTheme.spacing2,
                      ),
                      decoration: BoxDecoration(
                        color: context.accentColor.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(AppTheme.radius6),
                      ),
                      child: Text(
                        '${e.value}', // lint-allow: hardcoded-string
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: context.accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
