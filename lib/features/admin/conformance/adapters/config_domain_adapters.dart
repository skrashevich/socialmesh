// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)
import 'dart:async';

import '../../../../generated/meshtastic/admin.pb.dart' as admin;
import '../../../../generated/meshtastic/config.pb.dart' as config_pb;
import '../../../../generated/meshtastic/module_config.pb.dart' as module_pb;
import '../../../../models/mesh_models.dart';
import '../../../../services/protocol/admin_target.dart';
import '../../../../services/protocol/protocol_service.dart';

/// Uniform interface for loading and saving a device config domain.
///
/// Each adapter wraps the same ProtocolService calls the screens use,
/// giving the conformance harness a consistent entrypoint per domain.
///
/// Adapters MUST NOT duplicate logic — they delegate to the same
/// ProtocolService methods the UI screens call.
abstract class ConfigDomainAdapter<T> {
  /// Human-readable domain name (e.g. 'DEVICE_CONFIG').
  String get domainName;

  /// Load the current config from the device.
  ///
  /// Returns a Future that completes with the deserialized protobuf
  /// value (e.g. Config_DeviceConfig) after the response arrives on
  /// the corresponding stream.
  Future<T> load(ProtocolService protocol, AdminTarget target);

  /// Save a config to the device.
  ///
  /// Delegates to the same ProtocolService setter method the UI uses.
  Future<void> save(ProtocolService protocol, T config, AdminTarget target);

  /// Serialize a config to JSON for state captures.
  Map<String, dynamic> serialize(T config);

  /// Compare two configs for equality.
  ///
  /// For protobufs, uses proto equality. For plain Dart classes,
  /// compares key fields.
  bool isEqual(T a, T b);
}

// ---------------------------------------------------------------------------
// Config adapters (8 core config types)
// ---------------------------------------------------------------------------

class DeviceConfigAdapter
    extends ConfigDomainAdapter<config_pb.Config_DeviceConfig> {
  @override
  String get domainName => 'DEVICE_CONFIG';

  @override
  Future<config_pb.Config_DeviceConfig> load(
    ProtocolService protocol,
    AdminTarget target,
  ) async {
    final completer = Completer<config_pb.Config_DeviceConfig>();
    final sub = protocol.deviceConfigStream.listen((c) {
      if (!completer.isCompleted) completer.complete(c);
    });
    await protocol.getConfig(
      admin.AdminMessage_ConfigType.DEVICE_CONFIG,
      target: target,
    );
    try {
      return await completer.future.timeout(const Duration(seconds: 12));
    } finally {
      await sub.cancel();
    }
  }

  @override
  Future<void> save(
    ProtocolService protocol,
    config_pb.Config_DeviceConfig config,
    AdminTarget target,
  ) => protocol.setConfig(config_pb.Config()..device = config, target: target);

  @override
  Map<String, dynamic> serialize(config_pb.Config_DeviceConfig config) =>
      _protoToJson(config);

  @override
  bool isEqual(
    config_pb.Config_DeviceConfig a,
    config_pb.Config_DeviceConfig b,
  ) => a == b;
}

class LoRaConfigAdapter
    extends ConfigDomainAdapter<config_pb.Config_LoRaConfig> {
  @override
  String get domainName => 'LORA_CONFIG';

  @override
  Future<config_pb.Config_LoRaConfig> load(
    ProtocolService protocol,
    AdminTarget target,
  ) async {
    final completer = Completer<config_pb.Config_LoRaConfig>();
    final sub = protocol.loraConfigStream.listen((c) {
      if (!completer.isCompleted) completer.complete(c);
    });
    await protocol.getConfig(
      admin.AdminMessage_ConfigType.LORA_CONFIG,
      target: target,
    );
    try {
      return await completer.future.timeout(const Duration(seconds: 12));
    } finally {
      await sub.cancel();
    }
  }

  @override
  Future<void> save(
    ProtocolService protocol,
    config_pb.Config_LoRaConfig config,
    AdminTarget target,
  ) => protocol.setConfig(config_pb.Config()..lora = config, target: target);

  @override
  Map<String, dynamic> serialize(config_pb.Config_LoRaConfig config) =>
      _protoToJson(config);

  @override
  bool isEqual(config_pb.Config_LoRaConfig a, config_pb.Config_LoRaConfig b) =>
      a == b;
}

