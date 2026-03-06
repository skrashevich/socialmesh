// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)
import '../../../core/l10n/l10n_extension.dart';
import '../../../core/safety/lifecycle_mixin.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/meshcore_constants.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/glass_scaffold.dart';
import '../../../core/widgets/gradient_border_container.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../providers/app_providers.dart';
import '../../../providers/meshcore_providers.dart';
import '../../../services/meshcore/protocol/meshcore_frame.dart';
import '../../../services/meshcore/protocol/meshcore_messages.dart';
import '../../../utils/snackbar.dart';
import '../../navigation/meshcore_shell.dart';

/// MeshCore Settings screen.
///
/// Provides device info, node settings, radio settings, and device actions.
class MeshCoreSettingsScreen extends ConsumerStatefulWidget {
  const MeshCoreSettingsScreen({super.key});

  @override
  ConsumerState<MeshCoreSettingsScreen> createState() =>
      _MeshCoreSettingsScreenState();
}

class _MeshCoreSettingsScreenState extends ConsumerState<MeshCoreSettingsScreen>
    with LifecycleSafeMixin<MeshCoreSettingsScreen> {
  void _dismissKeyboard() {
    HapticFeedback.selectionClick();
    FocusScope.of(context).unfocus();
  }

  String _appVersion = '';
  bool _showBatteryVoltage = false;
  bool _isSendingAdvert = false;
  bool _isSyncingTime = false;

  @override
  void initState() {
    super.initState();
    _loadVersionInfo();
  }

  Future<void> _loadVersionInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _appVersion = packageInfo.version;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final linkStatus = ref.watch(linkStatusProvider);
    final isConnected = linkStatus.isConnected;
    final selfInfoState = ref.watch(meshCoreSelfInfoProvider);
    final selfInfo = selfInfoState.selfInfo;
    final batteryState = ref.watch(meshCoreBatteryProvider);
    final contactsState = ref.watch(meshCoreContactsProvider);
    final channelsState = ref.watch(meshCoreChannelsProvider);

    return GestureDetector(
      onTap: _dismissKeyboard,
      child: GlassScaffold(
        leading: const MeshCoreHamburgerMenuButton(),
        title: context.l10n.meshcoreSettingsTitle,
        actions: [const MeshCoreDeviceStatusButton()],
        // Use hasScrollBody: true because the child is a ListView.
        // hasScrollBody: false would force intrinsic dimension computation
        // which ListView cannot provide, causing a null check crash in
        // RenderViewportBase.layoutChildSequence.
        slivers: [
          SliverFillRemaining(
            hasScrollBody: true,
            child: ListView(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              children: [
                _buildDeviceInfoCard(
                  context,
                  isConnected: isConnected,
                  selfInfo: selfInfo,
                  batteryState: batteryState,
                  contactCount: contactsState.contacts.length,
                  channelCount: channelsState.channels.length,
                ),
                const SizedBox(height: AppTheme.spacing16),
                _buildNodeSettingsCard(context, selfInfo),
                const SizedBox(height: AppTheme.spacing16),
                _buildActionsCard(context, isConnected),
                const SizedBox(height: AppTheme.spacing16),
                _buildDebugCard(context),
                const SizedBox(height: AppTheme.spacing16),
                _buildAboutCard(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeviceInfoCard(
    BuildContext context, {
    required bool isConnected,
    MeshCoreSelfInfo? selfInfo,
    MeshCoreBatteryState? batteryState,
    required int contactCount,
    required int channelCount,
  }) {
    return GradientBorderContainer(
      accentColor: AccentColors.cyan,
      borderRadius: 16,
      borderWidth: 1,
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline_rounded, color: AccentColors.cyan),
              const SizedBox(width: AppTheme.spacing8),
              Text(
                context.l10n.meshcoreDeviceInfo,
                style: TextStyle(
                  color: AccentColors.cyan,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),
          _buildInfoRow(
            context.l10n.meshcoreStatusLabel,
            isConnected
                ? context.l10n.meshcoreConnected
                : context.l10n.meshcoreDisconnectedStatus,
            valueColor: isConnected ? AccentColors.green : AppTheme.errorRed,
          ),
          if (selfInfo != null) ...[
            _buildInfoRow(
              context.l10n.meshcoreNodeNameLabel,
              selfInfo.nodeName,
            ),
            () {
              final hex = _bytesToHex(selfInfo.pubKey);
              final display = hex.length >= 16
                  ? '${hex.substring(0, 16)}…'
                  : hex;
              return _buildInfoRow(
                context.l10n.meshcorePublicKeySettingsLabel,
                display,
                onTap: () {
                  Clipboard.setData(
                    ClipboardData(text: _bytesToHex(selfInfo.pubKey)),
                  );
                  showSuccessSnackBar(
                    context,
                    context.l10n.meshcorePublicKeyCopiedSettings,
                  );
                },
              );
            }(),
          ],
          _buildBatteryRow(batteryState),
          _buildInfoRow(context.l10n.meshcoreContactsLabel, '$contactCount'),
          _buildInfoRow(context.l10n.meshcoreChannelsLabel, '$channelCount'),
        ],
      ),
    );
  }

  Widget _buildBatteryRow(MeshCoreBatteryState? state) {
    String displayValue;
    IconData icon;
    Color? iconColor;
    Color? valueColor;

    if (state == null || state.voltageMillivolts == null) {
      displayValue = context.l10n.meshcoreBatteryUnknown;
      icon = Icons.battery_unknown_rounded;
      iconColor = SemanticColors.disabled;
    } else if (_showBatteryVoltage) {
      displayValue =
          '${(state.voltageMillivolts! / 1000.0).toStringAsFixed(2)}V';
      icon = Icons.battery_full_rounded;
    } else if (state.percentage != null) {
      displayValue = '${state.percentage}%';
      if (state.percentage! <= 15) {
        icon = Icons.battery_alert_rounded;
        iconColor = AccentColors.orange;
        valueColor = AccentColors.orange;
      } else {
        icon = Icons.battery_full_rounded;
      }
    } else {
      displayValue =
          '${(state.voltageMillivolts! / 1000.0).toStringAsFixed(2)}V';
      icon = Icons.battery_full_rounded;
    }

    return _buildInfoRow(
      context.l10n.meshcoreBatteryStatusLabel,
      displayValue,
      leading: Icon(icon, size: 18, color: iconColor),
      valueColor: valueColor,
      onTap: state?.voltageMillivolts != null
          ? () => setState(() => _showBatteryVoltage = !_showBatteryVoltage)
          : null,
    );
  }

  Widget _buildNodeSettingsCard(
    BuildContext context,
    MeshCoreSelfInfo? selfInfo,
  ) {
    return GradientBorderContainer(
      accentColor: AccentColors.purple,
      borderRadius: 16,
      borderWidth: 1,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppTheme.spacing16, 8, 16, 8),
            child: Row(
              children: [
                Icon(Icons.tune_rounded, color: AccentColors.purple),
                const SizedBox(width: AppTheme.spacing8),
                Text(
                  context.l10n.meshcoreNodeSettings,
                  style: TextStyle(
                    color: AccentColors.purple,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _buildSettingsTile(
            icon: Icons.person_outline_rounded,
            title: context.l10n.meshcoreNodeNameSetting,
            subtitle: selfInfo?.nodeName ?? context.l10n.meshcoreNotSet,
            onTap: () => _editNodeName(context, selfInfo?.nodeName),
          ),
          _buildDivider(),
          _buildSettingsTile(
            icon: Icons.radio_rounded,
            title: context.l10n.meshcoreRadioSettings,
            subtitle: context.l10n.meshcoreRadioSettingsSubtitle,
            onTap: () => _showRadioSettings(context),
          ),
          _buildDivider(),
          _buildSettingsTile(
            icon: Icons.location_on_outlined,
            title: context.l10n.meshcoreLocationSetting,
            subtitle: context.l10n.meshcoreSetNodePosition,
            onTap: () => _editLocation(context),
          ),
          _buildDivider(),
          _buildSettingsTile(
            icon: Icons.visibility_off_outlined,
            title: context.l10n.meshcorePrivacyMode,
            subtitle: context.l10n.meshcoreControlAdvertVisibility,
            onTap: () => _togglePrivacy(context),
          ),
        ],
      ),
    );
  }

  Widget _buildActionsCard(BuildContext context, bool isConnected) {
    return GradientBorderContainer(
      accentColor: AccentColors.green,
      borderRadius: 16,
      borderWidth: 1,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppTheme.spacing16, 8, 16, 8),
            child: Row(
              children: [
                Icon(Icons.bolt_rounded, color: AccentColors.green),
                const SizedBox(width: AppTheme.spacing8),
                Text(
                  context.l10n.meshcoreActions,
                  style: TextStyle(
                    color: AccentColors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _buildSettingsTile(
            icon: Icons.cell_tower_rounded,
            title: context.l10n.meshcoreSendAdvertisement,
            subtitle: _isSendingAdvert
                ? context.l10n.meshcoreSending
                : context.l10n.meshcoreBroadcastYourPresence,
            enabled: isConnected && !_isSendingAdvert,
            onTap: _sendAdvert,
          ),
          _buildDivider(),
          _buildSettingsTile(
            icon: Icons.sync_rounded,
            title: context.l10n.meshcoreSyncTime,
            subtitle: _isSyncingTime
                ? context.l10n.meshcoreSyncing
                : context.l10n.meshcoreUpdateDeviceClock,
            enabled: isConnected && !_isSyncingTime,
            onTap: _syncTime,
          ),
          _buildDivider(),
          _buildSettingsTile(
            icon: Icons.refresh_rounded,
            title: context.l10n.meshcoreRefreshContactsSetting,
            subtitle: context.l10n.meshcoreReloadContactsFromDevice,
            enabled: isConnected,
            onTap: () => _refreshContacts(context),
          ),
          _buildDivider(),
          _buildSettingsTile(
            icon: Icons.restart_alt_rounded,
            iconColor: AccentColors.orange,
            title: context.l10n.meshcoreRebootDevice,
            subtitle: context.l10n.meshcoreRestartMeshCoreDevice,
            enabled: isConnected,
            onTap: () => _confirmReboot(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDebugCard(BuildContext context) {
    return GradientBorderContainer(
      accentColor: SemanticColors.disabled,
      borderRadius: 16,
      borderWidth: 1,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppTheme.spacing16, 8, 16, 8),
            child: Row(
              children: [
                const Icon(
                  Icons.bug_report_outlined,
                  color: SemanticColors.disabled,
                ),
                const SizedBox(width: AppTheme.spacing8),
                Text(
                  context.l10n.meshcoreDebug,
                  style: TextStyle(
                    color: SemanticColors.disabled,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          _buildSettingsTile(
            icon: Icons.code_rounded,
            title: context.l10n.meshcoreProtocolCapture,
            subtitle: context.l10n.meshcoreViewFrameLogs,
            onTap: () => _showProtocolCapture(context),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutCard(BuildContext context) {
    return GradientBorderContainer(
      accentColor: AccentColors.slate,
      borderRadius: 16,
      borderWidth: 1,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(Icons.info_outline_rounded, color: AccentColors.slate),
        title: Text(
          context.l10n.meshcoreAbout,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          'SocialMesh v${_appVersion.isEmpty ? '...' : _appVersion}',
          style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
        ),
        onTap: () => _showAbout(context),
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value, {
    Widget? leading,
    Color? valueColor,
    VoidCallback? onTap,
  }) {
    final content = Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (leading != null) ...[
                leading,
                const SizedBox(width: AppTheme.spacing8),
              ],
              Text(
                label,
                style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
              ),
            ],
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                color: valueColor ?? Colors.white,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radius4),
        child: content,
      );
    }
    return content;
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Color? iconColor,
    bool enabled = true,
    VoidCallback? onTap,
  }) {
    return ListTile(
      enabled: enabled,
      leading: Icon(
        icon,
        color: enabled
            ? (iconColor ?? Colors.white.withValues(alpha: 0.8))
            : Colors.white.withValues(alpha: 0.3),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: enabled ? Colors.white : Colors.white.withValues(alpha: 0.4),
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: enabled
              ? Colors.white.withValues(alpha: 0.6)
              : Colors.white.withValues(alpha: 0.3),
        ),
      ),
      trailing: Icon(
        Icons.chevron_right_rounded,
        color: enabled
            ? Colors.white.withValues(alpha: 0.5)
            : Colors.white.withValues(alpha: 0.2),
      ),
      onTap: enabled ? onTap : null,
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      indent: 16,
      endIndent: 16,
      color: Colors.white.withValues(alpha: 0.1),
    );
  }

  // ---------------------------------------------------------------------------
  // Action handlers
  // ---------------------------------------------------------------------------

  void _editNodeName(BuildContext context, String? currentName) {
    final controller = TextEditingController(text: currentName ?? '');
    AppBottomSheet.show(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.meshcoreEditNodeName,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          TextField(
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            controller: controller,
            autofocus: true,
            maxLength: 31,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: context.l10n.meshcoreEnterNodeNameHint,
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.4)),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radius12),
                borderSide: BorderSide.none,
              ),
              counterText: '',
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white.withValues(alpha: 0.8),
                    side: BorderSide(
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(context.l10n.meshcoreCancel),
                ),
              ),
              const SizedBox(width: AppTheme.spacing12),
              Expanded(
                child: FilledButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    await _setNodeName(controller.text.trim());
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AccentColors.cyan.withValues(alpha: 0.3),
                    foregroundColor: AccentColors.cyan,
                  ),
                  child: Text(context.l10n.meshcoreSave),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _setNodeName(String name) async {
    if (name.isEmpty) return;

    // Capture providers before any await
    if (!mounted) return;
    final session = ref.read(meshCoreSessionProvider);
    final selfInfoNotifier = ref.read(meshCoreSelfInfoProvider.notifier);

    if (session == null || !session.isActive) {
      if (mounted) {
        showErrorSnackBar(context, context.l10n.meshcoreNotConnected);
      }
      return;
    }

    try {
      // CMD_SET_ADVERT_NAME = 0x08
      final payload = Uint8List.fromList([...name.codeUnits, 0]);
      await session.sendFrame(
        MeshCoreFrame(
          command: MeshCoreCommands.setAdvertName,
          payload: payload,
        ),
      );
      if (!mounted) return;
      // Refresh self info
      selfInfoNotifier.refresh();
      showSuccessSnackBar(context, context.l10n.meshcoreNodeNameUpdated);
    } catch (e) {
      if (mounted) {
        showErrorSnackBar(context, context.l10n.meshcoreFailedToSetName);
      }
    }
  }

  void _showRadioSettings(BuildContext context) {
    AppBottomSheet.show(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.meshcoreRadioSettingsDialogTitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          Container(
            padding: const EdgeInsets.all(AppTheme.spacing16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.radius12),
            ),
            child: Column(
              children: [
                _buildInfoRow(
                  context.l10n.meshcoreFrequencyLabel,
                  context.l10n.meshcoreNotYetImplemented,
                ),
                _buildInfoRow(
                  context.l10n.meshcoreTxPowerLabel,
                  context.l10n.meshcoreNotYetImplemented,
                ),
                _buildInfoRow(
                  context.l10n.meshcoreBandwidthLabel,
                  context.l10n.meshcoreNotYetImplemented,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white.withValues(alpha: 0.8),
                side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
              ),
              child: Text(context.l10n.meshcoreClose),
            ),
          ),
        ],
      ),
    );
  }

  void _editLocation(BuildContext context) {
    AppBottomSheet.show(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.meshcoreSetLocation,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          Container(
            padding: const EdgeInsets.all(AppTheme.spacing16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.radius12),
            ),
            child: Text(
              context.l10n.meshcoreLocationComingSoon,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white.withValues(alpha: 0.8),
                side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
              ),
              child: Text(context.l10n.meshcoreClose),
            ),
          ),
        ],
      ),
    );
  }

  void _togglePrivacy(BuildContext context) {
    AppBottomSheet.show(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.meshcorePrivacyModeDialogTitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          Container(
            padding: const EdgeInsets.all(AppTheme.spacing16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.radius12),
            ),
            child: Text(
              context.l10n.meshcorePrivacyComingSoon,
              style: const TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white.withValues(alpha: 0.8),
                side: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
              ),
              child: Text(context.l10n.meshcoreClose),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendAdvert() async {
    if (_isSendingAdvert) return;
    final session = ref.read(meshCoreSessionProvider);
    if (session == null || !session.isActive) {
      if (mounted) {
        showErrorSnackBar(context, context.l10n.meshcoreNotConnected);
      }
      return;
    }

    safeSetState(() => _isSendingAdvert = true);
    try {
      await session.sendCommand(MeshCoreCommands.sendSelfAdvert);
      if (mounted) {
        showSuccessSnackBar(context, context.l10n.meshcoreAdvertisementSent);
      }
    } catch (e) {
      if (mounted) {
        showErrorSnackBar(
          context,
          context.l10n.meshcoreFailedToSendAdvertisement,
        );
      }
    } finally {
      safeSetState(() => _isSendingAdvert = false);
    }
  }

  Future<void> _syncTime() async {
    if (_isSyncingTime) return;
    final session = ref.read(meshCoreSessionProvider);
    if (session == null || !session.isActive) {
      if (mounted) {
        showErrorSnackBar(context, context.l10n.meshcoreNotConnected);
      }
      return;
    }

    safeSetState(() => _isSyncingTime = true);
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final payload = Uint8List(4);
      payload[0] = timestamp & 0xFF;
      payload[1] = (timestamp >> 8) & 0xFF;
      payload[2] = (timestamp >> 16) & 0xFF;
      payload[3] = (timestamp >> 24) & 0xFF;

      await session.sendFrame(
        MeshCoreFrame(
          command: MeshCoreCommands.setDeviceTime,
          payload: payload,
        ),
      );
      if (mounted) {
        showSuccessSnackBar(context, context.l10n.meshcoreTimeSynchronized);
      }
    } catch (e) {
      if (mounted) {
        showErrorSnackBar(context, context.l10n.meshcoreFailedToSyncTime);
      }
    } finally {
      safeSetState(() => _isSyncingTime = false);
    }
  }

  void _refreshContacts(BuildContext context) {
    ref.read(meshCoreContactsProvider.notifier).refresh();
    showSuccessSnackBar(context, context.l10n.meshcoreRefreshingContacts);
  }

  Future<void> _confirmReboot(BuildContext context) async {
    final confirmed = await AppBottomSheet.showConfirm(
      context: context,
      title: context.l10n.meshcoreRebootDeviceTitle,
      message: context.l10n.meshcoreRebootDeviceMessage,
      confirmLabel: context.l10n.meshcoreReboot,
    );

    if (confirmed != true) return;
    if (!mounted) return;

    _rebootDevice();
  }

  Future<void> _rebootDevice() async {
    final session = ref.read(meshCoreSessionProvider);
    if (session == null || !session.isActive) {
      showErrorSnackBar(context, context.l10n.meshcoreNotConnected);
      return;
    }

    try {
      await session.sendCommand(MeshCoreCommands.reboot);
      if (mounted) {
        showSuccessSnackBar(context, context.l10n.meshcoreRebootCommandSent);
      }
    } catch (e) {
      if (mounted) {
        showErrorSnackBar(context, context.l10n.meshcoreFailedToRebootDevice);
      }
    }
  }

  void _showProtocolCapture(BuildContext context) {
    final captureState = ref.read(meshCoreCaptureSnapshotProvider);

    AppBottomSheet.show(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.meshcoreProtocolCaptureDialogTitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          Container(
            padding: const EdgeInsets.all(AppTheme.spacing16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppTheme.radius12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(
                  context.l10n.meshcoreActiveLabel,
                  captureState.isActive ? 'Yes' : 'No',
                ),
                _buildInfoRow(
                  context.l10n.meshcoreFramesLabel,
                  '${captureState.totalCount}',
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    ref
                        .read(meshCoreCaptureSnapshotProvider.notifier)
                        .refresh();
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white.withValues(alpha: 0.8),
                    side: BorderSide(
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(context.l10n.meshcoreRefresh),
                ),
              ),
              if (captureState.hasFrames) ...[
                const SizedBox(width: AppTheme.spacing12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      ref
                          .read(meshCoreCaptureSnapshotProvider.notifier)
                          .clear();
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AccentColors.orange,
                      side: const BorderSide(color: AccentColors.orange),
                    ),
                    child: Text(context.l10n.meshcoreClear),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  void _showAbout(BuildContext context) {
    AppBottomSheet.show(
      context: context,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.l10n.meshcoreAboutSocialMesh,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: context.textPrimary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing12),
          Text(
            context.l10n.meshcoreVersion(_appVersion),
            style: TextStyle(color: context.textSecondary),
          ),
          const SizedBox(height: AppTheme.spacing12),
          Text(
            context.l10n.meshcoreAboutDescription,
            textAlign: TextAlign.center,
            style: TextStyle(color: context.textSecondary),
          ),
          const SizedBox(height: AppTheme.spacing24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => Navigator.pop(context),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: context.accentColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radius12),
                ),
              ),
              child: Text(context.l10n.meshcoreClose),
            ),
          ),
        ],
      ),
    );
  }

  static String _bytesToHex(Uint8List bytes) {
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }
}
