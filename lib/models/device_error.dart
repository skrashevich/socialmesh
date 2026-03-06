// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)
/// Device error codes from Meshtastic
enum DeviceErrorCode {
  none,
  txWatchdog,
  sleepEnterWait,
  noRadio,
  unspecified,
  ubloxInitFailed,
  noAxp192,
  invalidRadioSetting,
  transmitFailed,
  brownout,
  sxTxTimeout,
  noAckFromRemoteRadio,
  unknown,
}

/// Maps integer error codes to enum values
DeviceErrorCode deviceErrorCodeFromInt(int code) {
  switch (code) {
    case 0:
      return DeviceErrorCode.none;
    case 1:
      return DeviceErrorCode.txWatchdog;
    case 2:
      return DeviceErrorCode.sleepEnterWait;
    case 3:
      return DeviceErrorCode.noRadio;
    case 4:
      return DeviceErrorCode.unspecified;
    case 5:
      return DeviceErrorCode.ubloxInitFailed;
    case 6:
      return DeviceErrorCode.noAxp192;
    case 7:
      return DeviceErrorCode.invalidRadioSetting;
    case 8:
      return DeviceErrorCode.transmitFailed;
    case 9:
      return DeviceErrorCode.brownout;
    case 10:
      return DeviceErrorCode.sxTxTimeout;
    case 11:
      return DeviceErrorCode.noAckFromRemoteRadio;
    default:
      return DeviceErrorCode.unknown;
  }
}

/// Device error with details
class DeviceError {
  final DeviceErrorCode code;
  final String message;
  final DateTime timestamp;

  const DeviceError({
    required this.code,
    required this.message,
    required this.timestamp,
  });

  /// User-friendly error description
  String get description {
    switch (code) {
      case DeviceErrorCode.none:
        return 'No error'; // lint-allow: hardcoded-string
      case DeviceErrorCode.txWatchdog:
        return 'Transmit watchdog timeout'; // lint-allow: hardcoded-string
      case DeviceErrorCode.sleepEnterWait:
        return 'Device entering sleep mode'; // lint-allow: hardcoded-string
      case DeviceErrorCode.noRadio:
        return 'Radio hardware not found'; // lint-allow: hardcoded-string
      case DeviceErrorCode.unspecified:
        return 'Unspecified error'; // lint-allow: hardcoded-string
      case DeviceErrorCode.ubloxInitFailed:
        return 'GPS initialization failed'; // lint-allow: hardcoded-string
      case DeviceErrorCode.noAxp192:
        return 'Power management chip not found'; // lint-allow: hardcoded-string
      case DeviceErrorCode.invalidRadioSetting:
        return 'Invalid radio configuration'; // lint-allow: hardcoded-string
      case DeviceErrorCode.transmitFailed:
        return 'Transmission failed'; // lint-allow: hardcoded-string
      case DeviceErrorCode.brownout:
        return 'Low voltage brownout detected'; // lint-allow: hardcoded-string
      case DeviceErrorCode.sxTxTimeout:
        return 'Radio transmit timeout'; // lint-allow: hardcoded-string
      case DeviceErrorCode.noAckFromRemoteRadio:
        return 'No acknowledgment from remote device'; // lint-allow: hardcoded-string
      case DeviceErrorCode.unknown:
        return 'Unknown error'; // lint-allow: hardcoded-string
    }
  }

  @override
  String toString() => '$code: $message';
}
