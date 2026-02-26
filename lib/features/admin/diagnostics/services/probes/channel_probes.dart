// SPDX-License-Identifier: GPL-3.0-or-later
import 'dart:async';

import '../../../../../core/logging.dart';
import '../../../../../models/mesh_models.dart';
import '../../../diagnostics/models/diagnostic_event.dart';
import '../diagnostic_probe.dart';

/// Probe that requests a channel by index and waits for the
/// corresponding stream emission from ProtocolService.
///
/// Channels 0–7 are tested. Channel 0 is always PRIMARY.
/// Channels 1–7 may be DISABLED on most devices.
class GetChannelProbe extends DiagnosticProbe {
  final int channelIndex;

  GetChannelProbe({required this.channelIndex});

  @override
  String get name => 'GetChannel_$channelIndex';

  @override
  Future<ProbeResult> run(DiagnosticContext ctx) async {
    final sw = Stopwatch()..start();

    try {
      final completer = Completer<dynamic>();
      final sub = ctx.protocolService.channelStream.listen((ch) {
        if (ch.index == channelIndex && !completer.isCompleted) {
          completer.complete(ch);
        }
      });

      try {
        await ctx.protocolService.getChannel(channelIndex);

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.probe,
          probeName: name,
          notes: 'Request sent for channel $channelIndex',
        );

        final result = await completer.future.timeout(ctx.timeout);

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.assert_,
          probeName: name,
          decoded: DecodedPayload(
            messageType: 'Channel',
            json: {
              'index': result.index,
              'role': result.role,
              'name': result.name,
            },
          ),
          notes:
              'Channel $channelIndex response received (role: ${result.role})',
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
          error: 'Timeout waiting for channel $channelIndex response',
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

/// Write probe: read channel 0, write the same config back (no-op),
/// then read back and verify the round-trip preserves all fields.
///
/// Channel 0 is always PRIMARY and safe to write back unchanged.
/// The extended timeout accounts for three sequential BLE round-trips
/// plus the firmware's internal 500 ms verify delay after setChannel.
class WriteChannelReadbackProbe extends DiagnosticProbe {
  @override
  String get name => 'WriteChannel_0_NoOp';

  @override
  bool get requiresWrite => true;

  @override
  Duration? get maxDuration => const Duration(seconds: 20);

  @override
  Future<ProbeResult> run(DiagnosticContext ctx) async {
    final sw = Stopwatch()..start();

    try {
      // Step 1: Read current channel 0
      final readCompleter = Completer<ChannelConfig>();
      var sub = ctx.protocolService.channelStream.listen((ch) {
        if (ch.index == 0 && !readCompleter.isCompleted) {
          readCompleter.complete(ch);
        }
      });

      await ctx.protocolService.getChannel(0);
      final original = await readCompleter.future.timeout(ctx.timeout);
      await sub.cancel();

      ctx.capture.recordInternal(
        phase: DiagnosticPhase.probe,
        probeName: name,
        notes: 'Read channel 0: "${original.name}" role=${original.role}',
      );

      // Step 2: Write same channel config back (no-op)
      await ctx.protocolService.setChannel(original);

      ctx.capture.recordInternal(
        phase: DiagnosticPhase.probe,
        probeName: name,
        notes: 'Wrote same channel 0 back (no-op)',
      );

      // Step 3: Read back — setChannel already requests a verify read
      // after 500 ms, but we need to listen for it explicitly.
      final verifyCompleter = Completer<ChannelConfig>();
      sub = ctx.protocolService.channelStream.listen((ch) {
        if (ch.index == 0 && !verifyCompleter.isCompleted) {
          verifyCompleter.complete(ch);
        }
      });

      // Wait for the verify read that setChannel triggers internally
      final readback = await verifyCompleter.future.timeout(ctx.timeout);
      await sub.cancel();

      // Compare key fields (ChannelConfig doesn't implement ==)
      final matches =
          readback.name == original.name &&
          readback.role == original.role &&
          readback.uplink == original.uplink &&
          readback.downlink == original.downlink &&
          readback.positionPrecision == original.positionPrecision;

      if (matches) {
        ctx.capture.recordInternal(
          phase: DiagnosticPhase.assert_,
          probeName: name,
          notes: 'Write-readback verified: channel 0 matches',
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
              'Readback mismatch for channel 0: '
              'name="${readback.name}" vs "${original.name}", '
              'role=${readback.role} vs ${original.role}',
        );
      }
    } on TimeoutException {
      return ProbeResult(
        outcome: ProbeOutcome.fail,
        durationMs: sw.elapsedMilliseconds,
        error: 'Timeout during channel 0 write-readback cycle',
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
