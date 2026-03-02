// SPDX-License-Identifier: GPL-3.0-or-later
// lint-allow: scaffold (embedded tab panel, GlassScaffold provided by container)

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/safety/lifecycle_mixin.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/animations.dart';
import '../../../core/widgets/node_selector_sheet.dart';
import '../../../providers/app_providers.dart';
import '../../../providers/file_transfer_providers.dart';
import '../../../services/file_transfer/file_transfer_engine.dart';
import '../../../services/haptic_service.dart';
import '../../../utils/snackbar.dart';
import '../../nodes/node_display_name_resolver.dart';
import '../../nodedex/widgets/sigil_painter.dart';
import '../widgets/file_content_preview.dart';
import '../widgets/file_transfer_card.dart';

/// Contact model representing a node the user has exchanged files with.
class _TransferContact {
  final int nodeNum;
  final int transferCount;
  final int activeCount;
  final DateTime lastTransferAt;
  final int sentCount;
  final int receivedCount;
  final int totalBytes;

  const _TransferContact({
    required this.nodeNum,
    required this.transferCount,
    required this.activeCount,
    required this.lastTransferAt,
    required this.sentCount,
    required this.receivedCount,
    required this.totalBytes,
  });
}

/// Contacts tab showing nodes the user has exchanged files with.
///
/// Displays recent transfer contacts sorted by last activity, with
/// node name, sigil avatar, transfer statistics, and the ability to
/// initiate new transfers.
class FileTransferContactsScreen extends ConsumerStatefulWidget {
  const FileTransferContactsScreen({super.key});

  @override
  ConsumerState<FileTransferContactsScreen> createState() =>
      _FileTransferContactsScreenState();
}