class PositionConfigAdapter
    extends ConfigDomainAdapter<config_pb.Config_PositionConfig> {
  @override
  String get domainName => 'POSITION_CONFIG';

  @override
  Future<config_pb.Config_PositionConfig> load(
    ProtocolService protocol,
    AdminTarget target,
  ) async {
    final completer = Completer<config_pb.Config_PositionConfig>();
    final sub = protocol.positionConfigStream.listen((c) {
      if (!completer.isCompleted) completer.complete(c);
    });
    await protocol.getConfig(
      admin.AdminMessage_ConfigType.POSITION_CONFIG,
      target: target,
    );
    try {
      return await completer.future.timeout(const Duration(seconds: 12));
    } finally {
      await sub.cancel();
    }
  }

  @override
  Future<void> save(
    ProtocolService protocol,
    config_pb.Config_PositionConfig config,
    AdminTarget target,
  ) =>
      protocol.setConfig(config_pb.Config()..position = config, target: target);

  @override
  Map<String, dynamic> serialize(config_pb.Config_PositionConfig config) =>
      _protoToJson(config);

  @override
  bool isEqual(
    config_pb.Config_PositionConfig a,
    config_pb.Config_PositionConfig b,
  ) => a == b;
}

class PowerConfigAdapter
    extends ConfigDomainAdapter<config_pb.Config_PowerConfig> {
  @override
  String get domainName => 'POWER_CONFIG';

  @override
  Future<config_pb.Config_PowerConfig> load(
    ProtocolService protocol,
    AdminTarget target,
  ) async {
    final completer = Completer<config_pb.Config_PowerConfig>();
    final sub = protocol.powerConfigStream.listen((c) {
      if (!completer.isCompleted) completer.complete(c);
    });
    await protocol.getConfig(
      admin.AdminMessage_ConfigType.POWER_CONFIG,
      target: target,
    );
    try {
      return await completer.future.timeout(const Duration(seconds: 12));
    } finally {
      await sub.cancel();
    }
  }

  @override
  Future<void> save(
    ProtocolService protocol,
    config_pb.Config_PowerConfig config,
    AdminTarget target,
  ) => protocol.setConfig(config_pb.Config()..power = config, target: target);

  @override
  Map<String, dynamic> serialize(config_pb.Config_PowerConfig config) =>
      _protoToJson(config);

  @override
  bool isEqual(
    config_pb.Config_PowerConfig a,
    config_pb.Config_PowerConfig b,
  ) => a == b;
}

class NetworkConfigAdapter
    extends ConfigDomainAdapter<config_pb.Config_NetworkConfig> {
  @override
  String get domainName => 'NETWORK_CONFIG';

  @override
  Future<config_pb.Config_NetworkConfig> load(
    ProtocolService protocol,
    AdminTarget target,
  ) async {
    final completer = Completer<config_pb.Config_NetworkConfig>();
    final sub = protocol.networkConfigStream.listen((c) {
      if (!completer.isCompleted) completer.complete(c);
    });
    await protocol.getConfig(
      admin.AdminMessage_ConfigType.NETWORK_CONFIG,
      target: target,
    );
    try {
      return await completer.future.timeout(const Duration(seconds: 12));
    } finally {
      await sub.cancel();
    }
  }

  @override
  Future<void> save(
    ProtocolService protocol,
    config_pb.Config_NetworkConfig config,
    AdminTarget target,
  ) => protocol.setConfig(config_pb.Config()..network = config, target: target);

  @override
  Map<String, dynamic> serialize(config_pb.Config_NetworkConfig config) =>
      _protoToJson(config);

  @override
  bool isEqual(
    config_pb.Config_NetworkConfig a,
    config_pb.Config_NetworkConfig b,
  ) => a == b;
}

