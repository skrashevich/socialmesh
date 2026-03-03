// SPDX-License-Identifier: GPL-3.0-or-later
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../core/logging.dart';
import '../../core/safety/lifecycle_mixin.dart';
import '../../core/widgets/animations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme.dart';
import '../../providers/app_providers.dart';
import '../../providers/countdown_providers.dart';
import '../../providers/splash_mesh_provider.dart';
import '../../utils/snackbar.dart';
import '../../generated/meshtastic/config.pb.dart' as config_pb;
import '../../generated/meshtastic/config.pbenum.dart' as config_pbenum;
import '../../generated/meshtastic/admin.pbenum.dart' as admin_pbenum;
import '../../services/protocol/admin_target.dart';
import '../../core/widgets/loading_indicator.dart';
import '../../core/widgets/glass_scaffold.dart';

/// Screen for configuring GPS and position settings
class PositionConfigScreen extends ConsumerStatefulWidget {
  const PositionConfigScreen({super.key});

  @override
  ConsumerState<PositionConfigScreen> createState() =>
      _PositionConfigScreenState();
}

/// Discrete position broadcast intervals matching the official Meshtastic iOS
/// app (IntervalConfiguration.broadcastMedium). Minimum 1 hour to protect
/// communities with MQTT bots that block nodes broadcasting below 10 minutes.
const _kBroadcastIntervals = <int>[
  3600, // 1h
  7200, // 2h
  10800, // 3h
  14400, // 4h
  18000, // 5h
  21600, // 6h
  43200, // 12h
  64800, // 18h
  86400, // 24h
  129600, // 36h
  172800, // 48h
  259200, // 72h
  2147483647, // never
];

/// Discrete GPS update intervals matching the official iOS app.
const _kGpsUpdateIntervals = <int>[
  0, // firmware default (30s)
  30, // 30s
  60, // 1m
  120, // 2m
  300, // 5m
  600, // 10m
  900, // 15m
  1800, // 30m
  3600, // 1h
  21600, // 6h
  43200, // 12h
  86400, // 24h
  2147483647, // on boot only
];

/// Smart broadcast minimum interval options matching the iOS app.
const _kSmartMinIntervals = <int>[
  15, // 15s
  30, // 30s
  45, // 45s
  60, // 1m
  300, // 5m
  600, // 10m
  900, // 15m
  1800, // 30m
  3600, // 1h
];

