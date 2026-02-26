// SPDX-License-Identifier: GPL-3.0-or-later
import '../../../../generated/meshtastic/admin.pb.dart' as admin;
import '../../../../generated/meshtastic/config.pb.dart' as config_pb;
import '../../../../generated/meshtastic/module_config.pb.dart' as module_pb;
import 'diagnostic_probe.dart';
import 'probes/channel_probes.dart';
import 'probes/config_probes.dart';
import 'probes/env_probes.dart';
import 'probes/payload_probes.dart';
import 'probes/stress_probes.dart';
import 'probes/write_probes.dart';

/// Builds the ordered list of probes for a diagnostic run.
class DiagnosticProbeRegistry {
  /// Build the default read-only probe set.
  static List<DiagnosticProbe> buildReadOnlyProbes() {
    return [
      // Environment probes
      GetMyNodeInfoProbe(),
      GetDeviceMetadataProbe(),

      // Config probes — all 8 supported types
      GetConfigProbe(
        configType: admin.AdminMessage_ConfigType.DEVICE_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.deviceConfigStream,
      ),
      GetConfigProbe(
        configType: admin.AdminMessage_ConfigType.LORA_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.loraConfigStream,
      ),
      GetConfigProbe(
        configType: admin.AdminMessage_ConfigType.POSITION_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.positionConfigStream,
      ),
      GetConfigProbe(
        configType: admin.AdminMessage_ConfigType.POWER_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.powerConfigStream,
      ),
      GetConfigProbe(
        configType: admin.AdminMessage_ConfigType.NETWORK_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.networkConfigStream,
      ),
      GetConfigProbe(
        configType: admin.AdminMessage_ConfigType.BLUETOOTH_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.bluetoothConfigStream,
      ),
      GetConfigProbe(
        configType: admin.AdminMessage_ConfigType.DISPLAY_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.displayConfigStream,
      ),
      GetConfigProbe(
        configType: admin.AdminMessage_ConfigType.SECURITY_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.securityConfigStream,
      ),

      // Module config probes — all 11 supported types
      GetModuleConfigProbe(
        moduleType: admin.AdminMessage_ModuleConfigType.MQTT_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.mqttConfigStream,
      ),
      GetModuleConfigProbe(
        moduleType: admin.AdminMessage_ModuleConfigType.TELEMETRY_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.telemetryConfigStream,
      ),
      GetModuleConfigProbe(
        moduleType: admin.AdminMessage_ModuleConfigType.PAXCOUNTER_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.paxCounterConfigStream,
      ),
      GetModuleConfigProbe(
        moduleType: admin.AdminMessage_ModuleConfigType.SERIAL_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.serialConfigStream,
      ),
      GetModuleConfigProbe(
        moduleType: admin.AdminMessage_ModuleConfigType.RANGETEST_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.rangeTestConfigStream,
      ),
      GetModuleConfigProbe(
        moduleType: admin.AdminMessage_ModuleConfigType.EXTNOTIF_CONFIG,
        streamSelector: (ctx) =>
            ctx.protocolService.externalNotificationConfigStream,
      ),
      GetModuleConfigProbe(
        moduleType: admin.AdminMessage_ModuleConfigType.STOREFORWARD_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.storeForwardConfigStream,
      ),
      GetModuleConfigProbe(
        moduleType: admin.AdminMessage_ModuleConfigType.CANNEDMSG_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.cannedMessageConfigStream,
      ),
      GetModuleConfigProbe(
        moduleType: admin.AdminMessage_ModuleConfigType.AMBIENTLIGHTING_CONFIG,
        streamSelector: (ctx) =>
            ctx.protocolService.ambientLightingConfigStream,
      ),
      GetModuleConfigProbe(
        moduleType: admin.AdminMessage_ModuleConfigType.DETECTIONSENSOR_CONFIG,
        streamSelector: (ctx) =>
            ctx.protocolService.detectionSensorConfigStream,
      ),
      GetModuleConfigProbe(
        moduleType:
            admin.AdminMessage_ModuleConfigType.TRAFFICMANAGEMENT_CONFIG,
        streamSelector: (ctx) =>
            ctx.protocolService.trafficManagementConfigStream,
      ),

      // Large payload probes (read)
      GetCannedMessagesProbe(),
      GetRingtoneProbe(),

      // Channel probes — primary + first secondary
      GetChannelProbe(channelIndex: 0),
      GetChannelProbe(channelIndex: 1),
    ];
  }

  /// Build stress test probes (optional).
  static List<DiagnosticProbe> buildStressProbes() {
    return [BurstReadConfigsProbe(), OutOfOrderProbe()];
  }

