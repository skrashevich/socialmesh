// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n/l10n_extension.dart';
import '../../core/theme.dart';
import '../../core/widgets/app_bottom_sheet.dart';
import '../../services/haptic_service.dart';
import '../../services/protocol/sip/sip_discovery.dart';

/// Bottom sheet showing detailed info for a single SIP peer.
///
/// Displays node ID, device class, capabilities, feature flags, and
/// last-seen time. Action buttons will be wired once SIP-1 handshake
/// transport is connected.
class SipPeerDetailSheet extends ConsumerWidget {
  final SipPeerCapability peer;

  const SipPeerDetailSheet({super.key, required this.peer});

  /// Show the peer detail sheet.
  static Future<void> show(BuildContext context, SipPeerCapability peer) {
    return AppBottomSheet.show(
      context: context,
      child: SipPeerDetailSheet(peer: peer),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final nodeHex = '0x${peer.nodeId.toRadixString(16).toUpperCase()}';

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with icon and title
        Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: theme.colorScheme.primaryContainer,
              child: Icon(
                Icons.sensors,
                color: theme.colorScheme.onPrimaryContainer,
                size: 24,
              ),
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.sipPeerDetailTitle,
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppTheme.spacing2),
                  Text(
                    nodeHex,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      fontFamily: 'monospace', // lint-allow: hardcoded-string
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: AppTheme.spacing20),

        // Info rows
        _InfoRow(
          label: l10n.sipPeerDetailNodeId,
          value: nodeHex,
          icon: Icons.tag,
        ),
        _InfoRow(
          label: l10n.sipPeerDetailDeviceClass,
          value: _deviceClassName(peer.deviceClass),
          icon: Icons.devices,
        ),
        _InfoRow(
          label: l10n.sipPeerDetailFeatures,
          value: '0x${peer.features.toRadixString(16)}',
          icon: Icons.extension,
        ),
        _InfoRow(
          label: l10n.sipPeerDetailMtu,
          value: '${peer.mtuHint}', // lint-allow: hardcoded-string
          icon: Icons.straighten,
        ),
        _InfoRow(
          label: l10n.sipPeerDetailLastSeen,
          value: _formatLastSeen(context, peer.lastSeenMs),
          icon: Icons.schedule,
        ),

        const SizedBox(height: AppTheme.spacing16),

        // Capabilities section
        Text(l10n.sipPeerDetailCapabilities, style: theme.textTheme.titleSmall),
        const SizedBox(height: AppTheme.spacing8),
        Wrap(
          spacing: AppTheme.spacing8,
          runSpacing: AppTheme.spacing8,
          children: [
            _CapChip(
              label: l10n.sipPeerDetailSupportsSip1,
              supported: peer.supportsSip1,
            ),
            _CapChip(
              label: l10n.sipPeerDetailSupportsSip3,
              supported: peer.supportsSip3,
            ),
          ],
        ),

        const SizedBox(height: AppTheme.spacing24),

        // Action buttons
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () {
              ref.read(hapticServiceProvider).trigger(HapticType.medium);
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.handshake_outlined, size: 18),
            label: Text(l10n.sipHandshakeAction),
          ),
        ),
      ],
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

  static String _formatLastSeen(BuildContext context, int lastSeenMs) {
    final l10n = context.l10n;
    final nowMs = DateTime.now().millisecondsSinceEpoch;
    final diffMs = nowMs - lastSeenMs;
    final diffMinutes = diffMs ~/ 60000;

    if (diffMinutes < 1) return l10n.sipPeerDetailJustNow;
    if (diffMinutes < 60) return l10n.sipPeerDetailMinutesAgo(diffMinutes);
    final diffHours = diffMinutes ~/ 60;
    return l10n.sipPeerDetailHoursAgo(diffHours);
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _InfoRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          const SizedBox(width: AppTheme.spacing8),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const Spacer(),
          Text(value, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

class _CapChip extends StatelessWidget {
  final String label;
  final bool supported;

  const _CapChip({required this.label, required this.supported});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Chip(
      avatar: Icon(
        supported ? Icons.check_circle : Icons.cancel,
        size: 16,
        color: supported
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurface.withValues(alpha: 0.4),
      ),
      label: Text(
        label,
        style: theme.textTheme.bodySmall?.copyWith(
          color: supported
              ? theme.colorScheme.onSurface
              : theme.colorScheme.onSurface.withValues(alpha: 0.5),
        ),
      ),
      backgroundColor: supported
          ? theme.colorScheme.primaryContainer.withValues(alpha: 0.3)
          : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing4),
    );
  }
}
