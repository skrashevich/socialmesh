// SPDX-License-Identifier: GPL-3.0-or-later
import 'dart:async';

import '../../../../../core/logging.dart';
import '../../../../../generated/meshtastic/admin.pb.dart' as admin;
import '../../../../../generated/meshtastic/config.pb.dart' as config_pb;
import '../../../../../generated/meshtastic/module_config.pb.dart' as module_pb;
import '../../../diagnostics/models/diagnostic_event.dart';
import '../diagnostic_probe.dart';

/// Write probe: set ringtone to existing value (no-op), then read back.
class WriteRingtoneProbe extends DiagnosticProbe {
  @override
  String get name => 'WriteRingtone_NoOp';

  @override
  bool get requiresWrite => true;

  @override
  Future<ProbeResult> run(DiagnosticContext ctx) async {
    final sw = Stopwatch()..start();

    try {
      // Step 1: Read current ringtone
      final readCompleter = Completer<String>();
      var readSub = ctx.protocolService.ringtoneTextStream.listen((text) {
        if (!readCompleter.isCompleted) readCompleter.complete(text);
      });

      await ctx.protocolService.getRingtone(target: ctx.target);
      final currentRingtone = await readCompleter.future.timeout(ctx.timeout);
      await readSub.cancel();

      ctx.capture.recordInternal(
        phase: DiagnosticPhase.probe,
        probeName: name,
        notes: 'Read current ringtone (${currentRingtone.length} chars)',
      );

      // Step 2: Write same value back (no-op)
      await ctx.protocolService.setRingtone(
        currentRingtone,
        target: ctx.target,
      );

      ctx.capture.recordInternal(
        phase: DiagnosticPhase.probe,
        probeName: name,
        notes: 'Wrote same ringtone back (no-op)',
      );

      // Step 3: Read back and verify
      final verifyCompleter = Completer<String>();
      readSub = ctx.protocolService.ringtoneTextStream.listen((text) {
        if (!verifyCompleter.isCompleted) verifyCompleter.complete(text);
      });

      await ctx.protocolService.getRingtone(target: ctx.target);
      final verifiedRingtone = await verifyCompleter.future.timeout(
        ctx.timeout,
      );
      await readSub.cancel();

      if (verifiedRingtone == currentRingtone) {
        ctx.capture.recordInternal(
          phase: DiagnosticPhase.assert_,
          probeName: name,
          notes: 'Write-readback verified: ringtone matches',
        );

        return ProbeResult(
          outcome: ProbeOutcome.pass,
          durationMs: sw.elapsedMilliseconds,
        );
      } else {
        return ProbeResult(
          outcome: ProbeOutcome.fail,
          durationMs: sw.elapsedMilliseconds,
          error:
              'Readback mismatch: expected ${currentRingtone.length} chars, '
              'got ${verifiedRingtone.length} chars',
        );
      }
    } on TimeoutException {
      return ProbeResult(
        outcome: ProbeOutcome.fail,
        durationMs: sw.elapsedMilliseconds,
        error: 'Timeout during write-readback cycle',
      );
    } catch (e) {
      AppLogging.adminDiag('$name error: $e');
      return ProbeResult(
        outcome: ProbeOutcome.fail,
        durationMs: sw.elapsedMilliseconds,
        error: e.toString(),
      );
    }
  }
}

/// Write probe: set canned messages to existing value (no-op), then read back.
class WriteCannedMessagesProbe extends DiagnosticProbe {
  @override
  String get name => 'WriteCannedMessages_NoOp';

  @override
  bool get requiresWrite => true;