  /// Build write test probes (optional, gated).
  ///
  /// Includes payload write probes (ringtone, canned messages) and
  /// config/module-config write-readback probes for all supported types.
  static List<DiagnosticProbe> buildWriteProbes() {
    return [
      // Payload write probes
      WriteRingtoneProbe(),
      WriteCannedMessagesProbe(),

      // Config write probes — all 8 types
      WriteConfigProbe(
        configType: admin.AdminMessage_ConfigType.DEVICE_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.deviceConfigStream,
        wrapInConfig: (v) => config_pb.Config()..device = v,
      ),
      WriteConfigProbe(
        configType: admin.AdminMessage_ConfigType.LORA_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.loraConfigStream,
        wrapInConfig: (v) => config_pb.Config()..lora = v,
      ),
      WriteConfigProbe(
        configType: admin.AdminMessage_ConfigType.POSITION_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.positionConfigStream,
        wrapInConfig: (v) => config_pb.Config()..position = v,
      ),
      WriteConfigProbe(
        configType: admin.AdminMessage_ConfigType.POWER_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.powerConfigStream,
        wrapInConfig: (v) => config_pb.Config()..power = v,
      ),
      WriteConfigProbe(
        configType: admin.AdminMessage_ConfigType.NETWORK_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.networkConfigStream,
        wrapInConfig: (v) => config_pb.Config()..network = v,
      ),
      WriteConfigProbe(
        configType: admin.AdminMessage_ConfigType.BLUETOOTH_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.bluetoothConfigStream,
        wrapInConfig: (v) => config_pb.Config()..bluetooth = v,
      ),
      WriteConfigProbe(
        configType: admin.AdminMessage_ConfigType.DISPLAY_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.displayConfigStream,
        wrapInConfig: (v) => config_pb.Config()..display = v,
      ),
      WriteConfigProbe(
        configType: admin.AdminMessage_ConfigType.SECURITY_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.securityConfigStream,
        wrapInConfig: (v) => config_pb.Config()..security = v,
      ),

      // Module config write probes — all 11 supported types
      WriteModuleConfigProbe(
        moduleType: admin.AdminMessage_ModuleConfigType.MQTT_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.mqttConfigStream,
        wrapInModuleConfig: (v) => module_pb.ModuleConfig()..mqtt = v,
      ),
      WriteModuleConfigProbe(
        moduleType: admin.AdminMessage_ModuleConfigType.TELEMETRY_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.telemetryConfigStream,
        wrapInModuleConfig: (v) => module_pb.ModuleConfig()..telemetry = v,
      ),
      WriteModuleConfigProbe(
        moduleType: admin.AdminMessage_ModuleConfigType.PAXCOUNTER_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.paxCounterConfigStream,
        wrapInModuleConfig: (v) => module_pb.ModuleConfig()..paxcounter = v,
      ),
      WriteModuleConfigProbe(
        moduleType: admin.AdminMessage_ModuleConfigType.SERIAL_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.serialConfigStream,
        wrapInModuleConfig: (v) => module_pb.ModuleConfig()..serial = v,
      ),
      WriteModuleConfigProbe(
        moduleType: admin.AdminMessage_ModuleConfigType.RANGETEST_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.rangeTestConfigStream,
        wrapInModuleConfig: (v) => module_pb.ModuleConfig()..rangeTest = v,
      ),
      WriteModuleConfigProbe(
        moduleType: admin.AdminMessage_ModuleConfigType.EXTNOTIF_CONFIG,
        streamSelector: (ctx) =>
            ctx.protocolService.externalNotificationConfigStream,
        wrapInModuleConfig: (v) =>
            module_pb.ModuleConfig()..externalNotification = v,
      ),
      WriteModuleConfigProbe(
        moduleType: admin.AdminMessage_ModuleConfigType.STOREFORWARD_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.storeForwardConfigStream,
        wrapInModuleConfig: (v) => module_pb.ModuleConfig()..storeForward = v,
      ),
      WriteModuleConfigProbe(
        moduleType: admin.AdminMessage_ModuleConfigType.CANNEDMSG_CONFIG,
        streamSelector: (ctx) => ctx.protocolService.cannedMessageConfigStream,
        wrapInModuleConfig: (v) => module_pb.ModuleConfig()..cannedMessage = v,
      ),
      WriteModuleConfigProbe(
        moduleType: admin.AdminMessage_ModuleConfigType.AMBIENTLIGHTING_CONFIG,
        streamSelector: (ctx) =>
            ctx.protocolService.ambientLightingConfigStream,
        wrapInModuleConfig: (v) =>
            module_pb.ModuleConfig()..ambientLighting = v,
      ),
      WriteModuleConfigProbe(
        moduleType: admin.AdminMessage_ModuleConfigType.DETECTIONSENSOR_CONFIG,
        streamSelector: (ctx) =>
            ctx.protocolService.detectionSensorConfigStream,
        wrapInModuleConfig: (v) =>
            module_pb.ModuleConfig()..detectionSensor = v,
      ),
      WriteModuleConfigProbe(
        moduleType:
            admin.AdminMessage_ModuleConfigType.TRAFFICMANAGEMENT_CONFIG,
        streamSelector: (ctx) =>
            ctx.protocolService.trafficManagementConfigStream,
        wrapInModuleConfig: (v) =>
            module_pb.ModuleConfig()..trafficManagement = v,
      ),
    ];
  }

  /// Build the full probe list based on options.
  static List<DiagnosticProbe> build({
    bool includeStressTests = false,
    bool includeWriteTests = false,
  }) {
    final probes = <DiagnosticProbe>[...buildReadOnlyProbes()];

    if (includeStressTests) {
      probes.addAll(buildStressProbes());
    }

    if (includeWriteTests) {
      probes.addAll(buildWriteProbes());
    }

    return probes;
  }
}
