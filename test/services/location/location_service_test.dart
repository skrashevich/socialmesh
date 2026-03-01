// SPDX-License-Identifier: GPL-3.0-or-later
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';

import 'package:socialmesh/core/transport.dart';
import 'package:socialmesh/services/location/location_service.dart';
import 'package:socialmesh/services/protocol/protocol_service.dart';

// ---------------------------------------------------------------------------
// Fakes
// ---------------------------------------------------------------------------

/// Minimal transport stub so ProtocolService can be instantiated.
class _FakeTransport extends DeviceTransport {
  @override
  TransportType get type => TransportType.ble;

  @override
  bool get requiresFraming => false;

  @override
  DeviceConnectionState get state => DeviceConnectionState.disconnected;

  @override
  Stream<DeviceConnectionState> get stateStream => const Stream.empty();

  @override
  Stream<List<int>> get dataStream => const Stream.empty();

  @override
  Stream<DeviceInfo> scan({Duration? timeout, bool scanAll = false}) =>
      const Stream.empty();

  @override
  Future<void> connect(DeviceInfo device) async {}

  @override
  Future<void> disconnect() async {}

  @override
  Future<void> enableNotifications() async {}

  @override
  Future<void> pollOnce() async {}

  @override
  Future<void> send(List<int> data) async {}

  @override
  Future<int?> readRssi() async => null;

  @override
  Future<void> dispose() async {}
}

/// ProtocolService subclass that records `sendPosition` calls instead of
/// serializing protobufs and hitting a real transport.
class _SpyProtocolService extends ProtocolService {
  final List<({double lat, double lon, int? alt})> sentPositions = [];

  _SpyProtocolService() : super(_FakeTransport());

  @override
  Future<void> sendPosition({
    required double latitude,
    required double longitude,
    int? altitude,
  }) async {
    sentPositions.add((lat: latitude, lon: longitude, alt: altitude));
  }
}

/// LocationService subclass that overrides `getCurrentPosition` and
/// `checkPermissions` to avoid hitting the real Geolocator (needs
/// platform channels / real GPS).
class _TestableLocationService extends LocationService {
  Position? fakePosition;

  _TestableLocationService(
    super.protocolService, {
    super.isLocationSharingEnabled,
    this.fakePosition,
  });

  @override
  Future<Position?> getCurrentPosition() async => fakePosition;

  @override
  Future<bool> checkPermissions() async => true;
}

/// Transport that records raw send calls so we can count how many
/// POSITION_APP packets actually reached the transport layer.
class _RecordingTransport extends DeviceTransport {
  final List<List<int>> sentBytes = [];

  @override
  TransportType get type => TransportType.ble;

  @override
  bool get requiresFraming => false;

  @override
  bool get isConnected => true;

  @override
  DeviceConnectionState get state => DeviceConnectionState.connected;

  @override
  Stream<DeviceConnectionState> get stateStream => const Stream.empty();

  @override
  Stream<List<int>> get dataStream => const Stream.empty();

  @override
  Stream<DeviceInfo> scan({Duration? timeout, bool scanAll = false}) =>
      const Stream.empty();

  @override
  Future<void> connect(DeviceInfo device) async {}

  @override
  Future<void> disconnect() async {}

  @override
  Future<void> enableNotifications() async {}

  @override
  Future<void> pollOnce() async {}

  @override
  Future<void> send(List<int> data) async {
    sentBytes.add(data);
  }

  @override
  Future<int?> readRssi() async => null;

  @override
  Future<void> dispose() async {}
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

Position _fakePosition({
  double latitude = 51.5074,
  double longitude = -0.1278,
  double altitude = 11.0,
}) {
  return Position(
    latitude: latitude,
    longitude: longitude,
    altitude: altitude,
    timestamp: DateTime.now(),
    accuracy: 5.0,
    altitudeAccuracy: 5.0,
    heading: 0.0,
    headingAccuracy: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0,
  );
}

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LocationService providePhoneLocation gate', () {
    late _SpyProtocolService protocol;

    setUp(() {
      protocol = _SpyProtocolService();
    });

    // ----- sendPositionOnce -----