class _PositionConfigScreenState extends ConsumerState<PositionConfigScreen>
    with LifecycleSafeMixin {
  bool _isLoading = false;
  bool _isSaving = false;
  config_pbenum.Config_PositionConfig_GpsMode? _gpsMode;
  bool _smartBroadcastEnabled = true;
  bool _fixedPosition = false;
  int _positionBroadcastSecs = 3600;
  int _gpsUpdateInterval = 0;
  int _smartMinimumDistance = 50;
  int _smartMinimumIntervalSecs = 30;

  // Position flags (bitmask)
  bool _includeAltitude = true;
  bool _includeAltitudeMsl = false;
  bool _includeGeoidalSeparation = false;
  bool _includeDop = false;
  bool _includeHvdop = false;
  bool _includeSatsinview = false;
  bool _includeSeqNo = false;
  bool _includeTimestamp = false;
  bool _includeHeading = false;
  bool _includeSpeed = false;

  // GPS GPIO pins
  int _rxGpio = 0;
  int _txGpio = 0;
  int _gpsEnGpio = 0;

  StreamSubscription<config_pb.Config_PositionConfig>? _configSubscription;

  // Fixed position values
  final _latController = TextEditingController();
  final _lonController = TextEditingController();
  final _altController = TextEditingController(text: '0');
  bool _isGettingLocation = false;

  @override
  void initState() {
    super.initState();
    _loadCurrentConfig();
  }

  @override
  void dispose() {
    _configSubscription?.cancel();
    _latController.dispose();
    _lonController.dispose();
    _altController.dispose();
    super.dispose();
  }

  Future<void> _useCurrentLocation() async {
    safeSetState(() => _isGettingLocation = true);
    try {
      // Check if location services are enabled
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          showActionSnackBar(
            context,
            'Location services are disabled. Enable GPS in your device settings.',
            actionLabel: 'Open Settings',
            onAction: () => Geolocator.openLocationSettings(),
            type: SnackBarType.warning,
          );
        }
        return;
      }

      // Check and request permission
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            showActionSnackBar(
              context,
              'Location permission denied. Grant location access to use this feature.',
              actionLabel: 'Open Settings',
              onAction: () => Geolocator.openAppSettings(),
              type: SnackBarType.warning,
            );
          }
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          showActionSnackBar(
            context,
            'Location permission permanently denied. Enable in your device settings.',
            actionLabel: 'Open Settings',
            onAction: () => Geolocator.openAppSettings(),
            type: SnackBarType.warning,
          );
        }
        return;
      }

      // Get the current position
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 30),
        ),
      );

      safeSetState(() {
        _latController.text = position.latitude.toStringAsFixed(6);
        _lonController.text = position.longitude.toStringAsFixed(6);
        _altController.text = position.altitude.toInt().toString();
      });
      if (mounted) {
        showSuccessSnackBar(context, 'Location updated from phone GPS');
      }
    } catch (e) {
      if (mounted) {
        showErrorSnackBar(context, 'Failed to get location: $e');
      }
    } finally {
      safeSetState(() => _isGettingLocation = false);
    }
  }

  Future<void> _loadCurrentConfig() async {
    safeSetState(() => _isLoading = true);
    try {
      final protocol = ref.read(protocolServiceProvider);
      final target = AdminTarget.fromNullable(
        ref.read(remoteAdminTargetProvider),
      );

      // Check if we already have cached config (local only)
      if (target.isLocal) {
        final cachedConfig = protocol.currentPositionConfig;
        if (cachedConfig != null) {
          _applyConfig(cachedConfig);
        }
      }

      // Only request from device if connected
      if (protocol.isConnected) {
        // Listen for config response
        _configSubscription?.cancel();
        _configSubscription = protocol.positionConfigStream.listen((config) {
          if (mounted) {
            _applyConfig(config);
          }
        });

        // Request fresh config from device
        await protocol.getConfig(
          admin_pbenum.AdminMessage_ConfigType.POSITION_CONFIG,
          target: target,
        );

        // Wait a bit for response
        await Future.delayed(const Duration(milliseconds: 500));
      }
    } catch (e) {
      // Device disconnected between isConnected check and getConfig call
      // Catches both StateError (from protocol layer) and PlatformException
      // (from BLE layer) when device disconnects during the config request
      AppLogging.protocol('Position config load aborted: $e');
    } finally {
      safeSetState(() => _isLoading = false);
    }
  }

  void _applyConfig(config_pb.Config_PositionConfig config) {
    safeSetState(() {
      _gpsMode = config.gpsMode;
      _smartBroadcastEnabled = config.positionBroadcastSmartEnabled;
      _fixedPosition = config.fixedPosition;

      // Preserve 0 from the device — it means "firmware default".
      // Snap to the nearest allowed discrete value for broadcast interval.
      _positionBroadcastSecs = _snapToNearest(
        config.positionBroadcastSecs > 0 ? config.positionBroadcastSecs : 3600,
        _kBroadcastIntervals,
      );
      _gpsUpdateInterval = _snapToNearest(
        config.gpsUpdateInterval,
        _kGpsUpdateIntervals,
      );
      _smartMinimumDistance = config.broadcastSmartMinimumDistance > 0
          ? config.broadcastSmartMinimumDistance
          : 50;
      _smartMinimumIntervalSecs = _snapToNearest(
        config.broadcastSmartMinimumIntervalSecs > 0
            ? config.broadcastSmartMinimumIntervalSecs
            : 30,
        _kSmartMinIntervals,
      );

      // Parse position flags bitmask
      final flags = config.positionFlags;
      _includeAltitude = (flags & 1) != 0;
      _includeAltitudeMsl = (flags & 2) != 0;
      _includeGeoidalSeparation = (flags & 4) != 0;
      _includeDop = (flags & 8) != 0;
      _includeHvdop = (flags & 16) != 0;
      _includeSatsinview = (flags & 32) != 0;
      _includeSeqNo = (flags & 64) != 0;
      _includeTimestamp = (flags & 128) != 0;
      _includeHeading = (flags & 256) != 0;
      _includeSpeed = (flags & 512) != 0;

      // GPS GPIO pins
      _rxGpio = config.rxGpio;
      _txGpio = config.txGpio;
      _gpsEnGpio = config.gpsEnGpio;
    });
  }

  int _buildPositionFlags() {
    int flags = 0;
    if (_includeAltitude) flags |= 1;
    if (_includeAltitudeMsl) flags |= 2;
    if (_includeGeoidalSeparation) flags |= 4;
    if (_includeDop) flags |= 8;
    if (_includeHvdop) flags |= 16;
    if (_includeSatsinview) flags |= 32;
    if (_includeSeqNo) flags |= 64;
    if (_includeTimestamp) flags |= 128;
    if (_includeHeading) flags |= 256;
    if (_includeSpeed) flags |= 512;
    return flags;
  }

  /// Snap [value] to the closest entry in [allowed]. If [allowed] is empty or
  /// [value] is already in the list, returns [value] unchanged.
  static int _snapToNearest(int value, List<int> allowed) {
    if (allowed.isEmpty) return value;
    if (allowed.contains(value)) return value;
    int best = allowed.first;
    int bestDist = (value - best).abs();
    for (final v in allowed) {
      final d = (value - v).abs();
      if (d < bestDist) {
        best = v;
        bestDist = d;
      }
    }
    return best;
  }

  bool get _isGpsEnabled =>
      _gpsMode == config_pbenum.Config_PositionConfig_GpsMode.ENABLED;

  Future<void> _saveConfig() async {
    safeSetState(() => _isSaving = true);
    try {
      final protocol = ref.read(protocolServiceProvider);
      final target = AdminTarget.fromNullable(
        ref.read(remoteAdminTargetProvider),
      );

      // Fixed position set/remove is local-only (uses localAdmin routing)
      if (target.isLocal) {
        if (_fixedPosition) {
          final lat = double.tryParse(_latController.text);
          final lon = double.tryParse(_lonController.text);
          final alt = int.tryParse(_altController.text) ?? 0;

          if (lat != null && lon != null) {
            await protocol.setFixedPosition(
              latitude: lat,
              longitude: lon,
              altitude: alt,
            );
          }
        } else {
          await protocol.removeFixedPosition();
        }
      }

      await protocol.setPositionConfig(
        positionBroadcastSecs: _positionBroadcastSecs,
        positionBroadcastSmartEnabled: _smartBroadcastEnabled,
        fixedPosition: _fixedPosition,
        gpsMode:
            _gpsMode ?? config_pbenum.Config_PositionConfig_GpsMode.ENABLED,
        gpsUpdateInterval: _gpsUpdateInterval,
        broadcastSmartMinimumDistance: _smartMinimumDistance,
        broadcastSmartMinimumIntervalSecs: _smartMinimumIntervalSecs,
        positionFlags: _buildPositionFlags(),
        rxGpio: _rxGpio,
        txGpio: _txGpio,
        gpsEnGpio: _gpsEnGpio,
        target: target,
      );

      if (mounted) {
        showSuccessSnackBar(context, 'Position configuration saved');
        if (target.isLocal) {
          ref
              .read(countdownProvider.notifier)
              .startDeviceRebootCountdown(reason: 'position config saved');
        }
        safeNavigatorPop();
      }
    } catch (e) {
      if (mounted) {
        showErrorSnackBar(context, 'Failed to save: $e');
      }
    } finally {
      safeSetState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRemote = ref.watch(remoteAdminTargetProvider) != null;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: GlassScaffold(
        title: 'Position',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton(
              onPressed: (_isLoading || _isSaving) ? null : _saveConfig,
              child: _isSaving
                  ? LoadingIndicator(size: 20)
                  : Text(
                      'Save',
                      style: TextStyle(
                        color: context.accentColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
        slivers: [
          if (_isLoading)
            const SliverFillRemaining(child: ScreenLoadingIndicator())
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              sliver: SliverList.list(
                children: [
                  const _SectionHeader(title: 'GPS MODE'),
                  _buildGpsModeSelector(),
                  SizedBox(height: AppTheme.spacing16),
                  const _SectionHeader(title: 'BROADCAST SETTINGS'),
                  _SettingsTile(
                    icon: Icons.tune,
                    iconColor: _smartBroadcastEnabled
                        ? context.accentColor
                        : null,
                    title: 'Smart Broadcast',
                    subtitle:
                        'Only broadcast when position changes significantly',
                    trailing: ThemedSwitch(
                      value: _smartBroadcastEnabled,
                      onChanged: (value) {
                        HapticFeedback.selectionClick();
                        setState(() => _smartBroadcastEnabled = value);
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 2,
                    ),
                    padding: const EdgeInsets.all(AppTheme.spacing16),
                    decoration: BoxDecoration(
                      color: context.card,
                      borderRadius: BorderRadius.circular(AppTheme.radius12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'Position Broadcast Interval',
                                style: TextStyle(
                                  color: context.textPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            _IntervalChip(
                              label: _formatDuration(_positionBroadcastSecs),
                            ),
                          ],
                        ),
                        SizedBox(height: AppTheme.spacing4),
                        Text(
                          'The maximum time between position broadcasts',
                          style: TextStyle(
                            color: context.textSecondary,
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(height: AppTheme.spacing8),
                        _DiscreteIntervalSelector(
                          value: _positionBroadcastSecs,
                          intervals: _kBroadcastIntervals,
                          formatLabel: _formatDuration,
                          onChanged: (v) =>
                              setState(() => _positionBroadcastSecs = v),
                        ),
                        if (_isGpsEnabled) ...[
                          Divider(height: 24, color: context.border),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'GPS Update Interval',
                                  style: TextStyle(
                                    color: context.textPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              _IntervalChip(
                                label: _formatGpsInterval(_gpsUpdateInterval),
                              ),
                            ],
                          ),
                          SizedBox(height: AppTheme.spacing4),
                          Text(
                            'How often the device GPS checks for position',
                            style: TextStyle(
                              color: context.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: AppTheme.spacing8),
                          _DiscreteIntervalSelector(
                            value: _gpsUpdateInterval,
                            intervals: _kGpsUpdateIntervals,
                            formatLabel: _formatGpsInterval,
                            onChanged: (v) =>
                                setState(() => _gpsUpdateInterval = v),
                          ),
                        ],
                      ],
                    ),
                  ),
                  SizedBox(height: AppTheme.spacing16),
                  // Fixed position: shown when GPS is NOT enabled or
                  // already toggled on (matches official iOS behaviour).
                  // Local-only (uses localAdmin routing).
                  if (!isRemote && (!_isGpsEnabled || _fixedPosition)) ...[
                    const _SectionHeader(title: 'FIXED POSITION'),
                    _SettingsTile(
                      icon: Icons.pin_drop,
                      iconColor: _fixedPosition ? context.accentColor : null,
                      title: 'Use Fixed Position',
                      subtitle: 'Manually set position instead of using GPS',
                      trailing: ThemedSwitch(
                        value: _fixedPosition,
                        onChanged: (value) {
                          HapticFeedback.selectionClick();
                          setState(() => _fixedPosition = value);
                        },
                      ),
                    ),
                    if (_fixedPosition) ...[
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 2,
                        ),
                        padding: const EdgeInsets.all(AppTheme.spacing16),
                        decoration: BoxDecoration(
                          color: context.card,
                          borderRadius: BorderRadius.circular(
                            AppTheme.radius12,
                          ),
                        ),
                        child: Column(
                          children: [
                            TextField(
                              maxLength: 100,
                              controller: _latController,
                              style: TextStyle(color: context.textPrimary),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: 'Latitude',
                                labelStyle: TextStyle(
                                  color: context.textSecondary,
                                ),
                                hintText: 'e.g., 37.7749',
                                hintStyle: TextStyle(
                                  color: SemanticColors.muted,
                                ),
                                filled: true,
                                fillColor: context.background,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppTheme.radius8,
                                  ),
                                  borderSide: BorderSide(color: context.border),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppTheme.radius8,
                                  ),
                                  borderSide: BorderSide(color: context.border),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppTheme.radius8,
                                  ),
                                  borderSide: BorderSide(
                                    color: context.accentColor,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.arrow_upward,
                                  color: context.textSecondary,
                                ),
                                counterText: '',
                              ),
                            ),
                            SizedBox(height: AppTheme.spacing16),
                            TextField(
                              maxLength: 100,
                              controller: _lonController,
                              style: TextStyle(color: context.textPrimary),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: 'Longitude',
                                labelStyle: TextStyle(
                                  color: context.textSecondary,
                                ),
                                hintText: 'e.g., -122.4194',
                                hintStyle: TextStyle(
                                  color: SemanticColors.muted,
                                ),
                                filled: true,
                                fillColor: context.background,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppTheme.radius8,
                                  ),
                                  borderSide: BorderSide(color: context.border),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppTheme.radius8,
                                  ),
                                  borderSide: BorderSide(color: context.border),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppTheme.radius8,
                                  ),
                                  borderSide: BorderSide(
                                    color: context.accentColor,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.arrow_forward,
                                  color: context.textSecondary,
                                ),
                                counterText: '',
                              ),
                            ),
                            SizedBox(height: AppTheme.spacing16),
                            TextField(
                              maxLength: 100,
                              controller: _altController,
                              style: TextStyle(color: context.textPrimary),
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                              onSubmitted: (_) =>
                                  FocusScope.of(context).unfocus(),
                              decoration: InputDecoration(
                                labelText: 'Altitude (meters)',
                                labelStyle: TextStyle(
                                  color: context.textSecondary,
                                ),
                                hintText: 'e.g., 100',
                                hintStyle: TextStyle(
                                  color: SemanticColors.muted,
                                ),
                                filled: true,
                                fillColor: context.background,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppTheme.radius8,
                                  ),
                                  borderSide: BorderSide(color: context.border),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppTheme.radius8,
                                  ),
                                  borderSide: BorderSide(color: context.border),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppTheme.radius8,
                                  ),
                                  borderSide: BorderSide(
                                    color: context.accentColor,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.height,
                                  color: context.textSecondary,
                                ),
                                counterText: '',
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Use Current Location Button
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: _isGettingLocation
                              ? null
                              : _useCurrentLocation,
                          icon: _isGettingLocation
                              ? SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: context.accentColor,
                                  ),
                                )
                              : Icon(
                                  Icons.my_location,
                                  color: context.accentColor,
                                ),
                          label: Text(
                            _isGettingLocation
                                ? 'Getting Location...'
                                : 'Use Current Location',
                            style: TextStyle(
                              color: context.accentColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: context.accentColor),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppTheme.radius10,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: context.accentColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(
                            AppTheme.radius12,
                          ),
                          border: Border.all(
                            color: context.accentColor.withValues(alpha: 0.3),
                          ),
                        ),
                        padding: const EdgeInsets.all(AppTheme.spacing16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: context.accentColor.withValues(alpha: 0.8),
                              size: 20,
                            ),
                            SizedBox(width: AppTheme.spacing12),
                            Expanded(
                              child: Text(
                                'Fixed position is useful for stationary installations like routers or base stations.',
                                style: TextStyle(
                                  color: context.textSecondary,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ], // end if (!isRemote)
                  SizedBox(height: AppTheme.spacing16),
                  if (_smartBroadcastEnabled) ...[
                    const _SectionHeader(title: 'SMART BROADCAST SETTINGS'),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 2,
                      ),
                      padding: const EdgeInsets.all(AppTheme.spacing16),
                      decoration: BoxDecoration(
                        color: context.card,
                        borderRadius: BorderRadius.circular(AppTheme.radius12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Minimum Distance',
                                style: TextStyle(
                                  color: context.textPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: context.accentColor.withValues(
                                    alpha: 0.15,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    AppTheme.radius6,
                                  ),
                                ),
                                child: Text(
                                  '${_smartMinimumDistance}m',
                                  style: TextStyle(
                                    color: context.accentColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppTheme.spacing4),
                          Text(
                            'Minimum distance moved before broadcasting',
                            style: TextStyle(
                              color: context.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: AppTheme.spacing8),
                          SliderTheme(
                            data: SliderThemeData(
                              inactiveTrackColor: context.border,
                              thumbColor: context.accentColor,
                              overlayColor: context.accentColor.withValues(
                                alpha: 0.2,
                              ),
                              trackHeight: 4,
                            ),
                            child: Slider(
                              value: _smartMinimumDistance.toDouble().clamp(
                                10,
                                150,
                              ),
                              min: 10,
                              max: 150,
                              divisions: 28,
                              onChanged: (value) {
                                // Round to nearest multiple of 5
                                // (iOS uses multiples of 5)
                                final rounded = (value / 5).round() * 5;
                                setState(
                                  () => _smartMinimumDistance = rounded.clamp(
                                    10,
                                    150,
                                  ),
                                );
                              },
                            ),
                          ),
                          Divider(height: 24, color: context.border),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Minimum Interval',
                                  style: TextStyle(
                                    color: context.textPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              _IntervalChip(
                                label: _formatDuration(
                                  _smartMinimumIntervalSecs,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppTheme.spacing4),
                          Text(
                            'The fastest position updates will be sent if '
                            'the minimum distance has been satisfied',
                            style: TextStyle(
                              color: context.textSecondary,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: AppTheme.spacing8),
                          _DiscreteIntervalSelector(
                            value: _smartMinimumIntervalSecs,
                            intervals: _kSmartMinIntervals,
                            formatLabel: _formatDuration,
                            onChanged: (v) =>
                                setState(() => _smartMinimumIntervalSecs = v),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppTheme.spacing16),
                  ],
                  // GPS Settings and GPIO only shown when GPS is enabled
                  // (matches official Meshtastic iOS behaviour)
                  if (_isGpsEnabled) ...[
                    const _SectionHeader(title: 'GPS GPIO'),
                    _buildGpioSettings(),
                    SizedBox(height: AppTheme.spacing16),
                  ],
                  const _SectionHeader(title: 'POSITION FLAGS'),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: Text(
                      'Optional fields to include in position messages. '
                      'More fields means larger packets, longer airtime, '
                      'and higher risk of packet loss.',
                      style: TextStyle(
                        color: context.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 2,
                    ),
                    padding: const EdgeInsets.all(AppTheme.spacing16),
                    decoration: BoxDecoration(
                      color: context.card,
                      borderRadius: BorderRadius.circular(AppTheme.radius12),
                    ),
                    child: Column(
                      children: [
                        // Position Flags section: conditional visibility
                        // matches the official iOS app structure.
                        _buildFlagToggle(
                          'Include Altitude',
                          'Include altitude in position reports',
                          _includeAltitude,
                          (v) => setState(() => _includeAltitude = v),
                        ),
                        _buildFlagToggle(
                          'Include Sats in View',
                          'Include number of satellites visible',
                          _includeSatsinview,
                          (v) => setState(() => _includeSatsinview = v),
                        ),
                        _buildFlagToggle(
                          'Include Sequence Number',
                          'Include position sequence number',
                          _includeSeqNo,
                          (v) => setState(() => _includeSeqNo = v),
                        ),
                        _buildFlagToggle(
                          'Include Timestamp',
                          'Include GPS timestamp',
                          _includeTimestamp,
                          (v) => setState(() => _includeTimestamp = v),
                        ),
                        _buildFlagToggle(
                          'Include Heading',
                          'Include heading/direction of travel',
                          _includeHeading,
                          (v) => setState(() => _includeHeading = v),
                        ),
                        _buildFlagToggle(
                          'Include Speed',
                          'Include ground speed',
                          _includeSpeed,
                          (v) => setState(() => _includeSpeed = v),
                          isLast: !_includeAltitude && !_includeDop,
                        ),
                        // Advanced flags: conditional on parent flags
                        // (iOS: MSL/Geoidal only when Altitude on)
                        if (_includeAltitude) ...[
                          _buildFlagToggle(
                            'Altitude is Mean Sea Level',
                            'Report altitude as MSL instead of HAE',
                            _includeAltitudeMsl,
                            (v) => setState(() => _includeAltitudeMsl = v),
                          ),
                          _buildFlagToggle(
                            'Include Geoidal Separation',
                            'Include geoidal separation value',
                            _includeGeoidalSeparation,
                            (v) =>
                                setState(() => _includeGeoidalSeparation = v),
                            isLast: !_includeDop,
                          ),
                        ],
                        // iOS: HVDOP only when DOP is on
                        _buildFlagToggle(
                          'Include DOP',
                          'Include dilution of precision (PDOP)',
                          _includeDop,
                          (v) => setState(() => _includeDop = v),
                          isLast: !_includeDop,
                        ),
                        if (_includeDop)
                          _buildFlagToggle(
                            'Use HDOP / VDOP',
                            'Send separate HDOP/VDOP instead of PDOP',
                            _includeHvdop,
                            (v) => setState(() => _includeHvdop = v),
                            isLast: true,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing32),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFlagToggle(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged, {
    bool isLast = false,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: context.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing2),
                  Text(
                    subtitle,
                    style: context.bodySmallStyle?.copyWith(
                      color: context.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            ThemedSwitch(
              value: value,
              onChanged: (v) {
                HapticFeedback.selectionClick();
                onChanged(v);
              },
            ),
          ],
        ),
        if (!isLast) Divider(height: 16, color: context.border),
      ],
    );
  }

  Widget _buildGpioSettings() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // RX GPIO
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'GPS RX GPIO',
                style: TextStyle(
                  color: context.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: context.background,
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                  border: Border.all(color: context.border),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButton<int>(
                  underline: const SizedBox.shrink(),
                  dropdownColor: context.card,
                  style: TextStyle(color: context.textPrimary),
                  value: _rxGpio,
                  items: List.generate(49, (i) {
                    return DropdownMenuItem(
                      value: i,
                      child: Text(i == 0 ? 'Unset' : 'Pin $i'),
                    );
                  }),
                  onChanged: (value) {
                    if (value != null) setState(() => _rxGpio = value);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing4),
          Text(
            'GPIO pin for GPS RX signal',
            style: TextStyle(color: context.textSecondary, fontSize: 13),
          ),
          Divider(height: 24, color: context.border),
          // TX GPIO
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'GPS TX GPIO',
                style: TextStyle(
                  color: context.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: context.background,
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                  border: Border.all(color: context.border),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButton<int>(
                  underline: const SizedBox.shrink(),
                  dropdownColor: context.card,
                  style: TextStyle(color: context.textPrimary),
                  value: _txGpio,
                  items: List.generate(49, (i) {
                    return DropdownMenuItem(
                      value: i,
                      child: Text(i == 0 ? 'Unset' : 'Pin $i'),
                    );
                  }),
                  onChanged: (value) {
                    if (value != null) setState(() => _txGpio = value);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing4),
          Text(
            'GPIO pin for GPS TX signal',
            style: TextStyle(color: context.textSecondary, fontSize: 13),
          ),
          Divider(height: 24, color: context.border),
          // GPS Enable GPIO
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'GPS Enable GPIO',
                style: TextStyle(
                  color: context.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: context.background,
                  borderRadius: BorderRadius.circular(AppTheme.radius8),
                  border: Border.all(color: context.border),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButton<int>(
                  underline: const SizedBox.shrink(),
                  dropdownColor: context.card,
                  style: TextStyle(color: context.textPrimary),
                  value: _gpsEnGpio,
                  items: List.generate(49, (i) {
                    return DropdownMenuItem(
                      value: i,
                      child: Text(i == 0 ? 'Unset' : 'Pin $i'),
                    );
                  }),
                  onChanged: (value) {
                    if (value != null) setState(() => _gpsEnGpio = value);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing4),
          Text(
            'GPIO pin to control GPS power',
            style: TextStyle(color: context.textSecondary, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildGpsModeSelector() {
    final modes = [
      (
        config_pbenum.Config_PositionConfig_GpsMode.ENABLED,
        'Enabled',
        'GPS is active and reports position',
        Icons.gps_fixed,
      ),
      (
        config_pbenum.Config_PositionConfig_GpsMode.DISABLED,
        'Disabled',
        'GPS hardware is present but turned off',
        Icons.gps_off,
      ),
      (
        config_pbenum.Config_PositionConfig_GpsMode.NOT_PRESENT,
        'Not Present',
        'No GPS hardware on this device',
        Icons.gps_not_fixed,
      ),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...modes.map((m) {
            final isSelected = _gpsMode == m.$1;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                onTap: () => setState(() => _gpsMode = m.$1),
                borderRadius: BorderRadius.circular(AppTheme.radius12),
                child: Container(
                  padding: const EdgeInsets.all(AppTheme.spacing12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppTheme.radius12),
                    border: Border.all(
                      color: isSelected ? context.accentColor : context.border,
                      width: isSelected ? 2 : 1,
                    ),
                    color: isSelected
                        ? context.accentColor.withValues(alpha: 0.1)
                        : null,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        m.$4,
                        color: isSelected
                            ? context.accentColor
                            : context.textSecondary,
                      ),
                      SizedBox(width: AppTheme.spacing12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              m.$2,
                              style: TextStyle(
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: isSelected
                                    ? context.accentColor
                                    : context.textPrimary,
                              ),
                            ),
                            Text(
                              m.$3,
                              style: TextStyle(
                                color: context.textSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(Icons.check_circle, color: context.accentColor),
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

  String _formatDuration(int seconds) {
    if (seconds >= 2147483647) return 'Never';
    if (seconds < 60) return '${seconds}s';
    if (seconds < 3600) return '${seconds ~/ 60}m';
    if (seconds < 86400) return '${seconds ~/ 3600}h';
    return '${seconds ~/ 86400}d';
  }

  String _formatGpsInterval(int seconds) {
    if (seconds == 0) return 'Default';
    if (seconds >= 2147483647) return 'On Boot Only';
    return _formatDuration(seconds);
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppTheme.spacing16, 8, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: context.textTertiary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String title;
  final String subtitle;
  final Widget? trailing;

  const _SettingsTile({
    required this.icon,
    this.iconColor,
    required this.title,
    required this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: iconColor ?? context.textSecondary),
            SizedBox(width: AppTheme.spacing16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: context.textPrimary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing2),
                  Text(
                    subtitle,
                    style: context.bodySmallStyle?.copyWith(
                      color: context.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

/// A horizontally-scrolling row of tappable interval chips that replaces the
/// continuous sliders. Each chip shows a formatted label. The selected chip is
/// highlighted with the accent colour.
class _DiscreteIntervalSelector extends StatelessWidget {
  final int value;
  final List<int> intervals;
  final String Function(int) formatLabel;
  final ValueChanged<int> onChanged;

  const _DiscreteIntervalSelector({
    required this.value,
    required this.intervals,
    required this.formatLabel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: intervals.map((v) {
          final selected = v == value;
          return Padding(
            padding: const EdgeInsets.only(right: 6),
            child: ChoiceChip(
              label: Text(
                formatLabel(v),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  color: selected ? Colors.white : context.textPrimary,
                ),
              ),
              selected: selected,
              showCheckmark: false,
              selectedColor: context.accentColor,
              backgroundColor: context.background,
              side: BorderSide(
                color: selected ? context.accentColor : context.border,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radius8),
              ),
              onSelected: (_) {
                HapticFeedback.selectionClick();
                onChanged(v);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

/// Small accent-coloured badge showing the currently selected interval value.
class _IntervalChip extends StatelessWidget {
  final String label;

  const _IntervalChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: context.accentColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppTheme.radius6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: context.accentColor,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }
}
