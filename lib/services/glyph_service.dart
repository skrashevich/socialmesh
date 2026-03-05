// SPDX-License-Identifier: GPL-3.0-or-later
import 'dart:io';

import 'package:flutter/widgets.dart';

import '../core/logging.dart';
import '../l10n/app_localizations.dart';
import 'glyph_matrix_service.dart';

/// Service for controlling Nothing Phone glyph interface
/// Currently only supports Nothing Phone 3 with GlyphMatrix SDK (25x25 LED matrix)
///
/// Phone 3 uses the GlyphMatrix SDK which provides a 25x25 pixel LED matrix
/// on the back of the device for visual feedback.
class GlyphService {
  static final GlyphService _instance = GlyphService._internal();
  factory GlyphService() => _instance;
  GlyphService._internal();

  final GlyphMatrixService _matrixService = GlyphMatrixService();
  bool _isSupported = false;
  bool _isInitialized = false;
  String _deviceModel = 'Unknown';

  /// Check if device supports glyph interface
  bool get isSupported => _isSupported;

  /// Check if service is initialized
  bool get isInitialized => _isInitialized;

  /// Get the detected device model
  String get deviceModel => _deviceModel;

  /// Initialize the glyph service
  /// Only Nothing Phone 3 is supported (uses GlyphMatrix SDK)
  Future<void> init() async {
    if (_isInitialized) return;

    AppLogging.automations('GlyphService: Starting initialization...');

    if (!Platform.isAndroid) {
      AppLogging.automations('GlyphService: Not Android, glyph not supported');
      _deviceModel = 'Not Android';
      _isSupported = false;
      _isInitialized = true;
      return;
    }

    // Check if this is a Phone 3
    final isPhone3 = await _matrixService.isPhone3();
    AppLogging.automations('GlyphService: Phone 3 check = $isPhone3');

    if (!isPhone3) {
      AppLogging.automations(
        'GlyphService: Not a Nothing Phone 3, glyph not supported',
      );
      _deviceModel = 'Not Nothing Phone 3';
      _isSupported = false;
      _isInitialized = true;
      return;
    }

    // Initialize GlyphMatrix for Phone 3
    final matrixInit = await _matrixService.init();
    if (matrixInit) {
      _deviceModel = 'Nothing Phone (3)';
      _isSupported = true;
      _isInitialized = true;
      AppLogging.automations(
        'GlyphService: Phone 3 initialized with GlyphMatrix SDK',
      );
    } else {
      AppLogging.automations('GlyphService: GlyphMatrix init failed');
      _deviceModel = 'Nothing Phone (3) [Init Failed]';
      _isSupported = false;
      _isInitialized = true;
    }
  }

  /// Close and cleanup the glyph service
  Future<void> close() async {
    if (!_isInitialized) return;

    try {
      await _matrixService.turnOff();
      _isInitialized = false;
      AppLogging.automations('GlyphService: Closed');
    } catch (e) {
      AppLogging.automations('GlyphService: Close failed: $e');
    }
  }

  /// Turn off all glyphs
  Future<void> turnOff() async {
    if (!_isSupported || !_isInitialized) return;
    await _matrixService.turnOff();
  }

  /// Show connection established pattern
  Future<void> showConnected() async {
    if (!_isSupported || !_isInitialized) return;
    await _matrixService.showConnected();
  }

  /// Show disconnection pattern
  Future<void> showDisconnected() async {
    if (!_isSupported || !_isInitialized) return;
    await _matrixService.showDisconnected();
  }

  /// Show message received pattern
  Future<void> showMessageReceived({bool isDM = false}) async {
    if (!_isSupported || !_isInitialized) return;
    await _matrixService.showMessageReceived();
  }

  /// Show message sent confirmation
  Future<void> showMessageSent() async {
    if (!_isSupported || !_isInitialized) return;
    await _matrixService.showPattern('pulse');
    await Future.delayed(const Duration(milliseconds: 200));
    await _matrixService.turnOff();
  }

  /// Show node online pattern
  Future<void> showNodeOnline() async {
    if (!_isSupported || !_isInitialized) return;
    await _matrixService.showNodeOnline();
  }

  /// Show node offline pattern
  Future<void> showNodeOffline() async {
    if (!_isSupported || !_isInitialized) return;
    await _matrixService.showPattern('border');
    await Future.delayed(const Duration(milliseconds: 800));
    await _matrixService.turnOff();
  }

  /// Show signal nearby pattern
  Future<void> showSignalNearby() async {
    if (!_isSupported || !_isInitialized) return;
    await _matrixService.showPattern('pulse');
    await Future.delayed(const Duration(milliseconds: 600));
    await _matrixService.turnOff();
  }

  /// Show low battery warning
  Future<void> showLowBattery() async {
    if (!_isSupported || !_isInitialized) return;
    await _matrixService.showPattern('cross');
    await Future.delayed(const Duration(milliseconds: 500));
    await _matrixService.turnOff();
  }