class BluetoothConfigAdapter
    extends ConfigDomainAdapter<config_pb.Config_BluetoothConfig> {
  @override
  String get domainName => 'BLUETOOTH_CONFIG';

  @override
  Future<config_pb.Config_BluetoothConfig> load(
    ProtocolService protocol,
    AdminTarget target,
  ) async {
    final completer = Completer<config_pb.Config_BluetoothConfig>();
    final sub = protocol.bluetoothConfigStream.listen((c) {
      if (!completer.isCompleted) completer.complete(c);
    });
    await protocol.getConfig(
      admin.AdminMessage_ConfigType.BLUETOOTH_CONFIG,
      target: target,
    );
    try {
      return await completer.future.timeout(const Duration(seconds: 12));
    } finally {
      await sub.cancel();
    }
  }

  @override
  Future<void> save(
    ProtocolService protocol,
    config_pb.Config_BluetoothConfig config,
    AdminTarget target,
  ) => protocol.setConfig(
    config_pb.Config()..bluetooth = config,
    target: target,
  );

  @override
  Map<String, dynamic> serialize(config_pb.Config_BluetoothConfig config) =>
      _protoToJson(config);

  @override
  bool isEqual(
    config_pb.Config_BluetoothConfig a,
    config_pb.Config_BluetoothConfig b,
  ) => a == b;
}

class DisplayConfigAdapter
    extends ConfigDomainAdapter<config_pb.Config_DisplayConfig> {
  @override
  String get domainName => 'DISPLAY_CONFIG';

  @override
  Future<config_pb.Config_DisplayConfig> load(
    ProtocolService protocol,
    AdminTarget target,
  ) async {
    final completer = Completer<config_pb.Config_DisplayConfig>();
    final sub = protocol.displayConfigStream.listen((c) {
      if (!completer.isCompleted) completer.complete(c);
    });
    await protocol.getConfig(
      admin.AdminMessage_ConfigType.DISPLAY_CONFIG,
      target: target,
    );
    try {
      return await completer.future.timeout(const Duration(seconds: 12));
    } finally {
      await sub.cancel();
    }
  }

  @override
  Future<void> save(
    ProtocolService protocol,
    config_pb.Config_DisplayConfig config,
    AdminTarget target,
  ) => protocol.setConfig(config_pb.Config()..display = config, target: target);

  @override
  Map<String, dynamic> serialize(config_pb.Config_DisplayConfig config) =>
      _protoToJson(config);

  @override
  bool isEqual(
    config_pb.Config_DisplayConfig a,
    config_pb.Config_DisplayConfig b,
  ) => a == b;
}

class SecurityConfigAdapter
    extends ConfigDomainAdapter<config_pb.Config_SecurityConfig> {
  @override
  String get domainName => 'SECURITY_CONFIG';

  @override
  Future<config_pb.Config_SecurityConfig> load(
    ProtocolService protocol,
    AdminTarget target,
  ) async {
    final completer = Completer<config_pb.Config_SecurityConfig>();
    final sub = protocol.securityConfigStream.listen((c) {
      if (!completer.isCompleted) completer.complete(c);
    });
    await protocol.getConfig(
      admin.AdminMessage_ConfigType.SECURITY_CONFIG,
      target: target,
    );
    try {
      return await completer.future.timeout(const Duration(seconds: 12));
    } finally {
      await sub.cancel();
    }
  }

  @override
  Future<void> save(
    ProtocolService protocol,
    config_pb.Config_SecurityConfig config,
    AdminTarget target,
  ) =>
      protocol.setConfig(config_pb.Config()..security = config, target: target);

  @override
  Map<String, dynamic> serialize(config_pb.Config_SecurityConfig config) =>
      _protoToJson(config);

  @override
  bool isEqual(
    config_pb.Config_SecurityConfig a,
    config_pb.Config_SecurityConfig b,
  ) => a == b;
}