  @override
  Future<ProbeResult> run(DiagnosticContext ctx) async {
    final sw = Stopwatch()..start();

    try {
      // Step 1: Read current canned messages
      final readCompleter = Completer<String>();
      var readSub = ctx.protocolService.cannedMessageTextStream.listen((text) {
        if (!readCompleter.isCompleted) readCompleter.complete(text);
      });

      await ctx.protocolService.getCannedMessages(target: ctx.target);
      final currentMessages = await readCompleter.future.timeout(ctx.timeout);
      await readSub.cancel();

      ctx.capture.recordInternal(
        phase: DiagnosticPhase.probe,
        probeName: name,
        notes: 'Read current canned messages (${currentMessages.length} chars)',
      );

      // Step 2: Write same value back (no-op)
      await ctx.protocolService.setCannedMessages(
        currentMessages,
        target: ctx.target,
      );

      ctx.capture.recordInternal(
        phase: DiagnosticPhase.probe,
        probeName: name,
        notes: 'Wrote same canned messages back (no-op)',
      );

      // Step 3: Read back and verify
      final verifyCompleter = Completer<String>();
      readSub = ctx.protocolService.cannedMessageTextStream.listen((text) {
        if (!verifyCompleter.isCompleted) verifyCompleter.complete(text);
      });

      await ctx.protocolService.getCannedMessages(target: ctx.target);
      final verifiedMessages = await verifyCompleter.future.timeout(
        ctx.timeout,
      );
      await readSub.cancel();

      if (verifiedMessages == currentMessages) {
        ctx.capture.recordInternal(
          phase: DiagnosticPhase.assert_,
          probeName: name,
          notes: 'Write-readback verified: canned messages match',
        );

        return ProbeResult(
          outcome: ProbeOutcome.pass,
          durationMs: sw.elapsedMilliseconds,
        );
      } else {
        return ProbeResult(
          outcome: ProbeOutcome.fail,
          durationMs: sw.elapsedMilliseconds,
          error:
              'Readback mismatch: expected ${currentMessages.length} chars, '
              'got ${verifiedMessages.length} chars',
        );
      }
    } on TimeoutException {
      return ProbeResult(
        outcome: ProbeOutcome.fail,
        durationMs: sw.elapsedMilliseconds,
        error: 'Timeout during write-readback cycle',
      );
    } catch (e) {
      AppLogging.adminDiag('$name error: $e');
      return ProbeResult(
        outcome: ProbeOutcome.fail,
        durationMs: sw.elapsedMilliseconds,
        error: e.toString(),
      );
    }
  }
}

/// Generic write probe for device configs (DeviceConfig, LoRaConfig, etc.).
///
/// Pattern: read current → write same value back (no-op) → read back
/// and verify the round-trip preserves the config.
///
/// The outer timeout is extended to 20 s because the probe performs
/// three sequential BLE round-trips (read + write + read-back).
class WriteConfigProbe extends DiagnosticProbe {
  final admin.AdminMessage_ConfigType configType;
  final Stream<dynamic> Function(DiagnosticContext ctx) streamSelector;
  final config_pb.Config Function(dynamic value) wrapInConfig;

  WriteConfigProbe({
    required this.configType,
    required this.streamSelector,
    required this.wrapInConfig,
  });

  @override
  String get name => 'WriteConfig_${configType.name}';

  @override
  bool get requiresWrite => true;

  @override
  Duration? get maxDuration => const Duration(seconds: 20);

  @override
  Future<ProbeResult> run(DiagnosticContext ctx) async {
    final sw = Stopwatch()..start();

    try {
      // Step 1: Read current config value
      final readCompleter = Completer<dynamic>();
      var sub = streamSelector(ctx).listen((value) {
        if (!readCompleter.isCompleted) readCompleter.complete(value);
      });

      await ctx.protocolService.getConfig(configType, target: ctx.target);
      final original = await readCompleter.future.timeout(ctx.timeout);
      await sub.cancel();

      ctx.capture.recordInternal(
        phase: DiagnosticPhase.probe,
        probeName: name,
        notes: 'Read current ${configType.name}',
      );

      // Step 2: Write same value back (no-op — device should not reboot)
      final wrappedConfig = wrapInConfig(original);
      await ctx.protocolService.setConfig(wrappedConfig, target: ctx.target);

      ctx.capture.recordInternal(
        phase: DiagnosticPhase.probe,
        probeName: name,
        notes: 'Wrote same ${configType.name} back (no-op)',
      );

      // Step 3: Read back and verify
      final verifyCompleter = Completer<dynamic>();
      sub = streamSelector(ctx).listen((value) {
        if (!verifyCompleter.isCompleted) verifyCompleter.complete(value);
      });

      await ctx.protocolService.getConfig(configType, target: ctx.target);
      final readback = await verifyCompleter.future.timeout(ctx.timeout);
      await sub.cancel();

      if (original == readback) {
        ctx.capture.recordInternal(
          phase: DiagnosticPhase.assert_,
          probeName: name,
          notes: 'Write-readback verified: ${configType.name} matches',
        );

        return ProbeResult(
          outcome: ProbeOutcome.pass,
          durationMs: sw.elapsedMilliseconds,
        );
      } else {
        return ProbeResult(
          outcome: ProbeOutcome.fail,
          durationMs: sw.elapsedMilliseconds,
          error: 'Readback mismatch for ${configType.name}',
        );
      }
    } on TimeoutException {
      return ProbeResult(
        outcome: ProbeOutcome.fail,
        durationMs: sw.elapsedMilliseconds,
        error: 'Timeout during write-readback cycle for ${configType.name}',
      );
    } catch (e) {
      AppLogging.adminDiag('$name error: $e');
      return ProbeResult(
        outcome: ProbeOutcome.fail,
        durationMs: sw.elapsedMilliseconds,
        error: e.toString(),
      );
    }
  }
}

