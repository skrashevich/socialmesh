// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/safety/lifecycle_mixin.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/app_bar_overflow_menu.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../core/widgets/glass_scaffold.dart';
import '../../../core/widgets/node_selector_sheet.dart';
import '../../../providers/app_providers.dart';
import '../../../providers/file_transfer_providers.dart';
import '../../../services/haptic_service.dart';
import '../../../utils/snackbar.dart';
import '../../navigation/main_shell.dart';
import 'file_transfer_contacts_screen.dart';
import 'file_transfers_screen.dart';

/// Container screen that holds both Transfers and Contacts in tabs.
///
/// Follows the same pattern as [MessagesContainerScreen] for a unified
/// "File Transfers" experience with tab navigation.
class FileTransfersContainerScreen extends ConsumerStatefulWidget {
  const FileTransfersContainerScreen({super.key});

  @override
  ConsumerState<FileTransfersContainerScreen> createState() =>
      _FileTransfersContainerScreenState();
}

class _FileTransfersContainerScreenState
    extends ConsumerState<FileTransfersContainerScreen>
    with SingleTickerProviderStateMixin, LifecycleSafeMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transferState = ref.watch(fileTransferStateProvider);
    final fileCount = transferState.sortedTransfers.length;
    final activeCount = transferState.activeTransfers.length;
    final pendingCount = ref.watch(pendingTransferCountProvider);
    final nodes = ref.watch(nodesProvider);
    final myNodeNum = ref.watch(myNodeNumProvider);
    final contactCount = nodes.values
        .where((n) => n.nodeNum != myNodeNum)
        .length;

    final route = ModalRoute.of(context);
    final canPop = route != null ? !route.isFirst : Navigator.canPop(context);

    return GlassScaffold(
      resizeToAvoidBottomInset: false,
      leading: canPop ? const BackButton() : const HamburgerMenuButton(),
      centerTitle: true,
      title: 'File Transfers',
      actions: [
        const DeviceStatusButton(),
        AppBarOverflowMenu<String>(
          onSelected: _handleOverflowAction,
          itemBuilder: (context) => [
            PopupMenuItem<String>(
              value: 'pick_file',
              child: ListTile(
                leading: Icon(
                  Icons.attach_file,
                  color: context.accentColor,
                  size: 20,
                ),
                title: const Text('Send File'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            PopupMenuItem<String>(
              value: 'clear_done',
              child: ListTile(
                leading: Icon(
                  Icons.cleaning_services_outlined,
                  color: context.textSecondary,
                  size: 20,
                ),
                title: const Text('Clear Completed'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            PopupMenuItem<String>(
              value: 'purge',
              child: ListTile(
                leading: Icon(
                  Icons.delete_sweep_outlined,
                  color: context.textSecondary,
                  size: 20,
                ),
                title: const Text('Purge Expired'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: context.border.withValues(alpha: 0.3)),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            indicatorColor: context.accentColor,
            indicatorWeight: 3,
            labelColor: context.accentColor,
            unselectedLabelColor: context.textSecondary,
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            tabs: [
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Contacts'),
                    const SizedBox(width: AppTheme.spacing6),
                    _TabBadge(count: contactCount),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Files'),
                    const SizedBox(width: AppTheme.spacing6),
                    _TabBadge(
                      count: fileCount,
                      showDot: activeCount > 0 || pendingCount > 0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // Use hasScrollBody: true because each TabBarView child contains
      // its own CustomScrollView. hasScrollBody: false would force
      // intrinsic dimension computation which CustomScrollView cannot
      // provide, causing a null check crash in RenderViewportBase.
      slivers: [
        SliverFillRemaining(
          hasScrollBody: true,
          child: TabBarView(
            controller: _tabController,
            children: [
              const FileTransferContactsScreen(),
              FileTransfersScreen(
                embedded: true,
                onSwitchToContacts: () => _tabController.animateTo(0),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleOverflowAction(String value) {
    switch (value) {
      case 'pick_file':
        _pickAndSendFile();
      case 'clear_done':
        _clearTerminal();
      case 'purge':
        _purgeExpired();
    }
  }

  Future<void> _pickAndSendFile() async {
    final haptics = ref.read(hapticServiceProvider);
    final notifier = ref.read(fileTransferStateProvider.notifier);

    await haptics.trigger(HapticType.medium);
    if (!mounted) return;

    final selection = await NodeSelectorSheet.show(
      context,
      title: 'Send to Node',
      allowBroadcast: false,
    );
    final nodeNum = selection?.nodeNum;
    if (nodeNum == null) return;
    if (!mounted) return;

    final transfer = await notifier.pickAndSendFile(targetNodeNum: nodeNum);

    if (!mounted) return;
    if (transfer != null) {
      showSuccessSnackBar(context, 'Transfer started: ${transfer.filename}');
    }
  }

  Future<void> _clearTerminal() async {
    final haptics = ref.read(hapticServiceProvider);
    final notifier = ref.read(fileTransferStateProvider.notifier);

    await haptics.trigger(HapticType.light);
    if (!mounted) return;

    final confirmed = await AppBottomSheet.showConfirm(
      context: context,
      title: 'Clear Completed Transfers?',
      message:
          'Remove all completed, failed, and cancelled transfers? '
          'Active transfers will not be affected.',
      confirmLabel: 'Clear',
      isDestructive: true,
    );

    if (confirmed != true) return;
    if (!mounted) return;

    final count = await notifier.clearTerminalTransfers();
    if (!mounted) return;

    showSuccessSnackBar(context, 'Cleared $count transfers');
  }

  Future<void> _purgeExpired() async {
    final haptics = ref.read(hapticServiceProvider);
    final notifier = ref.read(fileTransferStateProvider.notifier);

    await haptics.trigger(HapticType.light);
    if (!mounted) return;

    await notifier.purgeExpired();
    if (!mounted) return;

    showSuccessSnackBar(context, 'Expired transfers purged');
  }
}

// ---------------------------------------------------------------------------
// Tab badge showing count and optional activity dot
// ---------------------------------------------------------------------------

class _TabBadge extends StatelessWidget {
  final int count;
  final bool showDot;

  const _TabBadge({required this.count, this.showDot = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: context.border.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppTheme.radius10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: AccentColors.cyan,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: AppTheme.spacing4),
          ],
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: context.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
