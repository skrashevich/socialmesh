// SPDX-License-Identifier: GPL-3.0-or-later
import '../../../../generated/meshtastic/admin.pb.dart' as admin;
import 'diagnostic_probe.dart';
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

      // Config probes (read)
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

      // Module config probes (read)
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

      // Large payload probes (read)
      GetCannedMessagesProbe(),
      GetRingtoneProbe(),
    ];
  }

  /// Build stress test probes (optional).
  static List<DiagnosticProbe> buildStressProbes() {
    return [BurstReadConfigsProbe(), OutOfOrderProbe()];
  }

  /// Build write test probes (optional, gated).
  static List<DiagnosticProbe> buildWriteProbes() {
    return [WriteRingtoneProbe(), WriteCannedMessagesProbe()];
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