class _FileTransferContactsScreenState
    extends ConsumerState<FileTransferContactsScreen>
    with LifecycleSafeMixin {
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  List<_TransferContact> _buildContacts(FileTransferListState state) {
    final contactMap = <int, _ContactAccumulator>{};

    for (final transfer in state.sortedTransfers) {
      final nodeNum = transfer.direction == TransferDirection.outbound
          ? transfer.targetNodeNum
          : transfer.sourceNodeNum;
      if (nodeNum == null) continue;

      final acc = contactMap[nodeNum] ??= _ContactAccumulator(nodeNum: nodeNum);
      acc.transferCount++;
      if (transfer.isActive) acc.activeCount++;
      if (transfer.direction == TransferDirection.outbound) {
        acc.sentCount++;
      } else {
        acc.receivedCount++;
      }
      acc.totalBytes += transfer.totalBytes;

      final dt = transfer.completedAt ?? transfer.createdAt;
      if (dt.isAfter(acc.lastTransferAt)) {
        acc.lastTransferAt = dt;
      }
    }

    final contacts =
        contactMap.values
            .map(
              (acc) => _TransferContact(
                nodeNum: acc.nodeNum,
                transferCount: acc.transferCount,
                activeCount: acc.activeCount,
                lastTransferAt: acc.lastTransferAt,
                sentCount: acc.sentCount,
                receivedCount: acc.receivedCount,
                totalBytes: acc.totalBytes,
              ),
            )
            .toList()
          ..sort((a, b) => b.lastTransferAt.compareTo(a.lastTransferAt));

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      final nodes = ref.read(nodesProvider);
      return contacts.where((c) {
        final node = nodes[c.nodeNum];
        final displayName = NodeDisplayNameResolver.resolve(
          nodeNum: c.nodeNum,
          longName: node?.longName,
          shortName: node?.shortName,
        ).toLowerCase();
        final hexId = '!${c.nodeNum.toRadixString(16)}'.toLowerCase();
        return displayName.contains(query) || hexId.contains(query);
      }).toList();
    }

    return contacts;
  }

  @override
  Widget build(BuildContext context) {
    final transferState = ref.watch(fileTransferStateProvider);
    final contacts = _buildContacts(transferState);

    return GestureDetector(
      onTap: _dismissKeyboard,
      child: Container(
        color: context.background,
        child: CustomScrollView(
          slivers: [
            // Search bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppTheme.spacing16,
                  AppTheme.spacing12,
                  AppTheme.spacing16,
                  AppTheme.spacing8,
                ),
                child: _ContactSearchBar(
                  controller: _searchController,
                  onChanged: (value) {
                    safeSetState(() => _searchQuery = value);
                  },
                ),
              ),
            ),

            // Recent Contacts header
            if (contacts.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppTheme.spacing16,
                    AppTheme.spacing8,
                    AppTheme.spacing16,
                    AppTheme.spacing8,
                  ),
                  child: Text(
                    'Recent Contacts',
                    style: TextStyle(
                      color: context.textTertiary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

            // Contact list or empty state
            if (transferState.isLoading)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: CircularProgressIndicator()),
              )
            else if (contacts.isEmpty && _searchQuery.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _buildEmptyState(),
              )
            else if (contacts.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    'No contacts match "$_searchQuery"',
                    style: TextStyle(color: context.textTertiary, fontSize: 14),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing16,
                ),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return _ContactCard(
                      contact: contacts[index],
                      onTap: () => _openContactDetail(contacts[index]),
                      onSendFile: () =>
                          _sendFileToContact(contacts[index].nodeNum),
                    );
                  }, childCount: contacts.length),
                ),
              ),

            // Bottom spacing
            const SliverToBoxAdapter(
              child: SizedBox(height: AppTheme.spacing24),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 80, color: context.textTertiary),
          const SizedBox(height: AppTheme.spacing24),
          Text(
            'No Transfer Contacts',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: context.textSecondary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          Text(
            'Nodes you exchange files with\nwill appear here',
            textAlign: TextAlign.center,
            style: context.bodySecondaryStyle?.copyWith(
              color: context.textTertiary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing24),
          FilledButton.icon(
            onPressed: () => _sendToNewNode(),
            icon: const Icon(Icons.send),
            label: const Text('Send a File'),
          ),
        ],
      ),
    );
  }

  Future<void> _sendToNewNode() async {
    final haptics = ref.read(hapticServiceProvider);
    final notifier = ref.read(fileTransferStateProvider.notifier);

    await haptics.trigger(HapticType.medium);
    if (!mounted) return;

    final selection = await NodeSelectorSheet.show(
      context,
      title: 'Send File To',
      allowBroadcast: true,
      broadcastLabel: 'Broadcast to All',
      broadcastSubtitle: 'Send to every node on the mesh',
    );
    if (selection == null) return;
    if (!mounted) return;

    final transfer = await notifier.pickAndSendFile(
      targetNodeNum: selection.nodeNum,
    );

    if (!mounted) return;
    if (transfer != null) {
      showSuccessSnackBar(context, 'Transfer started: ${transfer.filename}');
    }
  }

  Future<void> _sendFileToContact(int nodeNum) async {
    final haptics = ref.read(hapticServiceProvider);
    final notifier = ref.read(fileTransferStateProvider.notifier);

    await haptics.trigger(HapticType.medium);
    if (!mounted) return;

    final transfer = await notifier.pickAndSendFile(targetNodeNum: nodeNum);

    if (!mounted) return;
    if (transfer != null) {
      showSuccessSnackBar(context, 'Transfer started: ${transfer.filename}');
    }
  }

  void _openContactDetail(_TransferContact contact) {
    final transfers = ref.read(nodeTransfersProvider(contact.nodeNum));
    final nodes = ref.read(nodesProvider);
    final node = nodes[contact.nodeNum];
    final displayName = NodeDisplayNameResolver.resolve(
      nodeNum: contact.nodeNum,
      longName: node?.longName,
      shortName: node?.shortName,
    );

    _ContactDetailSheet.show(
      context: context,
      nodeNum: contact.nodeNum,
      displayName: displayName,
      contact: contact,
      transfers: transfers,
      onSendFile: () => _sendFileToContact(contact.nodeNum),
    );
    HapticFeedback.lightImpact();
  }
}

// ---------------------------------------------------------------------------
// Private helper
// ---------------------------------------------------------------------------

class _ContactAccumulator {
  final int nodeNum;
  int transferCount = 0;
  int activeCount = 0;
  int sentCount = 0;
  int receivedCount = 0;
  int totalBytes = 0;
  DateTime lastTransferAt = DateTime.fromMillisecondsSinceEpoch(0);

  _ContactAccumulator({required this.nodeNum});
}

// ---------------------------------------------------------------------------
// Search bar
// ---------------------------------------------------------------------------

class _ContactSearchBar extends StatelessWidget {
  const _ContactSearchBar({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius10),
        border: Border.all(color: context.border.withValues(alpha: 0.3)),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        maxLength: 100,
        style: TextStyle(color: context.textPrimary, fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Search contacts',
          hintStyle: TextStyle(color: context.textTertiary, fontSize: 14),
          prefixIcon: Icon(Icons.search, size: 18, color: context.textTertiary),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    controller.clear();
                    onChanged('');
                  },
                  icon: Icon(
                    Icons.close,
                    size: 16,
                    color: context.textTertiary,
                  ),
                )
              : null,
          border: InputBorder.none,
          counterText: '',
          contentPadding: const EdgeInsets.symmetric(vertical: 10),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Contact card
// ---------------------------------------------------------------------------

class _ContactCard extends ConsumerWidget {
  const _ContactCard({
    required this.contact,
    required this.onTap,
    required this.onSendFile,
  });

  final _TransferContact contact;
  final VoidCallback onTap;
  final VoidCallback onSendFile;

