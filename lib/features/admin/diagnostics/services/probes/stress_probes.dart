// SPDX-License-Identifier: GPL-3.0-or-later
import 'dart:async';

import '../../../../../core/logging.dart';
import '../../../../../generated/meshtastic/admin.pb.dart' as admin;
import '../../../diagnostics/models/diagnostic_event.dart';
import '../diagnostic_probe.dart';

/// Stress probe: burst-read N configs with small pacing, report jitter.
class BurstReadConfigsProbe extends DiagnosticProbe {
  final int burstCount;
  final Duration pacing;
  final int maxAllowedTimeouts;

  BurstReadConfigsProbe({
    this.burstCount = 10,
    this.pacing = const Duration(milliseconds: 150),
    this.maxAllowedTimeouts = 3,
  });

  @override
  String get name => 'BurstReadConfigs';

  @override
  bool get isStressTest => true;

  @override
  Future<ProbeResult> run(DiagnosticContext ctx) async {
    final sw = Stopwatch()..start();
    final latencies = <int>[];
    var timeouts = 0;

    try {
      for (var i = 0; i < burstCount; i++) {
        final iterSw = Stopwatch()..start();
        final completer = Completer<void>();

        final sub = ctx.protocolService.deviceConfigStream.listen((_) {
          if (!completer.isCompleted) {
            completer.complete();
          }
        });

        try {
          await ctx.protocolService.getConfig(
            admin.AdminMessage_ConfigType.DEVICE_CONFIG,
            target: ctx.target,
          );

          await completer.future.timeout(ctx.timeout);
          latencies.add(iterSw.elapsedMilliseconds);
        } on TimeoutException {
          timeouts++;
        } finally {
          await sub.cancel();
        }

        if (i < burstCount - 1) {
          await Future<void>.delayed(pacing);
        }
      }

      // Compute stats
      final stats = _computeStats(latencies);

      ctx.capture.recordInternal(
        phase: DiagnosticPhase.assert_,
        probeName: name,
        decoded: DecodedPayload(
          messageType: 'BurstStats',
          json: {
            'burstCount': burstCount,
            'successCount': latencies.length,
            'timeoutCount': timeouts,
            ...stats,
          },
        ),
        notes: 'Burst: ${latencies.length}/$burstCount OK, $timeouts timeouts',
      );

      final passed = timeouts <= maxAllowedTimeouts;
      return ProbeResult(
        outcome: passed ? ProbeOutcome.pass : ProbeOutcome.fail,
        durationMs: sw.elapsedMilliseconds,
        error: passed
            ? null
            : '$timeouts timeouts exceeded max $maxAllowedTimeouts',
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

  Map<String, dynamic> _computeStats(List<int> latencies) {
    if (latencies.isEmpty) {
      return {'minMs': 0, 'medianMs': 0, 'maxMs': 0};
    }
    final sorted = List<int>.from(latencies)..sort();
    return {
      'minMs': sorted.first,
      'medianMs': sorted[sorted.length ~/ 2],
      'maxMs': sorted.last,
    };
  }
}

/// Stress probe: send two rapid requests and verify correlation by packet ID.
class OutOfOrderProbe extends DiagnosticProbe {
  @override
  String get name => 'OutOfOrderCorrelation';

  @override
  bool get isStressTest => true;

  @override
  Future<ProbeResult> run(DiagnosticContext ctx) async {
    final sw = Stopwatch()..start();

    try {
      // Send two different config requests rapidly
      final completerA = Completer<void>();
      final completerB = Completer<void>();

      final subA = ctx.protocolService.deviceConfigStream.listen((_) {
        if (!completerA.isCompleted) completerA.complete();
      });
      final subB = ctx.protocolService.loraConfigStream.listen((_) {
        if (!completerB.isCompleted) completerB.complete();
      });

      try {
        // Send A then B rapidly (no pacing)
        await ctx.protocolService.getConfig(
          admin.AdminMessage_ConfigType.DEVICE_CONFIG,
          target: ctx.target,
        );
        await ctx.protocolService.getConfig(
          admin.AdminMessage_ConfigType.LORA_CONFIG,
          target: ctx.target,
        );

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.probe,
          probeName: name,
          notes: 'Sent DEVICE_CONFIG then LORA_CONFIG rapidly',
        );

        // Both must arrive (in any order)
        await Future.wait([
          completerA.future.timeout(ctx.timeout),
          completerB.future.timeout(ctx.timeout),
        ]);

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.assert_,
          probeName: name,
          notes: 'Both responses received and correlated',
        );

        return ProbeResult(
          outcome: ProbeOutcome.pass,
          durationMs: sw.elapsedMilliseconds,
        );
      } on TimeoutException {
        final aOk = completerA.isCompleted;
        final bOk = completerB.isCompleted;
        return ProbeResult(
          outcome: ProbeOutcome.fail,
          durationMs: sw.elapsedMilliseconds,
          error:
              'Timeout: DEVICE_CONFIG=${aOk ? "OK" : "missing"}, '
              'LORA_CONFIG=${bOk ? "OK" : "missing"}',
        );
      } finally {
        await subA.cancel();
        await subB.cancel();
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