  /// Show automation triggered
  Future<void> showAutomationTriggered() async {
    if (!_isSupported || !_isInitialized) return;
    await _matrixService.showPattern('dots');
    await Future.delayed(const Duration(milliseconds: 400));
    await _matrixService.turnOff();
  }

  /// Show syncing pattern
  Future<void> showSyncing() async {
    if (!_isSupported || !_isInitialized) return;
    await _matrixService.showPattern('full');
    await Future.delayed(const Duration(milliseconds: 800));
    await _matrixService.turnOff();
  }

  /// Show error pattern
  Future<void> showError() async {
    if (!_isSupported || !_isInitialized) return;
    await _matrixService.showPattern('cross');
    await Future.delayed(const Duration(milliseconds: 300));
    await _matrixService.turnOff();
    await Future.delayed(const Duration(milliseconds: 100));
    await _matrixService.showPattern('cross');
    await Future.delayed(const Duration(milliseconds: 300));
    await _matrixService.turnOff();
  }

  /// Show success pattern
  Future<void> showSuccess() async {
    if (!_isSupported || !_isInitialized) return;
    await _matrixService.showPattern('full');
    await Future.delayed(const Duration(milliseconds: 600));
    await _matrixService.turnOff();
  }

  /// Show battery level progress (0-100)
  Future<void> showBatteryLevel(int percentage) async {
    if (!_isSupported || !_isInitialized) return;
    await _matrixService.showBatteryLevel(percentage);
  }

  /// Show signal strength based on RSSI
  Future<void> showSignalStrength(int rssi) async {
    if (!_isSupported || !_isInitialized) return;
    // Convert RSSI to percentage (typical range -100 to -40)
    final percentage = ((rssi + 100) / 60 * 100).clamp(0, 100).toInt();
    await _matrixService.showProgress(percentage);
    await Future.delayed(const Duration(seconds: 2));
    await _matrixService.turnOff();
  }

  /// Custom pattern with timing
  Future<void> customPattern({
    required int period,
    required int cycles,
    int? interval,
  }) async {
    if (!_isSupported || !_isInitialized) return;
    for (var i = 0; i < cycles; i++) {
      await _matrixService.showPattern('pulse');
      await Future.delayed(Duration(milliseconds: period));
      await _matrixService.turnOff();
      if (interval != null && i < cycles - 1) {
        await Future.delayed(Duration(milliseconds: interval));
      }
    }
  }

  /// Advanced multi-channel pattern (simplified for matrix - just shows full)
  Future<void> advancedPattern({required List<GlyphChannel> channels}) async {
    if (!_isSupported || !_isInitialized) return;
    await _matrixService.showPattern('full');
    await Future.delayed(const Duration(milliseconds: 500));
    await _matrixService.turnOff();
  }
}

/// Enum for glyph zones (kept for API compatibility but not used on Phone 3)
enum GlyphZone {
  a('Zone A', 'Camera'), // lint-allow: hardcoded-string
  b('Zone B', 'Diagonal Strip'), // lint-allow: hardcoded-string
  c('Zone C', 'USB-C Port'), // lint-allow: hardcoded-string
  d('Zone D', 'Lower Strip'), // lint-allow: hardcoded-string
  e('Zone E', 'Battery'); // lint-allow: hardcoded-string

  const GlyphZone(this.displayName, this.description);
  final String displayName;
  final String description;
}

/// L10n extension for [GlyphZone] — use these instead of [displayName]
/// and [description] in UI code with access to [BuildContext].
extension GlyphZoneL10n on GlyphZone {
  /// Returns the localized zone label (e.g. "Zone A").
  String localizedName(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return switch (this) {
      GlyphZone.a => l10n.glyphZoneA,
      GlyphZone.b => l10n.glyphZoneB,
      GlyphZone.c => l10n.glyphZoneC,
      GlyphZone.d => l10n.glyphZoneD,
      GlyphZone.e => l10n.glyphZoneE,
    };
  }

  /// Returns the localized zone description (e.g. "Camera").
  String localizedDescription(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return switch (this) {
      GlyphZone.a => l10n.glyphZoneDescCamera,
      GlyphZone.b => l10n.glyphZoneDescDiagonal,
      GlyphZone.c => l10n.glyphZoneDescUsbc,
      GlyphZone.d => l10n.glyphZoneDescLower,
      GlyphZone.e => l10n.glyphZoneDescBattery,
    };
  }
}

/// Configuration for a single glyph channel (kept for API compatibility)
class GlyphChannel {
  final GlyphZone zone;
  final int period;
  final int cycles;
  final int? interval;

  const GlyphChannel({
    required this.zone,
    required this.period,
    required this.cycles,
    this.interval,
  });

  GlyphChannel copyWith({
    GlyphZone? zone,
    int? period,
    int? cycles,
    int? interval,
  }) {
    return GlyphChannel(
      zone: zone ?? this.zone,
      period: period ?? this.period,
      cycles: cycles ?? this.cycles,
      interval: interval ?? this.interval,
    );
  }
}
