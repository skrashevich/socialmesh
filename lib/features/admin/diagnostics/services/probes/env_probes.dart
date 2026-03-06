// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)
import 'dart:async';

import '../../../../../core/logging.dart';
import '../../../diagnostics/models/diagnostic_event.dart';
import '../diagnostic_probe.dart';

/// Probe: validate myNodeNum is set and non-zero.
class GetMyNodeInfoProbe extends DiagnosticProbe {
  @override
  String get name => 'GetMyNodeInfo';

  @override
  Future<ProbeResult> run(DiagnosticContext ctx) async {
    final sw = Stopwatch()..start();

    try {
      if (ctx.myNodeNum == 0) {
        return ProbeResult(
          outcome: ProbeOutcome.fail,
          durationMs: sw.elapsedMilliseconds,
          error: 'myNodeNum is 0 — device did not provide node info',
        );
      }

      ctx.capture.recordInternal(
        phase: DiagnosticPhase.assert_,
        probeName: name,
        notes: 'myNodeNum=0x${ctx.myNodeNum.toRadixString(16)} validated',
      );

      return ProbeResult(
        outcome: ProbeOutcome.pass,
        durationMs: sw.elapsedMilliseconds,
      );
    } catch (e) {
      return ProbeResult(
        outcome: ProbeOutcome.fail,
        durationMs: sw.elapsedMilliseconds,
        error: e.toString(),
      );
    }
  }
}

/// Probe: request device metadata and validate firmware/hardware info.
class GetDeviceMetadataProbe extends DiagnosticProbe {
  @override
  String get name => 'GetDeviceMetadata';

  @override
  Future<ProbeResult> run(DiagnosticContext ctx) async {
    final sw = Stopwatch()..start();

    try {
      // Listen to the node stream for metadata updates
      final completer = Completer<void>();
      final sub = ctx.protocolService.nodeStream.listen((node) {
        if (node.nodeNum == ctx.targetNodeNum &&
            node.firmwareVersion != null &&
            !completer.isCompleted) {
          completer.complete();
        }
      });

      try {
        await ctx.protocolService.getDeviceMetadata(target: ctx.target);

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.probe,
          probeName: name,
          notes: 'Request sent to 0x${ctx.targetNodeNum.toRadixString(16)}',
        );

        await completer.future.timeout(ctx.timeout);

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.assert_,
          probeName: name,
          notes: 'Metadata response received',
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
          error: 'Timeout waiting for device metadata response',
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