/// Generic write probe for module configs (MQTT, Telemetry, Serial, etc.).
///
/// Pattern: read current → write same value back (no-op) → read back
/// and verify the round-trip preserves the module config.
///
/// The outer timeout is extended to 20 s because the probe performs
/// three sequential BLE round-trips (read + write + read-back).
class WriteModuleConfigProbe extends DiagnosticProbe {
  final admin.AdminMessage_ModuleConfigType moduleType;
  final Stream<dynamic> Function(DiagnosticContext ctx) streamSelector;
  final module_pb.ModuleConfig Function(dynamic value) wrapInModuleConfig;

  WriteModuleConfigProbe({
    required this.moduleType,
    required this.streamSelector,
    required this.wrapInModuleConfig,
  });

  @override
  String get name => 'WriteModuleConfig_${moduleType.name}';

  @override
  bool get requiresWrite => true;

  @override
  Duration? get maxDuration => const Duration(seconds: 20);

  @override
  Future<ProbeResult> run(DiagnosticContext ctx) async {
    final sw = Stopwatch()..start();

    try {
      // Step 1: Read current module config value
      final readCompleter = Completer<dynamic>();
      var sub = streamSelector(ctx).listen((value) {
        if (!readCompleter.isCompleted) readCompleter.complete(value);
      });

      await ctx.protocolService.getModuleConfig(moduleType, target: ctx.target);
      final original = await readCompleter.future.timeout(ctx.timeout);
      await sub.cancel();

      ctx.capture.recordInternal(
        phase: DiagnosticPhase.probe,
        probeName: name,
        notes: 'Read current ${moduleType.name}',
      );

      // Step 2: Write same value back (no-op — device should not reboot)
      final wrappedConfig = wrapInModuleConfig(original);
      await ctx.protocolService.setModuleConfig(
        wrappedConfig,
        target: ctx.target,
      );

      ctx.capture.recordInternal(
        phase: DiagnosticPhase.probe,
        probeName: name,
        notes: 'Wrote same ${moduleType.name} back (no-op)',
      );

      // Step 3: Read back and verify
      final verifyCompleter = Completer<dynamic>();
      sub = streamSelector(ctx).listen((value) {
        if (!verifyCompleter.isCompleted) verifyCompleter.complete(value);
      });

      await ctx.protocolService.getModuleConfig(moduleType, target: ctx.target);
      final readback = await verifyCompleter.future.timeout(ctx.timeout);
      await sub.cancel();

      if (original == readback) {
        ctx.capture.recordInternal(
          phase: DiagnosticPhase.assert_,
          probeName: name,
          notes: 'Write-readback verified: ${moduleType.name} matches',
        );

        return ProbeResult(
          outcome: ProbeOutcome.pass,
          durationMs: sw.elapsedMilliseconds,
        );
      } else {
        return ProbeResult(
          outcome: ProbeOutcome.fail,
          durationMs: sw.elapsedMilliseconds,
          error: 'Readback mismatch for ${moduleType.name}',
        );
      }
    } on TimeoutException {
      return ProbeResult(
        outcome: ProbeOutcome.fail,
        durationMs: sw.elapsedMilliseconds,
        error: 'Timeout during write-readback cycle for ${moduleType.name}',
      );
    } catch (e) {
      AppLogging.adminDiag('$name error: $e');
      return ProbeResult(
        outcome: ProbeOutcome.fail,
        durationMs: sw.elapsedMilliseconds,
        error: e.toString(),
      );
    }
  }
}