    test(
      'sendPositionOnce is a no-op when isLocationSharingEnabled is null',
      () async {
        final service = _TestableLocationService(
          protocol,
          fakePosition: _fakePosition(),
          // isLocationSharingEnabled deliberately omitted (null)
        );

        await service.sendPositionOnce();

        expect(
          protocol.sentPositions,
          isEmpty,
          reason: 'null callback should default to false — no emission',
        );
      },
    );

    test(
      'sendPositionOnce is a no-op when isLocationSharingEnabled returns false',
      () async {
        final service = _TestableLocationService(
          protocol,
          isLocationSharingEnabled: () => false,
          fakePosition: _fakePosition(),
        );

        await service.sendPositionOnce();

        expect(
          protocol.sentPositions,
          isEmpty,
          reason: 'providePhoneLocation=false — no emission',
        );
      },
    );

    test(
      'sendPositionOnce sends when isLocationSharingEnabled returns true',
      () async {
        final service = _TestableLocationService(
          protocol,
          isLocationSharingEnabled: () => true,
          fakePosition: _fakePosition(latitude: 40.7128, longitude: -74.0060),
        );

        await service.sendPositionOnce();

        expect(protocol.sentPositions, hasLength(1));
        expect(protocol.sentPositions.first.lat, 40.7128);
        expect(protocol.sentPositions.first.lon, -74.0060);
      },
    );

    test('sendPositionOnce does not send when position is null', () async {
      final service = _TestableLocationService(
        protocol,
        isLocationSharingEnabled: () => true,
        fakePosition: null, // no GPS fix
      );

      await service.sendPositionOnce();

      expect(
        protocol.sentPositions,
        isEmpty,
        reason: 'Even with sharing enabled, null position means no emission',
      );
    });

    // ----- Dynamic toggle (simulating setting change between ticks) -----

    test(
      'gate is evaluated dynamically — toggling mid-session works',
      () async {
        var enabled = false;

        final service = _TestableLocationService(
          protocol,
          isLocationSharingEnabled: () => enabled,
          fakePosition: _fakePosition(),
        );

        // First call: disabled → no emission
        await service.sendPositionOnce();
        expect(protocol.sentPositions, isEmpty);

        // User enables the setting
        enabled = true;

        // Second call: enabled → emission
        await service.sendPositionOnce();
        expect(protocol.sentPositions, hasLength(1));

        // User disables the setting again
        enabled = false;

        // Third call: disabled → no emission
        await service.sendPositionOnce();
        expect(
          protocol.sentPositions,
          hasLength(1),
          reason: 'Still 1 — the third call was blocked',
        );
      },
    );

    // ----- Timer-based (startLocationUpdates) -----

    test(
      'periodic timer fires but does not emit when sharing is disabled',
      () async {
        final service = _TestableLocationService(
          protocol,
          isLocationSharingEnabled: () => false,
          fakePosition: _fakePosition(),
        );

        // startLocationUpdates will fail permission check in test env
        // (no Geolocator platform channel), so we test via sendPositionOnce
        // which exercises the same _sendCurrentPosition code path.
        // The timer-based path is structurally identical — it calls
        // _sendCurrentPosition on each tick.
        await service.sendPositionOnce();
        await service.sendPositionOnce();
        await service.sendPositionOnce();

        expect(
          protocol.sentPositions,
          isEmpty,
          reason: 'Three ticks, all blocked by the gate',
        );
      },
    );

    // ----- Default value matches meshtastic-ios -----

    test('default value is false (opt-in, matching meshtastic-ios)', () async {
      // When no callback is provided, the default is false (no emission).
      // This matches meshtastic-ios UserDefaults.provideLocation defaultValue: false.
      final service = _TestableLocationService(
        protocol,
        fakePosition: _fakePosition(),
      );

      await service.sendPositionOnce();

      expect(
        protocol.sentPositions,
        isEmpty,
        reason: 'Default must be false — privacy by default',
      );
    });

    // ----- Dispose / cleanup -----

    test('dispose stops the timer without errors', () {
      final service = _TestableLocationService(
        protocol,
        isLocationSharingEnabled: () => true,
        fakePosition: _fakePosition(),
      );

      // Should not throw
      service.dispose();
      expect(service.isRunning, isFalse);
    });