// ---------------------------------------------------------------------------
// Module config adapters (11 module config types)
// ---------------------------------------------------------------------------

class MqttConfigAdapter
    extends ConfigDomainAdapter<module_pb.ModuleConfig_MQTTConfig> {
  @override
  String get domainName => 'MQTT_CONFIG';

  @override
  Future<module_pb.ModuleConfig_MQTTConfig> load(
    ProtocolService protocol,
    AdminTarget target,
  ) async {
    final completer = Completer<module_pb.ModuleConfig_MQTTConfig>();
    final sub = protocol.mqttConfigStream.listen((c) {
      if (!completer.isCompleted) completer.complete(c);
    });
    await protocol.getModuleConfig(
      admin.AdminMessage_ModuleConfigType.MQTT_CONFIG,
      target: target,
    );
    try {
      return await completer.future.timeout(const Duration(seconds: 12));
    } finally {
      await sub.cancel();
    }
  }

  @override
  Future<void> save(
    ProtocolService protocol,
    module_pb.ModuleConfig_MQTTConfig config,
    AdminTarget target,
  ) => protocol.setModuleConfig(
    module_pb.ModuleConfig()..mqtt = config,
    target: target,
  );

  @override
  Map<String, dynamic> serialize(module_pb.ModuleConfig_MQTTConfig config) =>
      _protoToJson(config);

  @override
  bool isEqual(
    module_pb.ModuleConfig_MQTTConfig a,
    module_pb.ModuleConfig_MQTTConfig b,
  ) => a == b;
}

class TelemetryConfigAdapter
    extends ConfigDomainAdapter<module_pb.ModuleConfig_TelemetryConfig> {
  @override
  String get domainName => 'TELEMETRY_CONFIG';

  @override
  Future<module_pb.ModuleConfig_TelemetryConfig> load(
    ProtocolService protocol,
    AdminTarget target,
  ) async {
    final completer = Completer<module_pb.ModuleConfig_TelemetryConfig>();
    final sub = protocol.telemetryConfigStream.listen((c) {
      if (!completer.isCompleted) completer.complete(c);
    });
    await protocol.getModuleConfig(
      admin.AdminMessage_ModuleConfigType.TELEMETRY_CONFIG,
      target: target,
    );
    try {
      return await completer.future.timeout(const Duration(seconds: 12));
    } finally {
      await sub.cancel();
    }
  }

  @override
  Future<void> save(
    ProtocolService protocol,
    module_pb.ModuleConfig_TelemetryConfig config,
    AdminTarget target,
  ) => protocol.setModuleConfig(
    module_pb.ModuleConfig()..telemetry = config,
    target: target,
  );

  @override
  Map<String, dynamic> serialize(
    module_pb.ModuleConfig_TelemetryConfig config,
  ) => _protoToJson(config);

  @override
  bool isEqual(
    module_pb.ModuleConfig_TelemetryConfig a,
    module_pb.ModuleConfig_TelemetryConfig b,
  ) => a == b;
}

class PaxCounterConfigAdapter
    extends ConfigDomainAdapter<module_pb.ModuleConfig_PaxcounterConfig> {
  @override
  String get domainName => 'PAXCOUNTER_CONFIG';

  @override
  Future<module_pb.ModuleConfig_PaxcounterConfig> load(
    ProtocolService protocol,
    AdminTarget target,
  ) async {
    final completer = Completer<module_pb.ModuleConfig_PaxcounterConfig>();
    final sub = protocol.paxCounterConfigStream.listen((c) {
      if (!completer.isCompleted) completer.complete(c);
    });
    await protocol.getModuleConfig(
      admin.AdminMessage_ModuleConfigType.PAXCOUNTER_CONFIG,
      target: target,
    );
    try {
      return await completer.future.timeout(const Duration(seconds: 12));
    } finally {
      await sub.cancel();
    }
  }

  @override
  Future<void> save(
    ProtocolService protocol,
    module_pb.ModuleConfig_PaxcounterConfig config,
    AdminTarget target,
  ) => protocol.setModuleConfig(
    module_pb.ModuleConfig()..paxcounter = config,
    target: target,
  );

  @override
  Map<String, dynamic> serialize(
    module_pb.ModuleConfig_PaxcounterConfig config,
  ) => _protoToJson(config);

  @override
  bool isEqual(
    module_pb.ModuleConfig_PaxcounterConfig a,
    module_pb.ModuleConfig_PaxcounterConfig b,
  ) => a == b;
}

