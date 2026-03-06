// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/l10n_extension.dart';
import '../../core/logging.dart';
import '../../core/theme.dart';
import '../../core/widgets/glass_scaffold.dart';
import '../../providers/sip_providers.dart';
import '../../services/haptic_service.dart';
import 'sip_discovery_sheet.dart';
import 'sip_dm_screen.dart';

/// Minimal SIP hub listing discovered peers and active DM sessions.
///
/// Entry point for all SIP UI. Gated behind `SIP_ENABLED` feature flag
/// at the drawer level — this screen assumes SIP is enabled.
class SipHubScreen extends ConsumerStatefulWidget {
  const SipHubScreen({super.key});

  @override
  ConsumerState<SipHubScreen> createState() => _SipHubScreenState();
}

class _SipHubScreenState extends ConsumerState<SipHubScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final sipEnabled = ref.watch(sipEnabledProvider);
    final peerCount = ref.watch(sipPeerCountProvider);
    final sessions = ref.watch(sipActiveSessionsProvider);
    AppLogging.sip(
      'SIP_HUB: build — enabled=$sipEnabled, peers=$peerCount, '
      'sessions=${sessions.length}',
    );

    return GlassScaffold.body(
      title: l10n.sipBadgeLabel,
      actions: [
        IconButton(
          icon: const Icon(Icons.radar),
          tooltip: l10n.sipDiscoveryScanButton,
          onPressed: () {
            ref.read(hapticServiceProvider).trigger(HapticType.light);
            SipDiscoverySheet.show(context);
          },
        ),
      ],
      body: sessions.isEmpty && peerCount == 0
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacing32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.wifi_tethering,
                      size: 64,
                      color: theme.colorScheme.onSurface.withAlpha(77),
                    ),
                    const SizedBox(height: AppTheme.spacing16),
                    Text(
                      l10n.sipDiscoveryNoPeers,
                      style: theme.textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppTheme.spacing8),
                    Text(
                      l10n.sipDiscoveryNoPeersDescription,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withAlpha(153),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppTheme.spacing24),
                    FilledButton.icon(
                      onPressed: () {
                        ref
                            .read(hapticServiceProvider)
                            .trigger(HapticType.medium);
                        SipDiscoverySheet.show(context);
                      },
                      icon: const Icon(Icons.radar),
                      label: Text(l10n.sipDiscoveryScanButton),
                    ),
                  ],
                ),
              ),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacing16,
                vertical: AppTheme.spacing8,
              ),
              children: [
                // Peer count header
                if (peerCount > 0)
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppTheme.spacing8,
                      top: AppTheme.spacing8,
                    ),
                    child: Text(
                      l10n.sipDiscoveryPeersNearby(peerCount),
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),

                // Active DM sessions
                if (sessions.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: AppTheme.spacing16,
                      bottom: AppTheme.spacing8,
                    ),
                    child: Text(
                      l10n.sipDmTitle,
                      style: theme.textTheme.titleSmall,
                    ),
                  ),
                  ...sessions.map((session) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
                      child: ListTile(
                        leading: const Icon(Icons.chat_bubble_outline),
                        title: Text(
                          'Session ${session.sessionTag.toRadixString(16).toUpperCase()}', // lint-allow: hardcoded-string
                        ),
                        subtitle: Text(
                          'Node ${session.peerNodeId.toRadixString(16).toUpperCase()}', // lint-allow: hardcoded-string
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {
                          AppLogging.sip(
                            'SIP_HUB: Opening DM session ${session.sessionTag}',
                          );
                          ref
                              .read(hapticServiceProvider)
                              .trigger(HapticType.light);
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) =>
                                  SipDmScreen(sessionTag: session.sessionTag),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ],

                // Debug counters (collapsed by default)
                const SizedBox(height: AppTheme.spacing16),
                _SipCountersSection(),
              ],
            ),
    );
  }
}

/// Collapsible SIP debug counters section.
class _SipCountersSection extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final counters = ref.watch(sipCountersProvider);
    final entries = counters.toDisplayEntries();

    return ExpansionTile(
      leading: Icon(
        Icons.analytics_outlined,
        size: 20,
        color: theme.colorScheme.onSurface.withAlpha(153),
      ),
      title: Text(
        l10n.sipCountersTitle,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.onSurface.withAlpha(153),
        ),
      ),
      initiallyExpanded: false,
      children: entries
          .where((e) => e.value > 0)
          .map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacing16,
                vertical: AppTheme.spacing2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      e.label,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withAlpha(179),
                      ),
                    ),
                  ),
                  Text(
                    '${e.value}', // lint-allow: hardcoded-string
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
