// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)
import 'dart:async';

import '../../../../../core/logging.dart';
import '../../../../../generated/meshtastic/admin.pb.dart' as admin;
import '../../../diagnostics/models/diagnostic_event.dart';
import '../diagnostic_probe.dart';

/// Generic probe that requests a Config type and waits for the
/// corresponding stream emission from ProtocolService.
class GetConfigProbe extends DiagnosticProbe {
  final admin.AdminMessage_ConfigType configType;
  final Stream<dynamic> Function(DiagnosticContext ctx) streamSelector;

  GetConfigProbe({required this.configType, required this.streamSelector});

  @override
  String get name => 'GetConfig_${configType.name}';

  @override
  Future<ProbeResult> run(DiagnosticContext ctx) async {
    final sw = Stopwatch()..start();

    try {
      final completer = Completer<dynamic>();
      final stream = streamSelector(ctx);
      final sub = stream.listen((value) {
        if (!completer.isCompleted) {
          completer.complete(value);
        }
      });

      try {
        await ctx.protocolService.getConfig(configType, target: ctx.target);

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.probe,
          probeName: name,
          notes: 'Request sent for ${configType.name}',
        );

        final result = await completer.future.timeout(ctx.timeout);

        Map<String, dynamic>? decoded;
        try {
          if (result != null) {
            // Try protobuf JSON serialization
            decoded =
                (result as dynamic).toProto3Json() as Map<String, dynamic>?;
          }
        } catch (_) {
          decoded = {'type': result.runtimeType.toString()};
        }

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.assert_,
          probeName: name,
          decoded: DecodedPayload(messageType: configType.name, json: decoded),
          notes: 'Config response received and decoded',
        );

        return ProbeResult(
          outcome: ProbeOutcome.pass,
          durationMs: sw.elapsedMilliseconds,
        );
      } on TimeoutException {
        AppLogging.adminDiag('$name timed out');
        return ProbeResult(
          outcome: ProbeOutcome.fail,
          durationMs: sw.elapsedMilliseconds,
          error: 'Timeout waiting for ${configType.name} response',
        );
      } finally {
        await sub.cancel();
      }
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

/// Generic probe that requests a ModuleConfig type and waits for
/// the corresponding stream emission from ProtocolService.
class GetModuleConfigProbe extends DiagnosticProbe {
  final admin.AdminMessage_ModuleConfigType moduleType;
  final Stream<dynamic> Function(DiagnosticContext ctx) streamSelector;

  GetModuleConfigProbe({
    required this.moduleType,
    required this.streamSelector,
  });

  @override
  String get name => 'GetModuleConfig_${moduleType.name}';

  @override
  Future<ProbeResult> run(DiagnosticContext ctx) async {
    final sw = Stopwatch()..start();

    try {
      final completer = Completer<dynamic>();
      final stream = streamSelector(ctx);
      final sub = stream.listen((value) {
        if (!completer.isCompleted) {
          completer.complete(value);
        }
      });

      try {
        await ctx.protocolService.getModuleConfig(
          moduleType,
          target: ctx.target,
        );

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.probe,
          probeName: name,
          notes: 'Request sent for ${moduleType.name}',
        );

        final result = await completer.future.timeout(ctx.timeout);

        Map<String, dynamic>? decoded;
        try {
          if (result != null) {
            decoded =
                (result as dynamic).toProto3Json() as Map<String, dynamic>?;
          }
        } catch (_) {
          decoded = {'type': result.runtimeType.toString()};
        }

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.assert_,
          probeName: name,
          decoded: DecodedPayload(messageType: moduleType.name, json: decoded),
          notes: 'Module config response received and decoded',
        );

        return ProbeResult(
          outcome: ProbeOutcome.pass,
          durationMs: sw.elapsedMilliseconds,
        );
      } on TimeoutException {
        AppLogging.adminDiag('$name timed out');
        return ProbeResult(
          outcome: ProbeOutcome.fail,
          durationMs: sw.elapsedMilliseconds,
          error: 'Timeout waiting for ${moduleType.name} response',
        );
      } finally {
        await sub.cancel();
      }
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