  String _relativeTime(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${dt.month}/${dt.day}';
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    final kb = bytes / 1024.0;
    if (kb < 1024) return '${kb.toStringAsFixed(1)} KB';
    final mb = kb / 1024.0;
    return '${mb.toStringAsFixed(1)} MB';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nodes = ref.watch(nodesProvider);
    final node = nodes[contact.nodeNum];
    final displayName = NodeDisplayNameResolver.resolve(
      nodeNum: contact.nodeNum,
      longName: node?.longName,
      shortName: node?.shortName,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing8),
      child: BouncyTap(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spacing12),
          decoration: BoxDecoration(
            color: context.card,
            borderRadius: BorderRadius.circular(AppTheme.radius12),
            border: Border.all(color: context.border.withValues(alpha: 0.5)),
          ),
          child: Row(
            children: [
              // Sigil avatar
              SigilAvatar(nodeNum: contact.nodeNum, size: 44),
              const SizedBox(width: AppTheme.spacing12),

              // Name and metadata
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name row
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            displayName,
                            style: TextStyle(
                              color: context.textPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          _relativeTime(contact.lastTransferAt),
                          style: TextStyle(
                            color: context.textTertiary,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacing4),

                    // Stats row
                    Wrap(
                      spacing: AppTheme.spacing8,
                      children: [
                        _StatChip(
                          icon: Icons.swap_vert,
                          label: '${contact.transferCount}',
                          color: context.textTertiary,
                        ),
                        if (contact.sentCount > 0)
                          _StatChip(
                            icon: Icons.arrow_upward,
                            label: '${contact.sentCount}',
                            color: AppTheme.primaryBlue,
                          ),
                        if (contact.receivedCount > 0)
                          _StatChip(
                            icon: Icons.arrow_downward,
                            label: '${contact.receivedCount}',
                            color: AppTheme.primaryPurple,
                          ),
                        _StatChip(
                          icon: Icons.data_usage,
                          label: _formatBytes(contact.totalBytes),
                          color: context.textTertiary,
                        ),
                        if (contact.activeCount > 0)
                          _StatChip(
                            icon: Icons.sync,
                            label: '${contact.activeCount} active',
                            color: AccentColors.cyan,
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              // Send file button
              const SizedBox(width: AppTheme.spacing8),
              IconButton(
                onPressed: onSendFile,
                icon: Icon(
                  Icons.attach_file,
                  size: 20,
                  color: context.accentColor,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Stat chip
// ---------------------------------------------------------------------------

class _StatChip extends StatelessWidget {
  const _StatChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 11, color: color),
        const SizedBox(width: AppTheme.spacing2),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Contact detail sheet
// ---------------------------------------------------------------------------

class _ContactDetailSheet extends StatelessWidget {
  const _ContactDetailSheet({
    required this.nodeNum,
    required this.displayName,
    required this.contact,
    required this.transfers,
    required this.onSendFile,
    required this.scrollController,
  });

  final int nodeNum;
  final String displayName;
  final _TransferContact contact;
  final List<FileTransferState> transfers;
  final VoidCallback onSendFile;
  final ScrollController scrollController;

  static void show({
    required BuildContext context,
    required int nodeNum,
    required String displayName,
    required _TransferContact contact,
    required List<FileTransferState> transfers,
    required VoidCallback onSendFile,
  }) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.5,
        minChildSize: 0.3,
        maxChildSize: 0.85,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF1A1A2E)
                  : const Color(0xFFF8F9FA),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppTheme.radius20),
              ),
            ),
            child: _ContactDetailSheet(
              nodeNum: nodeNum,
              displayName: displayName,
              contact: contact,
              transfers: transfers,
              onSendFile: onSendFile,
              scrollController: scrollController,
            ),
          );
        },
      ),
    );
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    final kb = bytes / 1024.0;
    if (kb < 1024) return '${kb.toStringAsFixed(1)} KB';
    final mb = kb / 1024.0;
    return '${mb.toStringAsFixed(1)} MB';
  }

  String _relativeTime(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${dt.month}/${dt.day}';
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        // Handle bar
        SliverToBoxAdapter(
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: AppTheme.spacing12),
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: context.border.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(AppTheme.radius2),
              ),
            ),
          ),
        ),

        // Header with sigil and name
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacing20),
            child: Column(
              children: [
                SigilAvatar(nodeNum: nodeNum, size: 64),
                const SizedBox(height: AppTheme.spacing12),
                Text(
                  displayName,
                  style: TextStyle(
                    color: context.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppTheme.spacing4),
                Text(
                  '!${nodeNum.toRadixString(16)}',
                  style: TextStyle(
                    color: context.textTertiary,
                    fontSize: 13,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: AppTheme.spacing16),

                // Stats row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _DetailStat(
                      label: 'Sent',
                      value: '${contact.sentCount}',
                      icon: Icons.arrow_upward,
                      color: AppTheme.primaryBlue,
                    ),
                    _DetailStat(
                      label: 'Received',
                      value: '${contact.receivedCount}',
                      icon: Icons.arrow_downward,
                      color: AppTheme.primaryPurple,
                    ),
                    _DetailStat(
                      label: 'Total',
                      value: _formatBytes(contact.totalBytes),
                      icon: Icons.data_usage,
                      color: context.textTertiary,
                    ),
                  ],
                ),

                const SizedBox(height: AppTheme.spacing16),

                // Send file button
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onSendFile();
                    },
                    icon: const Icon(Icons.attach_file, size: 18),
                    label: const Text('Send File'),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Recent transfers header
        if (transfers.isNotEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacing20,
              ),
              child: Text(
                'Recent Transfers',
                style: TextStyle(
                  color: context.textTertiary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),

        // Transfer history
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacing20,
            vertical: AppTheme.spacing8,
          ),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final transfer = transfers[index];
              final canPreview =
                  transfer.fileBytes != null && transfer.fileBytes!.isNotEmpty;
              return _CompactTransferRow(
                transfer: transfer,
                relativeTime: _relativeTime(
                  transfer.completedAt ?? transfer.createdAt,
                ),
                onTap: canPreview
                    ? () => FileContentPreview.show(
                        context: context,
                        transfer: transfer,
                      )
                    : null,
              );
            }, childCount: transfers.length),
          ),
        ),

        // Bottom spacing
        const SliverToBoxAdapter(child: SizedBox(height: AppTheme.spacing24)),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Detail stat widget
