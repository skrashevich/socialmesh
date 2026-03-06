// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/l10n_extension.dart';
import '../../core/logging.dart';
import '../../core/theme.dart';
import '../../core/widgets/app_bottom_sheet.dart';
import '../../providers/app_providers.dart';
import '../../providers/sip_providers.dart';
import '../../services/haptic_service.dart';
import '../../services/protocol/sip/sip_discovery.dart';

/// Bottom sheet showing discovered SIP peers.
///
/// Displays a list of SIP-capable peers detected via beacon or rollcall,
/// with a "Scan for Socialmesh" button to trigger a rollcall request.
class SipDiscoverySheet extends ConsumerStatefulWidget {
  const SipDiscoverySheet({super.key});

  /// Show the discovery sheet.
  static Future<void> show(BuildContext context) {
    return AppBottomSheet.show(
      context: context,
      child: const SipDiscoverySheet(),
    );
  }

  @override
  ConsumerState<SipDiscoverySheet> createState() => _SipDiscoverySheetState();
}

class _SipDiscoverySheetState extends ConsumerState<SipDiscoverySheet> {
  bool _scanning = false;

  void _onScan() {
    final discovery = ref.read(sipDiscoveryProvider);
    AppLogging.sip(
      'SIP_DISCOVERY: scan tapped, discovery=${discovery != null}',
    );
    if (discovery == null) return;

    final haptics = ref.read(hapticServiceProvider);
    haptics.trigger(HapticType.light);

    final outbound = discovery.buildRollcallReq();
    if (outbound != null) {
      // Send the encoded SIP frame over the mesh transport.
      final protocol = ref.read(protocolServiceProvider);
      protocol.sendSipPacket(outbound.encoded);
      AppLogging.sip(
        'SIP_DISCOVERY: ROLLCALL_REQ dispatched ${outbound.encoded.length}B',
      );
      setState(() => _scanning = true);
      // Reset scanning state after a short delay.
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) setState(() => _scanning = false);
      });
    } else {
      HapticFeedback.heavyImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final peers = ref.watch(sipDiscoveredPeersProvider);
    final theme = Theme.of(context);
    AppLogging.sip('SIP_DISCOVERY: build — peers=${peers.length}');

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.only(bottom: AppTheme.spacing16),
          child: Text(
            l10n.sipDiscoveryTitle,
            style: theme.textTheme.titleLarge,
          ),
        ),

        // Scan button
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: _scanning ? null : _onScan,
            icon: _scanning
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.radar, size: 18),
            label: Text(
              _scanning
                  ? l10n.sipDiscoveryScanCooldown(3)
                  : l10n.sipDiscoveryScanButton,
            ),
          ),
        ),

        const SizedBox(height: AppTheme.spacing16),

        // Peer list or empty state
        if (peers.isEmpty)
          _buildEmptyState(context, l10n)
        else
          ..._buildPeerList(context, peers, theme),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context, dynamic l10n) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.radar,
              size: 48,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            const SizedBox(height: AppTheme.spacing12),
            Text(
              l10n.sipDiscoveryNoPeers,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: AppTheme.spacing4),
            Text(
              l10n.sipDiscoveryNoPeersDescription,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPeerList(
    BuildContext context,
    List<SipPeerCapability> peers,
    ThemeData theme,
  ) {
    return [
      Text(
        context.l10n.sipDiscoveryPeersNearby(peers.length),
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
        ),
      ),
      const SizedBox(height: AppTheme.spacing8),
      ...peers.map((peer) => _PeerTile(peer: peer)),
    ];
  }
}

class _PeerTile extends ConsumerWidget {
  final SipPeerCapability peer;

  const _PeerTile({required this.peer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final nodeHex = '0x${peer.nodeId.toRadixString(16).toUpperCase()}';
    final deviceClassName = _deviceClassName(peer.deviceClass);

    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Icon(
            Icons.sensors,
            color: theme.colorScheme.onPrimaryContainer,
            size: 20,
          ),
        ),
        title: Text(
          '${l10n.sipDiscoveryPeerAnonymous} $nodeHex',
          style: theme.textTheme.bodyMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.sipDiscoveryDeviceClass(deviceClassName),
              style: theme.textTheme.bodySmall,
            ),
            Text(
              'Features: 0x${peer.features.toRadixString(16)}',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          ref.read(hapticServiceProvider).trigger(HapticType.selection);
        },
      ),
    );
  }

  static String _deviceClassName(int code) {
    switch (code) {
      case 0:
        return 'Unknown'; // lint-allow: hardcoded-string
      case 1:
        return 'Phone'; // lint-allow: hardcoded-string
      case 2:
        return 'Tablet'; // lint-allow: hardcoded-string
      case 3:
        return 'Desktop'; // lint-allow: hardcoded-string
      default:
        return 'Type $code'; // lint-allow: hardcoded-string
    }
  }
}
