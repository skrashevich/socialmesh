// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/l10n/l10n_extension.dart';
import '../../core/logging.dart';
import '../../core/safety/lifecycle_mixin.dart';
import '../../core/theme.dart';
import '../../core/widgets/animations.dart';
import '../../core/widgets/glass_scaffold.dart';
import '../../providers/app_providers.dart';
import '../../providers/countdown_providers.dart';
import '../../providers/splash_mesh_provider.dart';
import '../../utils/snackbar.dart';
import '../../generated/meshtastic/module_config.pb.dart' as module_pb;
import '../../generated/meshtastic/admin.pbenum.dart' as admin_pbenum;
import '../../services/protocol/admin_target.dart';

/// Screen for configuring traffic management module settings (v2.7.19)
class TrafficManagementConfigScreen extends ConsumerStatefulWidget {
  const TrafficManagementConfigScreen({super.key});

  @override
  ConsumerState<TrafficManagementConfigScreen> createState() =>
      _TrafficManagementConfigScreenState();
}

class _TrafficManagementConfigScreenState
    extends ConsumerState<TrafficManagementConfigScreen>
    with LifecycleSafeMixin {
  bool _isLoading = false;
  bool _isSaving = false;

  // Master toggle
  bool _enabled = false;

  // Position deduplication
  bool _positionDedupEnabled = false;
  int _positionPrecisionBits = 16;
  int _positionMinIntervalSecs = 60;

  // NodeInfo direct response
  bool _nodeinfoDirectResponse = false;
  int _nodeinfoDirectResponseMaxHops = 3;

  // Rate limiting
  bool _rateLimitEnabled = false;
  int _rateLimitWindowSecs = 60;
  int _rateLimitMaxPackets = 10;

  // Unknown packet handling
  bool _dropUnknownEnabled = false;
  int _unknownPacketThreshold = 5;

  // Hop management
  bool _exhaustHopTelemetry = false;
  bool _exhaustHopPosition = false;
  bool _routerPreserveHops = false;

  StreamSubscription<module_pb.ModuleConfig_TrafficManagementConfig>?
  _configSubscription;

  @override
  void initState() {
    super.initState();
    _loadCurrentConfig();
  }

  @override
  void dispose() {
    _configSubscription?.cancel();
    super.dispose();
  }

  void _applyConfig(module_pb.ModuleConfig_TrafficManagementConfig config) {
    safeSetState(() {
      _enabled = config.enabled;
      _positionDedupEnabled = config.positionDedupEnabled;
      _positionPrecisionBits = config.positionPrecisionBits > 0
          ? config.positionPrecisionBits
          : 16;
      _positionMinIntervalSecs = config.positionMinIntervalSecs > 0
          ? config.positionMinIntervalSecs
          : 60;
      _nodeinfoDirectResponse = config.nodeinfoDirectResponse;
      _nodeinfoDirectResponseMaxHops = config.nodeinfoDirectResponseMaxHops > 0
          ? config.nodeinfoDirectResponseMaxHops
          : 3;
      _rateLimitEnabled = config.rateLimitEnabled;
      _rateLimitWindowSecs = config.rateLimitWindowSecs > 0
          ? config.rateLimitWindowSecs
          : 60;
      _rateLimitMaxPackets = config.rateLimitMaxPackets > 0
          ? config.rateLimitMaxPackets
          : 10;
      _dropUnknownEnabled = config.dropUnknownEnabled;
      _unknownPacketThreshold = config.unknownPacketThreshold > 0
          ? config.unknownPacketThreshold
          : 5;
      _exhaustHopTelemetry = config.exhaustHopTelemetry;
      _exhaustHopPosition = config.exhaustHopPosition;
      _routerPreserveHops = config.routerPreserveHops;
    });
  }

  Future<void> _loadCurrentConfig() async {
    safeSetState(() => _isLoading = true);
    try {
      final protocol = ref.read(protocolServiceProvider);
      final target = AdminTarget.fromNullable(
        ref.read(remoteAdminTargetProvider),
      );

      // Apply cached config immediately if available (local only)
      if (target.isLocal) {
        final cached = protocol.currentTrafficManagementConfig;
        if (cached != null) {
          _applyConfig(cached);
        }
      }

      // Only request from device if connected
      if (protocol.isConnected) {
        _configSubscription = protocol.trafficManagementConfigStream.listen((
          config,
        ) {
          if (mounted) _applyConfig(config);
        });

        await protocol.getModuleConfig(
          admin_pbenum.AdminMessage_ModuleConfigType.TRAFFICMANAGEMENT_CONFIG,
          target: target,
        );
      }
    } catch (e) {
      AppLogging.protocol('Traffic management config load aborted: $e');
    } finally {
      safeSetState(() => _isLoading = false);
    }
  }

  Future<void> _saveConfig() async {
    final l10n = context.l10n;
    safeSetState(() => _isSaving = true);
    try {
      final protocol = ref.read(protocolServiceProvider);
      final target = AdminTarget.fromNullable(
        ref.read(remoteAdminTargetProvider),
      );
      await protocol.setTrafficManagementConfig(
        enabled: _enabled,
        positionDedupEnabled: _positionDedupEnabled,
        positionPrecisionBits: _positionPrecisionBits,
        positionMinIntervalSecs: _positionMinIntervalSecs,
        nodeinfoDirectResponse: _nodeinfoDirectResponse,
        nodeinfoDirectResponseMaxHops: _nodeinfoDirectResponseMaxHops,
        rateLimitEnabled: _rateLimitEnabled,
        rateLimitWindowSecs: _rateLimitWindowSecs,
        rateLimitMaxPackets: _rateLimitMaxPackets,
        dropUnknownEnabled: _dropUnknownEnabled,
        unknownPacketThreshold: _unknownPacketThreshold,
        exhaustHopTelemetry: _exhaustHopTelemetry,
        exhaustHopPosition: _exhaustHopPosition,
        routerPreserveHops: _routerPreserveHops,
        target: target,
      );

      if (mounted) {
        showSuccessSnackBar(context, l10n.trafficMgmtSaved);
        if (target.isLocal) {
          ref
              .read(countdownProvider.notifier)
              .startDeviceRebootCountdown(
                reason: 'traffic management config saved',
              );
        }
        safeNavigatorPop();
      }
    } catch (e) {
      if (mounted) {
        showErrorSnackBar(context, l10n.trafficMgmtSaveFailed(e.toString()));
      }
    } finally {
      safeSetState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      title: context.l10n.trafficMgmtTitle,
      actions: [
        TextButton(
          onPressed: (_isLoading || _isSaving) ? null : _saveConfig,
          child: Text(
            context.l10n.trafficMgmtSave,
            style: TextStyle(
              color: (_isLoading || _isSaving)
                  ? SemanticColors.disabled
                  : context.accentColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
      slivers: [
        if (_isLoading)
          const SliverFillRemaining(child: ScreenLoadingIndicator())
        else
          SliverPadding(
            padding: const EdgeInsets.all(AppTheme.spacing16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _SectionHeader(title: context.l10n.trafficMgmtSectionGeneral),
                const SizedBox(height: AppTheme.spacing8),
                _buildGeneralSection(),
                const SizedBox(height: AppTheme.spacing24),
                _SectionHeader(
                  title: context.l10n.trafficMgmtSectionPositionDedup,
                ),
                const SizedBox(height: AppTheme.spacing8),
                _buildPositionDedupSection(),
                const SizedBox(height: AppTheme.spacing24),
                _SectionHeader(
                  title: context.l10n.trafficMgmtSectionNodeinfoResponse,
                ),
                const SizedBox(height: AppTheme.spacing8),
                _buildNodeinfoSection(),
                const SizedBox(height: AppTheme.spacing24),
                _SectionHeader(title: context.l10n.trafficMgmtSectionRateLimit),
                const SizedBox(height: AppTheme.spacing8),
                _buildRateLimitSection(),
                const SizedBox(height: AppTheme.spacing24),
                _SectionHeader(
                  title: context.l10n.trafficMgmtSectionUnknownPackets,
                ),
                const SizedBox(height: AppTheme.spacing8),
                _buildUnknownPacketsSection(),
                const SizedBox(height: AppTheme.spacing24),
                _SectionHeader(title: context.l10n.trafficMgmtSectionHopMgmt),
                const SizedBox(height: AppTheme.spacing8),
                _buildHopManagementSection(),
                const SizedBox(height: AppTheme.spacing32),
              ]),
            ),
          ),
      ],
    );
  }

  Widget _buildGeneralSection() {
    return Container(
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: _SettingsTile(
        icon: Icons.traffic,
        title: context.l10n.trafficMgmtEnable,
        subtitle: context.l10n.trafficMgmtEnableSubtitle,
        trailing: ThemedSwitch(
          value: _enabled,
          onChanged: (value) {
            HapticFeedback.selectionClick();
            setState(() => _enabled = value);
          },
        ),
      ),
    );
  }

  Widget _buildPositionDedupSection() {
    return Container(
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SettingsTile(
            icon: Icons.filter_alt,
            title: context.l10n.trafficMgmtPositionDedup,
            subtitle: context.l10n.trafficMgmtPositionDedupSubtitle,
            trailing: ThemedSwitch(
              value: _positionDedupEnabled,
              onChanged: _enabled
                  ? (value) {
                      HapticFeedback.selectionClick();
                      setState(() => _positionDedupEnabled = value);
                    }
                  : null,
            ),
          ),
          if (_positionDedupEnabled && _enabled) ...[
            const SizedBox(height: AppTheme.spacing16),
            Divider(color: context.border),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              context.l10n.trafficMgmtPrecisionBits(_positionPrecisionBits),
              style: TextStyle(
                color: context.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppTheme.spacing4),
            Text(
              context.l10n.trafficMgmtPrecisionBitsDesc,
              style: TextStyle(color: context.textSecondary, fontSize: 12),
            ),
            SliderTheme(
              data: SliderThemeData(
                inactiveTrackColor: SemanticColors.divider,
                thumbColor: context.accentColor,
                overlayColor: context.accentColor.withAlpha(30),
              ),
              child: Slider(
                value: _positionPrecisionBits.toDouble(),
                min: 0,
                max: 32,
                divisions: 32,
                label: context.l10n.trafficMgmtPrecisionBitsLabel(
                  _positionPrecisionBits,
                ),
                onChanged: (value) {
                  setState(() => _positionPrecisionBits = value.toInt());
                },
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              context.l10n.trafficMgmtMinInterval(_positionMinIntervalSecs),
              style: TextStyle(
                color: context.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppTheme.spacing4),
            Text(
              context.l10n.trafficMgmtMinIntervalDesc,
              style: TextStyle(color: context.textSecondary, fontSize: 12),
            ),
            SliderTheme(
              data: SliderThemeData(
                inactiveTrackColor: SemanticColors.divider,
                thumbColor: context.accentColor,
                overlayColor: context.accentColor.withAlpha(30),
              ),
              child: Slider(
                value: _positionMinIntervalSecs.toDouble(),
                min: 10,
                max: 600,
                divisions: 59,
                label:
                    '${_positionMinIntervalSecs}s', // lint-allow: hardcoded-string
                onChanged: (value) {
                  setState(() => _positionMinIntervalSecs = value.toInt());
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNodeinfoSection() {
    return Container(
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SettingsTile(
            icon: Icons.info_outline,
            title: context.l10n.trafficMgmtDirectResponse,
            subtitle: context.l10n.trafficMgmtDirectResponseSubtitle,
            trailing: ThemedSwitch(
              value: _nodeinfoDirectResponse,
              onChanged: _enabled
                  ? (value) {
                      HapticFeedback.selectionClick();
                      setState(() => _nodeinfoDirectResponse = value);
                    }
                  : null,
            ),
          ),
          if (_nodeinfoDirectResponse && _enabled) ...[
            const SizedBox(height: AppTheme.spacing16),
            Divider(color: context.border),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              context.l10n.trafficMgmtMaxHops(_nodeinfoDirectResponseMaxHops),
              style: TextStyle(
                color: context.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppTheme.spacing4),
            Text(
              context.l10n.trafficMgmtMaxHopsDesc,
              style: TextStyle(color: context.textSecondary, fontSize: 12),
            ),
            SliderTheme(
              data: SliderThemeData(
                inactiveTrackColor: SemanticColors.divider,
                thumbColor: context.accentColor,
                overlayColor: context.accentColor.withAlpha(30),
              ),
              child: Slider(
                value: _nodeinfoDirectResponseMaxHops.toDouble(),
                min: 0,
                max: 7,
                divisions: 7,
                label:
                    '$_nodeinfoDirectResponseMaxHops', // lint-allow: hardcoded-string
                onChanged: (value) {
                  setState(
                    () => _nodeinfoDirectResponseMaxHops = value.toInt(),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildRateLimitSection() {
    return Container(
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SettingsTile(
            icon: Icons.speed,
            title: context.l10n.trafficMgmtPerNodeRateLimit,
            subtitle: context.l10n.trafficMgmtPerNodeRateLimitSubtitle,
            trailing: ThemedSwitch(
              value: _rateLimitEnabled,
              onChanged: _enabled
                  ? (value) {
                      HapticFeedback.selectionClick();
                      setState(() => _rateLimitEnabled = value);
                    }
                  : null,
            ),
          ),
          if (_rateLimitEnabled && _enabled) ...[
            const SizedBox(height: AppTheme.spacing16),
            Divider(color: context.border),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              context.l10n.trafficMgmtWindow(_rateLimitWindowSecs),
              style: TextStyle(
                color: context.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppTheme.spacing4),
            Text(
              context.l10n.trafficMgmtWindowDesc,
              style: TextStyle(color: context.textSecondary, fontSize: 12),
            ),
            SliderTheme(
              data: SliderThemeData(
                inactiveTrackColor: SemanticColors.divider,
                thumbColor: context.accentColor,
                overlayColor: context.accentColor.withAlpha(30),
              ),
              child: Slider(
                value: _rateLimitWindowSecs.toDouble(),
                min: 10,
                max: 300,
                divisions: 29,
                label:
                    '${_rateLimitWindowSecs}s', // lint-allow: hardcoded-string
                onChanged: (value) {
                  setState(() => _rateLimitWindowSecs = value.toInt());
                },
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              context.l10n.trafficMgmtMaxPackets(_rateLimitMaxPackets),
              style: TextStyle(
                color: context.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppTheme.spacing4),
            Text(
              context.l10n.trafficMgmtMaxPacketsDesc,
              style: TextStyle(color: context.textSecondary, fontSize: 12),
            ),
            SliderTheme(
              data: SliderThemeData(
                inactiveTrackColor: SemanticColors.divider,
                thumbColor: context.accentColor,
                overlayColor: context.accentColor.withAlpha(30),
              ),
              child: Slider(
                value: _rateLimitMaxPackets.toDouble(),
                min: 1,
                max: 50,
                divisions: 49,
                label: '$_rateLimitMaxPackets', // lint-allow: hardcoded-string
                onChanged: (value) {
                  setState(() => _rateLimitMaxPackets = value.toInt());
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildUnknownPacketsSection() {
    return Container(
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SettingsTile(
            icon: Icons.help_outline,
            title: context.l10n.trafficMgmtDropUnknown,
            subtitle: context.l10n.trafficMgmtDropUnknownSubtitle,
            trailing: ThemedSwitch(
              value: _dropUnknownEnabled,
              onChanged: _enabled
                  ? (value) {
                      HapticFeedback.selectionClick();
                      setState(() => _dropUnknownEnabled = value);
                    }
                  : null,
            ),
          ),
          if (_dropUnknownEnabled && _enabled) ...[
            const SizedBox(height: AppTheme.spacing16),
            Divider(color: context.border),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              context.l10n.trafficMgmtThreshold(_unknownPacketThreshold),
              style: TextStyle(
                color: context.textPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: AppTheme.spacing4),
            Text(
              context.l10n.trafficMgmtThresholdDesc,
              style: TextStyle(color: context.textSecondary, fontSize: 12),
            ),
            SliderTheme(
              data: SliderThemeData(
                inactiveTrackColor: SemanticColors.divider,
                thumbColor: context.accentColor,
                overlayColor: context.accentColor.withAlpha(30),
              ),
              child: Slider(
                value: _unknownPacketThreshold.toDouble(),
                min: 1,
                max: 20,
                divisions: 19,
                label:
                    '$_unknownPacketThreshold', // lint-allow: hardcoded-string
                onChanged: (value) {
                  setState(() => _unknownPacketThreshold = value.toInt());
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHopManagementSection() {
    return Container(
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SettingsTile(
            icon: Icons.compress,
            title: context.l10n.trafficMgmtExhaustHopTelemetry,
            subtitle: context.l10n.trafficMgmtExhaustHopTelemetrySub,
            trailing: ThemedSwitch(
              value: _exhaustHopTelemetry,
              onChanged: _enabled
                  ? (value) {
                      HapticFeedback.selectionClick();
                      setState(() => _exhaustHopTelemetry = value);
                    }
                  : null,
            ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          _SettingsTile(
            icon: Icons.compress,
            title: context.l10n.trafficMgmtExhaustHopPosition,
            subtitle: context.l10n.trafficMgmtExhaustHopPositionSub,
            trailing: ThemedSwitch(
              value: _exhaustHopPosition,
              onChanged: _enabled
                  ? (value) {
                      HapticFeedback.selectionClick();
                      setState(() => _exhaustHopPosition = value);
                    }
                  : null,
            ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          _SettingsTile(
            icon: Icons.route,
            title: context.l10n.trafficMgmtPreserveRouterHops,
            subtitle: context.l10n.trafficMgmtPreserveRouterHopsSub,
            trailing: ThemedSwitch(
              value: _routerPreserveHops,
              onChanged: _enabled
                  ? (value) {
                      HapticFeedback.selectionClick();
                      setState(() => _routerPreserveHops = value);
                    }
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: context.textSecondary, size: 22),
        SizedBox(width: AppTheme.spacing12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: context.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: TextStyle(color: context.textSecondary, fontSize: 12),
                ),
            ],
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        title,
        style: TextStyle(
          color: context.textTertiary,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
