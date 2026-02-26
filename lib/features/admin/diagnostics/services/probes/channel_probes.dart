// SPDX-License-Identifier: GPL-3.0-or-later
import 'dart:async';

import '../../../../../core/logging.dart';
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