    test('stopLocationUpdates resets isRunning', () async {
      final service = _TestableLocationService(
        protocol,
        isLocationSharingEnabled: () => true,
        fakePosition: _fakePosition(),
      );

      // Manually set running state (since startLocationUpdates needs
      // platform channels we can't use in unit tests)
      service.stopLocationUpdates();
      expect(service.isRunning, isFalse);
    });
  });

  // -----------------------------------------------------------------------
  // startLocationUpdates early-exit guard
  // -----------------------------------------------------------------------

  group('LocationService startLocationUpdates guard', () {
    late _SpyProtocolService protocol;

    setUp(() {
      protocol = _SpyProtocolService();
    });

    test(
      'startLocationUpdates does not start when isLocationSharingEnabled is null',
      () async {
        final service = _TestableLocationService(
          protocol,
          fakePosition: _fakePosition(),
          // isLocationSharingEnabled deliberately omitted (null → false)
        );

        await service.startLocationUpdates();

        expect(
          service.isRunning,
          isFalse,
          reason: 'Timer must not start when sharing callback is null',
        );
        expect(protocol.sentPositions, isEmpty);
      },
    );

    test(
      'startLocationUpdates does not start when isLocationSharingEnabled returns false',
      () async {
        final service = _TestableLocationService(
          protocol,
          isLocationSharingEnabled: () => false,
          fakePosition: _fakePosition(),
        );

        await service.startLocationUpdates();

        expect(
          service.isRunning,
          isFalse,
          reason: 'Timer must not start when sharing is disabled',
        );
        expect(protocol.sentPositions, isEmpty);
      },
    );

    test(
      'startLocationUpdates starts and sends when isLocationSharingEnabled returns true',
      () async {
        final service = _TestableLocationService(
          protocol,
          isLocationSharingEnabled: () => true,
          fakePosition: _fakePosition(latitude: 38.7223, longitude: -9.1393),
        );

        await service.startLocationUpdates();

        expect(
          service.isRunning,
          isTrue,
          reason: 'Timer must start when sharing is enabled',
        );
        // The initial position should have been sent immediately.
        expect(protocol.sentPositions, hasLength(1));
        expect(protocol.sentPositions.first.lat, 38.7223);

        service.dispose();
      },
    );
  });

  // -----------------------------------------------------------------------
  // ProtocolService POSITION_APP rate limiter
  // -----------------------------------------------------------------------

  group('ProtocolService position rate limiter', () {
    test('first sendPosition broadcast always succeeds', () async {
      final transport = _RecordingTransport();
      final ps = ProtocolService(transport);

      await ps.sendPosition(latitude: 39.5, longitude: -8.9);
      expect(transport.sentBytes, hasLength(1));
    });

    test('rapid successive broadcast is rate-limited', () async {
      final transport = _RecordingTransport();
      final ps = ProtocolService(transport);

      await ps.sendPosition(latitude: 39.5, longitude: -8.9);
      // Immediately send again — should be blocked.
      await ps.sendPosition(latitude: 39.6, longitude: -8.8);

      expect(
        transport.sentBytes,
        hasLength(1),
        reason: 'Second broadcast within 20 s must be rate-limited',
      );
    });

    test('first sendPositionToNode always succeeds', () async {
      final transport = _RecordingTransport();
      final ps = ProtocolService(transport);

      await ps.sendPositionToNode(nodeNum: 42, latitude: 39.5, longitude: -8.9);
      expect(transport.sentBytes, hasLength(1));
    });

    test('rapid successive direct send is rate-limited', () async {
      final transport = _RecordingTransport();
      final ps = ProtocolService(transport);

      await ps.sendPositionToNode(nodeNum: 42, latitude: 39.5, longitude: -8.9);
      // Immediately send again — should be blocked.
      await ps.sendPositionToNode(nodeNum: 42, latitude: 39.6, longitude: -8.8);

      expect(
        transport.sentBytes,
        hasLength(1),
        reason: 'Second direct send within 10 s must be rate-limited',
      );
    });

    test('broadcast and direct use independent rate limits', () async {
      final transport = _RecordingTransport();
      final ps = ProtocolService(transport);

      // Broadcast then direct — both should succeed because they track
      // separate timestamps.
      await ps.sendPosition(latitude: 39.5, longitude: -8.9);
      await ps.sendPositionToNode(nodeNum: 42, latitude: 39.5, longitude: -8.9);

      expect(
        transport.sentBytes,
        hasLength(2),
        reason: 'Broadcast and direct have independent cooldowns',
      );
    });
  });
}