class SerialConfigAdapter
    extends ConfigDomainAdapter<module_pb.ModuleConfig_SerialConfig> {
  @override
  String get domainName => 'SERIAL_CONFIG';

  @override
  Future<module_pb.ModuleConfig_SerialConfig> load(
    ProtocolService protocol,
    AdminTarget target,
  ) async {
    final completer = Completer<module_pb.ModuleConfig_SerialConfig>();
    final sub = protocol.serialConfigStream.listen((c) {
      if (!completer.isCompleted) completer.complete(c);
    });
    await protocol.getModuleConfig(
      admin.AdminMessage_ModuleConfigType.SERIAL_CONFIG,
      target: target,
    );
    try {
      return await completer.future.timeout(const Duration(seconds: 12));
    } finally {
      await sub.cancel();
    }
  }

  @override
  Future<void> save(
    ProtocolService protocol,
    module_pb.ModuleConfig_SerialConfig config,
    AdminTarget target,
  ) => protocol.setModuleConfig(
    module_pb.ModuleConfig()..serial = config,
    target: target,
  );

  @override
  Map<String, dynamic> serialize(module_pb.ModuleConfig_SerialConfig config) =>
      _protoToJson(config);

  @override
  bool isEqual(
    module_pb.ModuleConfig_SerialConfig a,
    module_pb.ModuleConfig_SerialConfig b,
  ) => a == b;
}

class RangeTestConfigAdapter
    extends ConfigDomainAdapter<module_pb.ModuleConfig_RangeTestConfig> {
  @override
  String get domainName => 'RANGETEST_CONFIG';

  @override
  Future<module_pb.ModuleConfig_RangeTestConfig> load(
    ProtocolService protocol,
    AdminTarget target,
  ) async {
    final completer = Completer<module_pb.ModuleConfig_RangeTestConfig>();
    final sub = protocol.rangeTestConfigStream.listen((c) {
      if (!completer.isCompleted) completer.complete(c);
    });
    await protocol.getModuleConfig(
      admin.AdminMessage_ModuleConfigType.RANGETEST_CONFIG,
      target: target,
    );
    try {
      return await completer.future.timeout(const Duration(seconds: 12));
    } finally {
      await sub.cancel();
    }
  }

  @override
  Future<void> save(
    ProtocolService protocol,
    module_pb.ModuleConfig_RangeTestConfig config,
    AdminTarget target,
  ) => protocol.setModuleConfig(
    module_pb.ModuleConfig()..rangeTest = config,
    target: target,
  );

  @override
  Map<String, dynamic> serialize(
    module_pb.ModuleConfig_RangeTestConfig config,
  ) => _protoToJson(config);

  @override
  bool isEqual(
    module_pb.ModuleConfig_RangeTestConfig a,
    module_pb.ModuleConfig_RangeTestConfig b,
  ) => a == b;
}