// ---------------------------------------------------------------------------

class _DetailStat extends StatelessWidget {
  const _DetailStat({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(height: AppTheme.spacing6),
        Text(
          value,
          style: TextStyle(
            color: context.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: context.textTertiary, fontSize: 11),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Compact transfer row for detail sheet
// ---------------------------------------------------------------------------

class _CompactTransferRow extends StatelessWidget {
  const _CompactTransferRow({
    required this.transfer,
    required this.relativeTime,
    this.onTap,
  });

  final FileTransferState transfer;
  final String relativeTime;
  final VoidCallback? onTap;

  IconData get _stateIcon => switch (transfer.state) {
    TransferState.created || TransferState.offerSent => Icons.schedule,
    TransferState.offerPending => Icons.inbox,
    TransferState.chunking =>
      transfer.direction == TransferDirection.outbound
          ? Icons.upload
          : Icons.download,
    TransferState.waitingMissing => Icons.sync_problem,
    TransferState.complete => Icons.check_circle,
    TransferState.failed => Icons.error_outline,
    TransferState.cancelled => Icons.cancel_outlined,
  };

  Color _stateColor(BuildContext context) => switch (transfer.state) {
    TransferState.created ||
    TransferState.offerSent ||
    TransferState.cancelled => context.textTertiary,
    TransferState.offerPending ||
    TransferState.waitingMissing => SemanticColors.warning,
    TransferState.chunking => context.accentColor,
    TransferState.complete => SemanticColors.success,
    TransferState.failed => SemanticColors.error,
  };

  String _formatSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    return '${(bytes / 1024.0).toStringAsFixed(1)} KB';
  }

  @override
  Widget build(BuildContext context) {
    final isOutbound = transfer.direction == TransferDirection.outbound;
    final canPreview = onTap != null;
    final row = Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing8),
      child: Row(
        children: [
          // Mime-type icon
          SizedBox(
            width: 32,
            height: 32,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                FileTypeIcon(mimeType: transfer.mimeType, size: 32),
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: isOutbound
                          ? AppTheme.primaryBlue
                          : AppTheme.primaryPurple,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.background,
                        width: AppTheme.spacing2,
                      ),
                    ),
                    child: Icon(
                      isOutbound ? Icons.arrow_upward : Icons.arrow_downward,
                      size: 7,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppTheme.spacing10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transfer.filename,
                  style: TextStyle(
                    color: context.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  _formatSize(transfer.totalBytes),
                  style: TextStyle(color: context.textTertiary, fontSize: 11),
                ),
              ],
            ),
          ),
          if (canPreview)
            Padding(
              padding: const EdgeInsets.only(right: AppTheme.spacing6),
              child: Icon(
                Icons.visibility_outlined,
                size: 13,
                color: context.accentColor.withValues(alpha: 0.7),
              ),
            ),
          Icon(_stateIcon, size: 14, color: _stateColor(context)),
          const SizedBox(width: AppTheme.spacing6),
          Text(
            relativeTime,
            style: TextStyle(color: context.textTertiary, fontSize: 11),
          ),
        ],
      ),
    );
    if (onTap == null) return row;
    return BouncyTap(onTap: onTap!, child: row);
  }
}
