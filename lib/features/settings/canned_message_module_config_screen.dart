// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)
import 'dart:async';
import 'package:flutter/material.dart';
import '../../core/l10n/l10n_extension.dart';
import '../../core/logging.dart';
import '../../core/safety/lifecycle_mixin.dart';
import '../../core/widgets/animations.dart';
import '../../core/widgets/glass_scaffold.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../../providers/app_providers.dart';
import '../../providers/countdown_providers.dart';
import '../../providers/splash_mesh_provider.dart';
import '../../utils/snackbar.dart';
import '../../generated/meshtastic/admin.pb.dart' as admin;
import '../../generated/meshtastic/module_config.pb.dart' as module_pb;
import '../../services/protocol/admin_target.dart';

/// Screen for configuring device-side canned message module settings
/// This is different from CannedResponsesScreen which manages local quick responses
class CannedMessageModuleConfigScreen extends ConsumerStatefulWidget {
  const CannedMessageModuleConfigScreen({super.key});

  @override
  ConsumerState<CannedMessageModuleConfigScreen> createState() =>
      _CannedMessageModuleConfigScreenState();
}

class _CannedMessageModuleConfigScreenState
    extends ConsumerState<CannedMessageModuleConfigScreen>
    with LifecycleSafeMixin {
  bool _isLoading = false;
  bool _enabled = false;
  bool _sendBell = false;
  bool _rotary1Enabled = false;
  bool _updown1Enabled = false;
  int _inputbrokerPinA = 0;
  int _inputbrokerPinB = 0;
  int _inputbrokerPinPress = 0;
  module_pb.ModuleConfig_CannedMessageConfig_InputEventChar?
  _inputbrokerEventCw;
  module_pb.ModuleConfig_CannedMessageConfig_InputEventChar?
  _inputbrokerEventCcw;
  module_pb.ModuleConfig_CannedMessageConfig_InputEventChar?
  _inputbrokerEventPress;
  int _configPreset = 0; // 0=Manual, 1=RAK Rotary Encoder, 2=CardKB
  StreamSubscription<module_pb.ModuleConfig_CannedMessageConfig>?
  _configSubscription;
  StreamSubscription<String>? _messagesSubscription;
  bool _isSaving = false;

  // Device-side canned messages (pipe-separated)
  late TextEditingController _messagesController;
  bool _messagesChanged = false;

  @override
  void initState() {
    super.initState();
    _messagesController = TextEditingController();
    _loadCurrentConfig();
  }

  @override
  void dispose() {
    _configSubscription?.cancel();
    _messagesSubscription?.cancel();
    _messagesController.dispose();
    super.dispose();
  }

  void _applyConfig(module_pb.ModuleConfig_CannedMessageConfig config) {
    safeSetState(() {
      _enabled = config.enabled;
      _sendBell = config.sendBell;
      _rotary1Enabled = config.rotary1Enabled;
      _updown1Enabled = config.updown1Enabled;
      _inputbrokerPinA = config.inputbrokerPinA;
      _inputbrokerPinB = config.inputbrokerPinB;
      _inputbrokerPinPress = config.inputbrokerPinPress;
      _inputbrokerEventCw = config.inputbrokerEventCw;
      _inputbrokerEventCcw = config.inputbrokerEventCcw;
      _inputbrokerEventPress = config.inputbrokerEventPress;
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
        final cached = protocol.currentCannedMessageConfig;
        if (cached != null) {
          _applyConfig(cached);
        }
      }

      // Only request from device if connected
      if (protocol.isConnected) {
        // Listen for config response
        _configSubscription = protocol.cannedMessageConfigStream.listen((
          config,
        ) {
          if (mounted) _applyConfig(config);
        });

        // Listen for canned messages text response
        _messagesSubscription = protocol.cannedMessageTextStream.listen((
          messages,
        ) {
          if (mounted && !_messagesChanged) {
            safeSetState(() {
              _messagesController.text = messages;
            });
          }
        });

        // Request fresh config from device
        await protocol.getModuleConfig(
          admin.AdminMessage_ModuleConfigType.CANNEDMSG_CONFIG,
          target: target,
        );

        // Request canned messages text from device
        await protocol.getCannedMessages(target: target);
      }
    } catch (e) {
      // Device may disconnect between isConnected check and getModuleConfig
      // call, causing a PlatformException from the BLE layer
      AppLogging.settings('[CannedMessage] Config load aborted: $e');
    } finally {
      safeSetState(() => _isLoading = false);
    }
  }

  Future<void> _saveConfig() async {
    safeSetState(() => _isSaving = true);
    final l10n = context.l10n;
    try {
      final protocol = ref.read(protocolServiceProvider);
      final target = AdminTarget.fromNullable(
        ref.read(remoteAdminTargetProvider),
      );

      // Determine allowInputSource based on enabled controls
      String allowInputSource = '_any';
      if (_rotary1Enabled) {
        allowInputSource = 'rotEnc1';
      } else if (_updown1Enabled) {
        allowInputSource = 'upDown1';
      }

      await protocol.setCannedMessageConfig(
        enabled: _enabled,
        sendBell: _sendBell,
        rotary1Enabled: _rotary1Enabled,
        updown1Enabled: _updown1Enabled,
        allowInputSource: allowInputSource,
        inputbrokerPinA: _inputbrokerPinA,
        inputbrokerPinB: _inputbrokerPinB,
        inputbrokerPinPress: _inputbrokerPinPress,
        inputbrokerEventCw:
            _inputbrokerEventCw ??
            module_pb.ModuleConfig_CannedMessageConfig_InputEventChar.NONE,
        inputbrokerEventCcw:
            _inputbrokerEventCcw ??
            module_pb.ModuleConfig_CannedMessageConfig_InputEventChar.NONE,
        inputbrokerEventPress:
            _inputbrokerEventPress ??
            module_pb.ModuleConfig_CannedMessageConfig_InputEventChar.NONE,
        target: target,
      );

      // Save messages separately if changed
      if (_messagesChanged && _messagesController.text.isNotEmpty) {
        await protocol.setCannedMessages(
          _messagesController.text.trim(),
          target: target,
        );
      }

      if (mounted) {
        showSuccessSnackBar(context, l10n.cannedModuleSaved);
        if (target.isLocal) {
          ref
              .read(countdownProvider.notifier)
              .startDeviceRebootCountdown(
                reason: 'canned message config saved',
              );
        }
        safeNavigatorPop();
      }
    } catch (e) {
      if (mounted) {
        showErrorSnackBar(context, l10n.cannedModuleSaveFailed(e.toString()));
      }
    } finally {
      safeSetState(() => _isSaving = false);
    }
  }

  void _applyPreset(int preset) {
    setState(() {
      _configPreset = preset;
      if (preset == 1) {
        // RAK Rotary Encoder
        _updown1Enabled = true;
        _rotary1Enabled = false;
        _inputbrokerPinA = 4;
        _inputbrokerPinB = 10;
        _inputbrokerPinPress = 9;
        _inputbrokerEventCw =
            module_pb.ModuleConfig_CannedMessageConfig_InputEventChar.DOWN;
        _inputbrokerEventCcw =
            module_pb.ModuleConfig_CannedMessageConfig_InputEventChar.UP;
        _inputbrokerEventPress =
            module_pb.ModuleConfig_CannedMessageConfig_InputEventChar.SELECT;
      } else if (preset == 2) {
        // CardKB / RAK Keypad
        _updown1Enabled = false;
        _rotary1Enabled = false;
        _inputbrokerPinA = 0;
        _inputbrokerPinB = 0;
        _inputbrokerPinPress = 0;
        _inputbrokerEventCw =
            module_pb.ModuleConfig_CannedMessageConfig_InputEventChar.NONE;
        _inputbrokerEventCcw =
            module_pb.ModuleConfig_CannedMessageConfig_InputEventChar.NONE;
        _inputbrokerEventPress =
            module_pb.ModuleConfig_CannedMessageConfig_InputEventChar.NONE;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      title: context.l10n.cannedModuleTitle,
      actions: [
        TextButton(
          onPressed: (_isLoading || _isSaving) ? null : _saveConfig,
          child: Text(
            context.l10n.cannedModuleSave,
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
                _buildOptionsSection(),
                const SizedBox(height: AppTheme.spacing24),
                _buildMessagesSection(),
                const SizedBox(height: AppTheme.spacing24),
                _buildPresetSection(),
                const SizedBox(height: AppTheme.spacing24),
                if (_configPreset == 0) ...[
                  _buildControlTypeSection(),
                  const SizedBox(height: AppTheme.spacing24),
                  _buildInputsSection(),
                  const SizedBox(height: AppTheme.spacing24),
                  _buildKeyMappingSection(),
                  const SizedBox(height: AppTheme.spacing24),
                ],
                _buildInfoCard(),
                const SizedBox(height: AppTheme.spacing32),
              ]),
            ),
          ),
      ],
    );
  }

  Widget _buildOptionsSection() {
    return Container(
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.cannedModuleSectionOptions,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: context.textTertiary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          _SettingsTile(
            icon: Icons.message,
            title: context.l10n.cannedModuleEnabled,
            subtitle: context.l10n.cannedModuleEnabledSubtitle,
            trailing: ThemedSwitch(
              value: _enabled,
              onChanged: (value) {
                HapticFeedback.selectionClick();
                setState(() => _enabled = value);
              },
            ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          _SettingsTile(
            icon: Icons.notifications,
            title: context.l10n.cannedModuleSendBell,
            subtitle: context.l10n.cannedModuleSendBellSubtitle,
            trailing: ThemedSwitch(
              value: _sendBell,
              onChanged: (value) {
                HapticFeedback.selectionClick();
                setState(() => _sendBell = value);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessagesSection() {
    return Container(
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.cannedModuleSectionDeviceMessages,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: context.textTertiary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          Row(
            children: [
              Icon(Icons.message, size: 20, color: context.accentColor),
              const SizedBox(width: AppTheme.spacing12),
              Text(
                context.l10n.cannedModuleMessages,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: context.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing12),
          TextField(
            onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
            controller: _messagesController,
            maxLines: 4,
            maxLength: 198,
            style: TextStyle(color: context.textPrimary),
            decoration: InputDecoration(
              hintText: context.l10n.cannedModuleMessagesHint,
              hintStyle: TextStyle(color: context.textTertiary),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radius8),
                borderSide: BorderSide(color: context.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radius8),
                borderSide: BorderSide(color: context.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radius8),
                borderSide: BorderSide(color: context.accentColor),
              ),
              filled: true,
              fillColor: context.surface,
              counterStyle: TextStyle(color: context.textTertiary),
              counterText: '',
            ),
            onChanged: (value) {
              setState(() => _messagesChanged = true);
            },
          ),
          const SizedBox(height: AppTheme.spacing8),
          Text(
            context.l10n.cannedModuleMessagesHelp,
            style: context.bodySmallStyle?.copyWith(
              color: context.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPresetSection() {
    final presets = [
      (
        0,
        context.l10n.cannedModulePresetManual,
        context.l10n.cannedModulePresetManualDesc,
      ),
      (
        1,
        context.l10n.cannedModulePresetRak,
        context.l10n.cannedModulePresetRakDesc,
      ),
      (
        2,
        context.l10n.cannedModulePresetM5Stack,
        context.l10n.cannedModulePresetM5StackDesc,
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.cannedModuleSectionPreset,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: context.textTertiary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          ...presets.map((item) {
            final isSelected = _configPreset == item.$1;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  _applyPreset(item.$1);
                },
                child: Container(
                  padding: const EdgeInsets.all(AppTheme.spacing12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppTheme.radius12),
                    border: Border.all(
                      color: isSelected ? context.accentColor : context.border,
                      width: isSelected ? 2 : 1,
                    ),
                    color: isSelected
                        ? context.accentColor.withAlpha(20)
                        : context.background,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        color: isSelected
                            ? context.accentColor
                            : SemanticColors.disabled,
                      ),
                      SizedBox(width: AppTheme.spacing12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.$2,
                              style: TextStyle(
                                color: context.textPrimary,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                              ),
                            ),
                            Text(
                              item.$3,
                              style: TextStyle(
                                color: context.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildControlTypeSection() {
    return Container(
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.cannedModuleSectionControlType,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: context.textTertiary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          _SettingsTile(
            icon: Icons.radio_button_checked,
            title: context.l10n.cannedModuleControlRotary,
            subtitle: context.l10n.cannedModuleControlRotaryDesc,
            trailing: ThemedSwitch(
              value: _rotary1Enabled,
              onChanged: _updown1Enabled
                  ? null
                  : (value) {
                      HapticFeedback.selectionClick();
                      setState(() => _rotary1Enabled = value);
                    },
            ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          _SettingsTile(
            icon: Icons.arrow_upward,
            title: context.l10n.cannedModuleControlUpDown,
            subtitle: context.l10n.cannedModuleControlUpDownDesc,
            trailing: ThemedSwitch(
              value: _updown1Enabled,
              onChanged: _rotary1Enabled
                  ? null
                  : (value) {
                      HapticFeedback.selectionClick();
                      setState(() => _updown1Enabled = value);
                    },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputsSection() {
    return Container(
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.cannedModuleSectionGpio,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: context.textTertiary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          _buildGpioPicker(
            context.l10n.cannedModuleGpioPinA,
            _inputbrokerPinA,
            (value) {
              setState(() => _inputbrokerPinA = value);
            },
          ),
          const SizedBox(height: AppTheme.spacing12),
          _buildGpioPicker(
            context.l10n.cannedModuleGpioPinB,
            _inputbrokerPinB,
            (value) {
              setState(() => _inputbrokerPinB = value);
            },
          ),
          const SizedBox(height: AppTheme.spacing12),
          _buildGpioPicker(
            context.l10n.cannedModuleGpioPressPin,
            _inputbrokerPinPress,
            (value) {
              setState(() => _inputbrokerPinPress = value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGpioPicker(String label, int value, Function(int) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: context.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppTheme.spacing8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: context.background,
            borderRadius: BorderRadius.circular(AppTheme.radius8),
            border: Border.all(color: context.border),
          ),
          child: DropdownButton<int>(
            value: value,
            isExpanded: true,
            underline: SizedBox(),
            dropdownColor: context.card,
            style: TextStyle(color: context.textPrimary, fontSize: 14),
            items: List.generate(49, (i) => i).map((pin) {
              return DropdownMenuItem(
                value: pin,
                child: Text(
                  pin == 0
                      ? context.l10n.cannedModuleGpioPinUnset
                      : context.l10n.cannedModuleGpioPinLabel(pin),
                ),
              );
            }).toList(),
            onChanged: (v) {
              if (v != null) {
                HapticFeedback.selectionClick();
                onChanged(v);
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildKeyMappingSection() {
    final eventChars = [
      (
        module_pb.ModuleConfig_CannedMessageConfig_InputEventChar.NONE,
        context.l10n.cannedModuleEventNone,
      ),
      (
        module_pb.ModuleConfig_CannedMessageConfig_InputEventChar.UP,
        context.l10n.cannedModuleEventUp,
      ),
      (
        module_pb.ModuleConfig_CannedMessageConfig_InputEventChar.DOWN,
        context.l10n.cannedModuleEventDown,
      ),
      (
        module_pb.ModuleConfig_CannedMessageConfig_InputEventChar.LEFT,
        context.l10n.cannedModuleEventLeft,
      ),
      (
        module_pb.ModuleConfig_CannedMessageConfig_InputEventChar.RIGHT,
        context.l10n.cannedModuleEventRight,
      ),
      (
        module_pb.ModuleConfig_CannedMessageConfig_InputEventChar.SELECT,
        context.l10n.cannedModuleEventSelect,
      ),
      (
        module_pb.ModuleConfig_CannedMessageConfig_InputEventChar.BACK,
        context.l10n.cannedModuleEventBack,
      ),
      (
        module_pb.ModuleConfig_CannedMessageConfig_InputEventChar.CANCEL,
        context.l10n.cannedModuleEventCancel,
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.cannedModuleSectionKeyMapping,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: context.textTertiary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: AppTheme.spacing16),
          _buildEventPicker(
            context.l10n.cannedModuleClockwiseEvent,
            _inputbrokerEventCw ??
                module_pb.ModuleConfig_CannedMessageConfig_InputEventChar.NONE,
            eventChars,
            (value) {
              setState(() => _inputbrokerEventCw = value);
            },
          ),
          const SizedBox(height: AppTheme.spacing12),
          _buildEventPicker(
            context.l10n.cannedModuleCounterClockwiseEvent,
            _inputbrokerEventCcw ??
                module_pb.ModuleConfig_CannedMessageConfig_InputEventChar.NONE,
            eventChars,
            (value) {
              setState(() => _inputbrokerEventCcw = value);
            },
          ),
          const SizedBox(height: AppTheme.spacing12),
          _buildEventPicker(
            context.l10n.cannedModulePressEvent,
            _inputbrokerEventPress ??
                module_pb.ModuleConfig_CannedMessageConfig_InputEventChar.NONE,
            eventChars,
            (value) {
              setState(() => _inputbrokerEventPress = value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEventPicker(
    String label,
    module_pb.ModuleConfig_CannedMessageConfig_InputEventChar value,
    List<(module_pb.ModuleConfig_CannedMessageConfig_InputEventChar, String)>
    options,
    Function(module_pb.ModuleConfig_CannedMessageConfig_InputEventChar)
    onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: context.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppTheme.spacing8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: context.background,
            borderRadius: BorderRadius.circular(AppTheme.radius8),
            border: Border.all(color: context.border),
          ),
          child:
              DropdownButton<
                module_pb.ModuleConfig_CannedMessageConfig_InputEventChar
              >(
                value: value,
                isExpanded: true,
                underline: SizedBox(),
                dropdownColor: context.card,
                style: TextStyle(color: context.textPrimary, fontSize: 14),
                items: options.map((item) {
                  return DropdownMenuItem(value: item.$1, child: Text(item.$2));
                }).toList(),
                onChanged: (v) {
                  if (v != null) {
                    HapticFeedback.selectionClick();
                    onChanged(v);
                  }
                },
              ),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: context.accentColor.withAlpha(20),
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: context.accentColor.withAlpha(50)),
      ),
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: context.accentColor, size: 20),
          SizedBox(width: AppTheme.spacing12),
          Expanded(
            child: Text(
              context.l10n.cannedModuleInfoCard,
              style: TextStyle(color: context.textSecondary, fontSize: 13),
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
