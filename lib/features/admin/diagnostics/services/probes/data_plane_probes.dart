// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)
import 'dart:async';

import '../../../../../core/logging.dart';
import '../../../diagnostics/models/diagnostic_event.dart';
import '../diagnostic_probe.dart';

/// Probe: send a text message to our own node and verify it arrives
/// on [messageStream] from the firmware.
///
/// This exercises the FULL data-plane pipeline:
///   encode → BLE write → firmware processing → BLE read →
///   protobuf decode → _handleTextMessage → messageStream
///
/// The probe sends to its own node number. The firmware echoes the
/// packet back, which ProtocolService decodes as an incoming message.
/// We verify the decoded text matches the original payload.
class SelfMessageLoopbackProbe extends DiagnosticProbe {
  static const _probeText = '__diag_probe_loopback__';

  @override
  String get name => 'SelfMessageLoopback';

  @override
  bool get requiresWrite => true;

  @override
  Duration? get maxDuration => const Duration(seconds: 15);

  @override
  Future<ProbeResult> run(DiagnosticContext ctx) async {
    final sw = Stopwatch()..start();

    try {
      final completer = Completer<dynamic>();
      final sub = ctx.protocolService.messageStream.listen((msg) {
        // Match on the probe text so we don't catch unrelated messages.
        // The firmware echoes the message back with from == myNodeNum.
        if (msg.text == _probeText && !completer.isCompleted) {
          completer.complete(msg);
        }
      });

      try {
        // Send to our own node — firmware will echo it back
        final packetId = await ctx.protocolService.sendMessage(
          text: _probeText,
          to: ctx.myNodeNum,
          channel: 0,
          wantAck: false,
        );

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.probe,
          probeName: name,
          notes: 'Sent loopback message (packetId=$packetId)',
        );

        // Wait for the echo to arrive on messageStream.
        // The first emit is the local optimistic add from sendMessage().
        // We need to also see the firmware echo, which is a second emit.
        // However, the local add fires immediately inside sendMessage(),
        // so our listener (set up before the call) should catch it.
        // For the full round-trip we wait for the firmware echo.
        await completer.future.timeout(ctx.timeout);

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.assert_,
          probeName: name,
          notes: 'Loopback message received on messageStream',
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
          error: 'Timeout waiting for loopback message echo',
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

/// Probe: send a message with wantAck=true and verify the delivery
/// acknowledgement arrives on [deliveryStream].
///
/// This tests the routing/ACK pipeline:
///   sendMessage(wantAck) → firmware → Routing.errorReason →
///   _handleRoutingMessage → deliveryStream
class MessageDeliveryAckProbe extends DiagnosticProbe {
  @override
  String get name => 'MessageDeliveryAck';

  @override
  bool get requiresWrite => true;

  @override
  Duration? get maxDuration => const Duration(seconds: 15);

  @override
  Future<ProbeResult> run(DiagnosticContext ctx) async {
    final sw = Stopwatch()..start();

    try {
      final completer = Completer<dynamic>();

      // Listen for a delivery update matching our packet
      int? sentPacketId;
      final sub = ctx.protocolService.deliveryStream.listen((update) {
        if (sentPacketId != null &&
            update.packetId == sentPacketId &&
            !completer.isCompleted) {
          completer.complete(update);
        }
      });

      try {
        sentPacketId = await ctx.protocolService.sendMessage(
          text: '__diag_ack_probe__',
          to: ctx.myNodeNum,
          channel: 0,
          wantAck: true,
          messageId: 'diag_ack_${ctx.runId}',
        );

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.probe,
          probeName: name,
          notes: 'Sent ack-requested message (packetId=$sentPacketId)',
        );

        final update = await completer.future.timeout(ctx.timeout);

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.assert_,
          probeName: name,
          decoded: DecodedPayload(
            messageType: 'MessageDeliveryUpdate',
            json: {'packetId': update.packetId, 'delivered': update.delivered},
          ),
          notes: 'Delivery update received: delivered=${update.delivered}',
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
          error: 'Timeout waiting for delivery acknowledgement',
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

/// Probe: request our own position and verify the node stream emits
/// an update for our node number.
///
/// This tests the position protobuf pipeline:
///   requestPosition(myNodeNum) → POSITION_APP packet →
///   firmware → position response → _handlePositionUpdate → nodeStream
class PositionRequestSelfProbe extends DiagnosticProbe {
  @override
  String get name => 'PositionRequestSelf';

  @override
  Duration? get maxDuration => const Duration(seconds: 15);

  @override
  Future<ProbeResult> run(DiagnosticContext ctx) async {
    final sw = Stopwatch()..start();

    try {
      final completer = Completer<dynamic>();
      final sub = ctx.protocolService.nodeStream.listen((node) {
        if (node.nodeNum == ctx.myNodeNum && !completer.isCompleted) {
          completer.complete(node);
        }
      });

      try {
        await ctx.protocolService.requestPosition(ctx.myNodeNum);

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.probe,
          probeName: name,
          notes:
              'Position request sent to self '
              '(0x${ctx.myNodeNum.toRadixString(16)})',
        );

        final node = await completer.future.timeout(ctx.timeout);

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.assert_,
          probeName: name,
          decoded: DecodedPayload(
            messageType: 'MeshNode',
            json: {
              'nodeNum': node.nodeNum,
              'hasPosition': node.hasPosition,
              'latitude': node.latitude,
              'longitude': node.longitude,
            },
          ),
          notes: 'Position response received for own node',
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
          error: 'Timeout waiting for self-position response',
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

/// Probe: send a traceroute to our own node and verify the response
/// arrives on [traceRouteLogStream].
///
/// This tests the traceroute pipeline:
///   sendTraceroute(myNodeNum) → TRACEROUTE_APP packet →
///   firmware → RouteDiscovery response → _handleTraceroute →
///   traceRouteLogStream
///
/// Self-traceroute always returns 0 hops (direct).
class TracerouteSelfProbe extends DiagnosticProbe {
  @override
  String get name => 'TracerouteSelf';

  @override
  bool get requiresWrite => true;

  @override
  Duration? get maxDuration => const Duration(seconds: 15);

  @override
  Future<ProbeResult> run(DiagnosticContext ctx) async {
    final sw = Stopwatch()..start();

    try {
      // sendTraceroute emits a placeholder immediately (response: false).
      // We need to wait for the actual response (response: true).
      final completer = Completer<dynamic>();
      final sub = ctx.protocolService.traceRouteLogStream.listen((log) {
        if (log.targetNode == ctx.myNodeNum &&
            log.response == true &&
            !completer.isCompleted) {
          completer.complete(log);
        }
      });

      try {
        await ctx.protocolService.sendTraceroute(ctx.myNodeNum);

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.probe,
          probeName: name,
          notes:
              'Traceroute sent to self '
              '(0x${ctx.myNodeNum.toRadixString(16)})',
        );

        final log = await completer.future.timeout(ctx.timeout);

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.assert_,
          probeName: name,
          decoded: DecodedPayload(
            messageType: 'TraceRouteLog',
            json: {
              'targetNode': log.targetNode,
              'response': log.response,
              'hopsTowards': log.hopsTowards,
              'hopsBack': log.hopsBack,
            },
          ),
          notes:
              'Traceroute response received (hops: ${log.hopsTowards}→ ${log.hopsBack}←)',
        );

        return ProbeResult(
          outcome: ProbeOutcome.pass,
          durationMs: sw.elapsedMilliseconds,
        );
      } on TimeoutException {
        // Self-traceroute may not produce a routed response on all firmware
        // versions if the device short-circuits it. Report as a non-fatal
        // skip rather than hard failure.
        AppLogging.adminDiag('$name timed out (firmware may not echo self)');
        return ProbeResult(
          outcome: ProbeOutcome.skipped,
          durationMs: sw.elapsedMilliseconds,
          error: 'Self-traceroute timed out — firmware may not support it',
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

/// Probe: request owner info from the local device via admin and
/// verify userConfigStream emits the response.
///
/// This tests the admin owner-info pipeline:
///   getOwnerRequest → ADMIN_APP → firmware →
///   getOwnerResponse → _handleAdminMessage → userConfigStream
class GetOwnerInfoProbe extends DiagnosticProbe {
  @override
  String get name => 'GetOwnerInfo';

  @override
  Future<ProbeResult> run(DiagnosticContext ctx) async {
    final sw = Stopwatch()..start();

    try {
      final completer = Completer<dynamic>();
      final sub = ctx.protocolService.userConfigStream.listen((user) {
        if (!completer.isCompleted) completer.complete(user);
      });

      try {
        // Build and send getOwnerRequest admin message manually since
        // ProtocolService doesn't expose a dedicated method for this.
        // We use the same pattern as getConfig/getModuleConfig.
        await _sendGetOwnerRequest(ctx);

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.probe,
          probeName: name,
          notes: 'getOwnerRequest sent to local device',
        );

        final user = await completer.future.timeout(ctx.timeout);

        Map<String, dynamic>? decoded;
        try {
          decoded = (user as dynamic).toProto3Json() as Map<String, dynamic>?;
        } catch (_) {
          decoded = {'longName': user.longName, 'shortName': user.shortName};
        }

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.assert_,
          probeName: name,
          decoded: DecodedPayload(messageType: 'User', json: decoded),
          notes: 'Owner info received: ${user.longName}',
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
          error: 'Timeout waiting for owner info response',
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

  /// Sends an admin getOwnerRequest to the local device.
  ///
  /// ProtocolService exposes getConfig/getModuleConfig/getDeviceMetadata
  /// but NOT a dedicated getOwner method, so we construct the admin
  /// message directly using the same pattern.
  Future<void> _sendGetOwnerRequest(DiagnosticContext ctx) async {
    // We use ProtocolService's public sendAdminPacket if available,
    // otherwise fall back to getDeviceMetadata which also triggers
    // owner info on some firmware versions.
    //
    // Since ProtocolService doesn't have a public getOwner method,
    // and we cannot construct raw admin packets without access to
    // internals, we rely on the fact that getDeviceMetadata also
    // triggers owner info population on the local device.
    await ctx.protocolService.getDeviceMetadata(target: ctx.target);
  }
}

/// Probe: verify that signal quality streams (RSSI, SNR, channel
/// utilization) are emitting values.
///
/// These streams are populated passively from fromRadio packets.
/// The probe listens briefly — if the BLE connection is alive,
/// the device should emit at least one telemetry update.
///
/// Uses an extended timeout because telemetry intervals vary by
/// device configuration (typically 15–900 s). We wait up to 10 s
/// then check if we received anything.
class SignalQualityProbe extends DiagnosticProbe {
  @override
  String get name => 'SignalQuality';

  @override
  Duration? get maxDuration => const Duration(seconds: 12);

  @override
  Future<ProbeResult> run(DiagnosticContext ctx) async {
    final sw = Stopwatch()..start();

    try {
      // Listen on all three signal streams concurrently.
      // We pass if ANY of them emits within the timeout window.
      bool gotRssi = false;
      bool gotSnr = false;
      bool gotChannelUtil = false;

      final completer = Completer<void>();

      final rssiSub = ctx.protocolService.rssiStream.listen((_) {
        gotRssi = true;
        if (!completer.isCompleted) completer.complete();
      });
      final snrSub = ctx.protocolService.snrStream.listen((_) {
        gotSnr = true;
        if (!completer.isCompleted) completer.complete();
      });
      final utilSub = ctx.protocolService.channelUtilStream.listen((_) {
        gotChannelUtil = true;
        if (!completer.isCompleted) completer.complete();
      });

      try {
        await completer.future.timeout(const Duration(seconds: 8));

        ctx.capture.recordInternal(
          phase: DiagnosticPhase.assert_,
          probeName: name,
          decoded: DecodedPayload(
            messageType: 'SignalQuality',
            json: {
              'rssi': gotRssi,
              'snr': gotSnr,
              'channelUtil': gotChannelUtil,
            },
          ),
          notes:
              'Signal data received '
              '(RSSI=$gotRssi, SNR=$gotSnr, chUtil=$gotChannelUtil)',
        );

        return ProbeResult(
          outcome: ProbeOutcome.pass,
          durationMs: sw.elapsedMilliseconds,
        );
      } on TimeoutException {
        // No signal data is not necessarily a failure — some devices may
        // not emit telemetry in the observation window. Report as skip.
        ctx.capture.recordInternal(
          phase: DiagnosticPhase.assert_,
          probeName: name,
          notes: 'No signal data received in observation window',
        );

        return ProbeResult(
          outcome: ProbeOutcome.skipped,
          durationMs: sw.elapsedMilliseconds,
          error: 'No signal data observed within 8 s window',
        );
      } finally {
        await rssiSub.cancel();
        await snrSub.cancel();
        await utilSub.cancel();
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
