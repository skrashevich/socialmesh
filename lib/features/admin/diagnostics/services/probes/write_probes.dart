// SPDX-License-Identifier: GPL-3.0-or-later
import 'dart:async';

import '../../../../../core/logging.dart';
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