class ExtNotifConfigAdapter
    extends
        ConfigDomainAdapter<module_pb.ModuleConfig_ExternalNotificationConfig> {
  @override
  String get domainName => 'EXTNOTIF_CONFIG';

  @override
  Future<module_pb.ModuleConfig_ExternalNotificationConfig> load(
    ProtocolService protocol,
    AdminTarget target,
  ) async {
    final completer =
        Completer<module_pb.ModuleConfig_ExternalNotificationConfig>();
    final sub = protocol.externalNotificationConfigStream.listen((c) {
      if (!completer.isCompleted) completer.complete(c);
    });
    await protocol.getModuleConfig(
      admin.AdminMessage_ModuleConfigType.EXTNOTIF_CONFIG,
      target: target,
    );
    try {
      return await completer.future.timeout(const Duration(seconds: 12));
    } finally {
      await sub.cancel();
    }
  }

  @override
  Future<void> save(
    ProtocolService protocol,
    module_pb.ModuleConfig_ExternalNotificationConfig config,
    AdminTarget target,
  ) => protocol.setModuleConfig(
    module_pb.ModuleConfig()..externalNotification = config,
    target: target,
  );

  @override
  Map<String, dynamic> serialize(
    module_pb.ModuleConfig_ExternalNotificationConfig config,
  ) => _protoToJson(config);

  @override
  bool isEqual(
    module_pb.ModuleConfig_ExternalNotificationConfig a,
    module_pb.ModuleConfig_ExternalNotificationConfig b,
  ) => a == b;
}

class StoreForwardConfigAdapter
    extends ConfigDomainAdapter<module_pb.ModuleConfig_StoreForwardConfig> {
  @override
  String get domainName => 'STOREFORWARD_CONFIG';

  @override
  Future<module_pb.ModuleConfig_StoreForwardConfig> load(
    ProtocolService protocol,
    AdminTarget target,
  ) async {
    final completer = Completer<module_pb.ModuleConfig_StoreForwardConfig>();
    final sub = protocol.storeForwardConfigStream.listen((c) {
      if (!completer.isCompleted) completer.complete(c);
    });
    await protocol.getModuleConfig(
      admin.AdminMessage_ModuleConfigType.STOREFORWARD_CONFIG,
      target: target,
    );
    try {
      return await completer.future.timeout(const Duration(seconds: 12));
    } finally {
      await sub.cancel();
    }
  }

  @override
  Future<void> save(
    ProtocolService protocol,
    module_pb.ModuleConfig_StoreForwardConfig config,
    AdminTarget target,
  ) => protocol.setModuleConfig(
    module_pb.ModuleConfig()..storeForward = config,
    target: target,
  );

  @override
  Map<String, dynamic> serialize(
    module_pb.ModuleConfig_StoreForwardConfig config,
  ) => _protoToJson(config);

  @override
  bool isEqual(
    module_pb.ModuleConfig_StoreForwardConfig a,
    module_pb.ModuleConfig_StoreForwardConfig b,
  ) => a == b;
}

class CannedMsgConfigAdapter
    extends ConfigDomainAdapter<module_pb.ModuleConfig_CannedMessageConfig> {
  @override
  String get domainName => 'CANNEDMSG_CONFIG';

  @override
  Future<module_pb.ModuleConfig_CannedMessageConfig> load(
    ProtocolService protocol,
    AdminTarget target,
  ) async {
    final completer = Completer<module_pb.ModuleConfig_CannedMessageConfig>();
    final sub = protocol.cannedMessageConfigStream.listen((c) {
      if (!completer.isCompleted) completer.complete(c);
    });
    await protocol.getModuleConfig(
      admin.AdminMessage_ModuleConfigType.CANNEDMSG_CONFIG,
      target: target,
    );
    try {
      return await completer.future.timeout(const Duration(seconds: 12));
    } finally {
      await sub.cancel();
    }
  }

  @override
  Future<void> save(
    ProtocolService protocol,
    module_pb.ModuleConfig_CannedMessageConfig config,
    AdminTarget target,
  ) => protocol.setModuleConfig(
    module_pb.ModuleConfig()..cannedMessage = config,
    target: target,
  );

  @override
  Map<String, dynamic> serialize(
    module_pb.ModuleConfig_CannedMessageConfig config,
  ) => _protoToJson(config);

  @override
  bool isEqual(
    module_pb.ModuleConfig_CannedMessageConfig a,
    module_pb.ModuleConfig_CannedMessageConfig b,
  ) => a == b;
}

