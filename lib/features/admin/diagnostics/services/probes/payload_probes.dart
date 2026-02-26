// SPDX-License-Identifier: GPL-3.0-or-later
import 'dart:async';

import '../../../../../core/logging.dart';
import '../../../diagnostics/models/diagnostic_event.dart';
import '../diagnostic_probe.dart';

/// Probe: request canned messages and verify text response.
class GetCannedMessagesProbe extends DiagnosticProbe {
  @override
  String get name => 'GetCannedMessages';

  @override
  Future<ProbeResult> run(DiagnosticContext ctx) async {
    final sw = Stopwatch()..start();

    try {
      final completer = Completer<String>();
      final sub = ctx.protocolService.cannedMessageTextStream.listen((text) {
        if (!completer.isCompleted) {
          completer.complete(text);
        }
      });

      try {
        await ctx.protocolService.getCannedMessages(target: ctx.target);

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.probe,
          probeName: name,
          notes: 'Request sent',
        );

        final text = await completer.future.timeout(ctx.timeout);

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.assert_,
          probeName: name,
          decoded: DecodedPayload(
            messageType: 'CannedMessages',
            json: {'length': text.length, 'preview': _truncate(text, 100)},
          ),
          notes: 'Canned messages received (${text.length} chars)',
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
          error: 'Timeout waiting for canned messages response',
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

/// Probe: request ringtone and verify RTTTL string response.
class GetRingtoneProbe extends DiagnosticProbe {
  @override
  String get name => 'GetRingtone';

  @override
  Future<ProbeResult> run(DiagnosticContext ctx) async {
    final sw = Stopwatch()..start();

    try {
      final completer = Completer<String>();
      final sub = ctx.protocolService.ringtoneTextStream.listen((text) {
        if (!completer.isCompleted) {
          completer.complete(text);
        }
      });

      try {
        await ctx.protocolService.getRingtone(target: ctx.target);

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.probe,
          probeName: name,
          notes: 'Request sent',
        );

        final text = await completer.future.timeout(ctx.timeout);

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.assert_,
          probeName: name,
          decoded: DecodedPayload(
            messageType: 'Ringtone',
            json: {'length': text.length, 'preview': _truncate(text, 100)},
          ),
          notes: 'Ringtone received (${text.length} chars)',
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
          error: 'Timeout waiting for ringtone response',
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

String _truncate(String s, int maxLen) {
  if (s.length <= maxLen) return s;
  return '${s.substring(0, maxLen)}...';
}