class AmbientLightingConfigAdapter
    extends ConfigDomainAdapter<module_pb.ModuleConfig_AmbientLightingConfig> {
  @override
  String get domainName => 'AMBIENTLIGHTING_CONFIG';

  @override
  Future<module_pb.ModuleConfig_AmbientLightingConfig> load(
    ProtocolService protocol,
    AdminTarget target,
  ) async {
    final completer = Completer<module_pb.ModuleConfig_AmbientLightingConfig>();
    final sub = protocol.ambientLightingConfigStream.listen((c) {
      if (!completer.isCompleted) completer.complete(c);
    });
    await protocol.getModuleConfig(
      admin.AdminMessage_ModuleConfigType.AMBIENTLIGHTING_CONFIG,
      target: target,
    );
    try {
      return await completer.future.timeout(const Duration(seconds: 12));
    } finally {
      await sub.cancel();
    }
  }

  @override
  Future<void> save(
    ProtocolService protocol,
    module_pb.ModuleConfig_AmbientLightingConfig config,
    AdminTarget target,
  ) => protocol.setModuleConfig(
    module_pb.ModuleConfig()..ambientLighting = config,
    target: target,
  );

  @override
  Map<String, dynamic> serialize(
    module_pb.ModuleConfig_AmbientLightingConfig config,
  ) => _protoToJson(config);

  @override
  bool isEqual(
    module_pb.ModuleConfig_AmbientLightingConfig a,
    module_pb.ModuleConfig_AmbientLightingConfig b,
  ) => a == b;
}

class DetectionSensorConfigAdapter
    extends ConfigDomainAdapter<module_pb.ModuleConfig_DetectionSensorConfig> {
  @override
  String get domainName => 'DETECTIONSENSOR_CONFIG';

  @override
  Future<module_pb.ModuleConfig_DetectionSensorConfig> load(
    ProtocolService protocol,
    AdminTarget target,
  ) async {
    final completer = Completer<module_pb.ModuleConfig_DetectionSensorConfig>();
    final sub = protocol.detectionSensorConfigStream.listen((c) {
      if (!completer.isCompleted) completer.complete(c);
    });
    await protocol.getModuleConfig(
      admin.AdminMessage_ModuleConfigType.DETECTIONSENSOR_CONFIG,
      target: target,
    );
    try {
      return await completer.future.timeout(const Duration(seconds: 12));
    } finally {
      await sub.cancel();
    }
  }

  @override
  Future<void> save(
    ProtocolService protocol,
    module_pb.ModuleConfig_DetectionSensorConfig config,
    AdminTarget target,
  ) => protocol.setModuleConfig(
    module_pb.ModuleConfig()..detectionSensor = config,
    target: target,
  );

  @override
  Map<String, dynamic> serialize(
    module_pb.ModuleConfig_DetectionSensorConfig config,
  ) => _protoToJson(config);

  @override
  bool isEqual(
    module_pb.ModuleConfig_DetectionSensorConfig a,
    module_pb.ModuleConfig_DetectionSensorConfig b,
  ) => a == b;
}

class TrafficManagementConfigAdapter
    extends
        ConfigDomainAdapter<module_pb.ModuleConfig_TrafficManagementConfig> {
  @override
  String get domainName => 'TRAFFICMANAGEMENT_CONFIG';

  @override
  Future<module_pb.ModuleConfig_TrafficManagementConfig> load(
    ProtocolService protocol,
    AdminTarget target,
  ) async {
    final completer =
        Completer<module_pb.ModuleConfig_TrafficManagementConfig>();
    final sub = protocol.trafficManagementConfigStream.listen((c) {
      if (!completer.isCompleted) completer.complete(c);
    });
    await protocol.getModuleConfig(
      admin.AdminMessage_ModuleConfigType.TRAFFICMANAGEMENT_CONFIG,
      target: target,
    );
    try {
      return await completer.future.timeout(const Duration(seconds: 12));
    } finally {
      await sub.cancel();
    }
  }

  @override
  Future<void> save(
    ProtocolService protocol,
    module_pb.ModuleConfig_TrafficManagementConfig config,
    AdminTarget target,
  ) => protocol.setModuleConfig(
    module_pb.ModuleConfig()..trafficManagement = config,
    target: target,
  );

  @override
  Map<String, dynamic> serialize(
    module_pb.ModuleConfig_TrafficManagementConfig config,
  ) => _protoToJson(config);

  @override
  bool isEqual(
    module_pb.ModuleConfig_TrafficManagementConfig a,
    module_pb.ModuleConfig_TrafficManagementConfig b,
  ) => a == b;
}

// ---------------------------------------------------------------------------
// Channel adapter (ChannelConfig is a plain Dart class, NOT a protobuf)
// ---------------------------------------------------------------------------

class ChannelConfigAdapter extends ConfigDomainAdapter<ChannelConfig> {
  final int channelIndex;

  ChannelConfigAdapter({required this.channelIndex});

  @override
  String get domainName => 'CHANNEL_$channelIndex';

  @override
  Future<ChannelConfig> load(
    ProtocolService protocol,
    AdminTarget target,
  ) async {
    final completer = Completer<ChannelConfig>();
    final sub = protocol.channelStream.listen((c) {
      if (c.index == channelIndex && !completer.isCompleted) {
        completer.complete(c);
      }
    });
    await protocol.getChannel(channelIndex);
    try {
      return await completer.future.timeout(const Duration(seconds: 12));
    } finally {
      await sub.cancel();
    }
  }

  @override
  Future<void> save(
    ProtocolService protocol,
    ChannelConfig config,
    AdminTarget target,
  ) => protocol.setChannel(config);

  @override
  Map<String, dynamic> serialize(ChannelConfig config) => {
    'index': config.index,
    'name': config.name,
    'role': config.role,
    'uplink': config.uplink,
    'downlink': config.downlink,
    'positionPrecision': config.positionPrecision,
  };

  @override
  bool isEqual(ChannelConfig a, ChannelConfig b) =>
      a.index == b.index &&
      a.name == b.name &&
      a.role == b.role &&
      a.uplink == b.uplink &&
      a.downlink == b.downlink &&
      a.positionPrecision == b.positionPrecision;
}

// ---------------------------------------------------------------------------
// Registry of all domain adapters
// ---------------------------------------------------------------------------

/// Returns the canonical ordered list of all config domain adapters.
List<ConfigDomainAdapter<dynamic>> buildAllAdapters() => [
  // 8 core configs
  DeviceConfigAdapter(),
  LoRaConfigAdapter(),
  PositionConfigAdapter(),
  PowerConfigAdapter(),
  NetworkConfigAdapter(),
  BluetoothConfigAdapter(),
  DisplayConfigAdapter(),
  SecurityConfigAdapter(),
  // 11 module configs
  MqttConfigAdapter(),
  TelemetryConfigAdapter(),
  PaxCounterConfigAdapter(),
  SerialConfigAdapter(),
  RangeTestConfigAdapter(),
  ExtNotifConfigAdapter(),
  StoreForwardConfigAdapter(),
  CannedMsgConfigAdapter(),
  AmbientLightingConfigAdapter(),
  DetectionSensorConfigAdapter(),
  TrafficManagementConfigAdapter(),
  // Channel 0 (PRIMARY)
  ChannelConfigAdapter(channelIndex: 0),
];

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

Map<String, dynamic> _protoToJson(dynamic proto) {
  try {
    return (proto.toProto3Json() as Map<String, dynamic>?) ?? {};
  } catch (_) {
    return {'_raw': proto.toString()};
  }
}
