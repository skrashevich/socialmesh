// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/l10n/l10n_extension.dart';
import '../../../core/logging.dart';
import '../../../core/safety/lifecycle_mixin.dart';
import '../../../core/widgets/app_bottom_sheet.dart';
import '../../../utils/snackbar.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/animations.dart';
import '../../../core/widgets/glass_scaffold.dart';
import '../../../providers/app_providers.dart';
import '../../../services/haptic_service.dart';
import '../../../services/protocol/admin_target.dart';
import '../diagnostics/models/diagnostic_event.dart';
import '../diagnostics/models/diagnostic_run.dart';
import '../diagnostics/models/diagnostic_summary.dart';
import '../diagnostics/services/diagnostic_capture_service.dart';
import '../diagnostics/services/diagnostic_export_service.dart';
import '../diagnostics/services/diagnostic_probe.dart';
import '../diagnostics/services/diagnostic_probe_registry.dart';
import '../diagnostics/services/diagnostic_runner.dart';

/// Admin Diagnostic Harness screen.
///
/// Runs deterministic read-only probes against a connected Meshtastic device
/// (local or remote) and exports an LLM-friendly diagnostic bundle.
class AdminDiagnosticsScreen extends ConsumerStatefulWidget {
  const AdminDiagnosticsScreen({super.key});

  @override
  ConsumerState<AdminDiagnosticsScreen> createState() =>
      _AdminDiagnosticsScreenState();
}

class _AdminDiagnosticsScreenState extends ConsumerState<AdminDiagnosticsScreen>
    with LifecycleSafeMixin<AdminDiagnosticsScreen> {
  bool _includeStressTests = false;
  bool _includeWriteTests = false;
  bool _isRunning = false;
  bool _hasResults = false;
  String _currentProbe = '';
  int _completedProbes = 0;
  int _totalProbes = 0;
  int _passCount = 0;
  int _failCount = 0;

  DiagnosticRunner? _runner;
  DiagnosticCaptureService? _capture;
  DiagnosticRun? _diagnosticRun;
  List<ProbeSummaryEntry>? _probeResults;
  DiagnosticSummary? _summary;

  @override
  Widget build(BuildContext context) {
    final myNodeNum = ref.watch(myNodeNumProvider);
    final remoteTarget = ref.watch(remoteAdminTargetProvider);
    final isRemote = remoteTarget != null;
    final l10n = context.l10n;
    final targetLabel = isRemote
        ? l10n.adminDiagTargetRemote(
            remoteTarget.toRadixString(16).toUpperCase(),
          )
        : l10n.adminDiagTargetLocal;

    return GlassScaffold(
      title: l10n.adminDiagTitle,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Description
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing12),
                decoration: BoxDecoration(
                  color: context.card,
                  borderRadius: BorderRadius.circular(AppTheme.radius12),
                  border: Border.all(color: context.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.biotech,
                          color: context.accentColor,
                          size: 20,
                        ),
                        const SizedBox(width: AppTheme.spacing8),
                        Expanded(
                          child: Text(
                            l10n.adminDiagDescription,
                            style: TextStyle(
                              fontSize: 13,
                              color: context.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.spacing16),

              // Target info
              _buildInfoTile(
                context,
                icon: Icons.router,
                label: l10n.adminDiagTargetLabel,
                value: targetLabel,
              ),

              if (myNodeNum != null)
                _buildInfoTile(
                  context,
                  icon: Icons.tag,
                  label: l10n.adminDiagMyNodeLabel,
                  value: '0x${myNodeNum.toRadixString(16).toUpperCase()}',
                ),

              const SizedBox(height: AppTheme.spacing16),

              // Toggles
              _buildToggle(
                context,
                label: l10n.adminDiagStressToggle,
                subtitle: l10n.adminDiagStressToggleSub,
                value: _includeStressTests,
                enabled: !_isRunning,
                onChanged: (v) => setState(() => _includeStressTests = v),
              ),
              const SizedBox(height: AppTheme.spacing8),
              _buildToggle(
                context,
                label: l10n.adminDiagWriteToggle,
                subtitle: l10n.adminDiagWriteToggleSub,
                value: _includeWriteTests,
                enabled: !_isRunning,
                onChanged: (v) async {
                  if (v) {
                    final confirmed = await _confirmWriteTests(context);
                    if (!mounted) return;
                    if (!confirmed) return;
                  }
                  setState(() => _includeWriteTests = v);
                },
              ),

              const SizedBox(height: AppTheme.spacing24),

              // Run / Cancel button
              if (!_isRunning && !_hasResults)
                _buildRunButton(context, myNodeNum),

              // Progress
              if (_isRunning) _buildProgress(context),

              // Results
              if (_hasResults && _probeResults != null) _buildResults(context),

              SizedBox(
                height:
                    MediaQuery.of(context).padding.bottom + AppTheme.spacing16,
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: context.textSecondary),
          const SizedBox(width: AppTheme.spacing8),
          Text(
            '$label: ',
            style: TextStyle(fontSize: 13, color: context.textSecondary),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: context.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggle(
    BuildContext context, {
    required String label,
    required String subtitle,
    required bool value,
    required bool enabled,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing12,
        vertical: AppTheme.spacing8,
      ),
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: context.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: context.textPrimary,
                  ),
                ),
                const SizedBox(height: AppTheme.spacing2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: context.textSecondary),
                ),
              ],
            ),
          ),
          ThemedSwitch(value: value, onChanged: enabled ? onChanged : null),
        ],
      ),
    );
  }

  Widget _buildRunButton(BuildContext context, int? myNodeNum) {
    final connected = myNodeNum != null;
    final l10n = context.l10n;
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: connected ? () => _startDiagnostics() : null,
        icon: const Icon(Icons.play_arrow),
        label: Text(
          connected ? l10n.adminDiagRunButton : l10n.adminDiagNoDevice,
        ),
      ),
    );
  }

  Widget _buildProgress(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: context.accentColor,
              ),
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: Text(
                _currentProbe,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: context.textPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacing8),
        LinearProgressIndicator(
          value: _totalProbes > 0 ? _completedProbes / _totalProbes : 0,
          backgroundColor: context.border,
          color: context.accentColor,
        ),
        const SizedBox(height: AppTheme.spacing8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.l10n.adminDiagProbeProgress(
                _completedProbes,
                _totalProbes,
              ),
              style: TextStyle(fontSize: 12, color: context.textSecondary),
            ),
            Row(
              children: [
                _counterBadge(context, _passCount, Colors.green),
                const SizedBox(width: AppTheme.spacing4),
                _counterBadge(context, _failCount, Colors.red),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacing16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              _runner?.cancel();
              ref.haptics.buttonTap();
            },
            icon: const Icon(Icons.stop, size: 18),
            label: Text(context.l10n.adminDiagCancel),
          ),
        ),
      ],
    );
  }

  Widget _counterBadge(BuildContext context, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppTheme.radius8),
      ),
      child: Text(
        '$count',
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }

  Widget _buildResults(BuildContext context) {
    final results = _probeResults!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Summary header
        Container(
          padding: const EdgeInsets.all(AppTheme.spacing12),
          decoration: BoxDecoration(
            color: _failCount > 0
                ? Colors.red.withValues(alpha: 0.08)
                : Colors.green.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(AppTheme.radius12),
            border: Border.all(
              color: _failCount > 0
                  ? Colors.red.withValues(alpha: 0.3)
                  : Colors.green.withValues(alpha: 0.3),
            ),
          ),
          child: Row(
            children: [
              Icon(
                _failCount > 0
                    ? Icons.warning_amber
                    : Icons.check_circle_outline,
                color: _failCount > 0 ? Colors.red : Colors.green,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacing8),
              Text(
                context.l10n.adminDiagResultSummary(_passCount, _failCount),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppTheme.spacing12),

        // Probe list
        ...results.map((r) => _buildProbeRow(context, r)),

        const SizedBox(height: AppTheme.spacing16),

        // Export button
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: () => _exportBundle(context),
            icon: const Icon(Icons.ios_share),
            label: Text(context.l10n.adminDiagExportBundle),
          ),
        ),
        const SizedBox(height: AppTheme.spacing8),

        // Copy summary
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => _copySummaryToClipboard(context),
            icon: const Icon(Icons.copy, size: 18),
            label: Text(context.l10n.adminDiagCopySummary),
          ),
        ),
        const SizedBox(height: AppTheme.spacing8),

        // Run again
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            onPressed: () {
              ref.haptics.buttonTap();
              setState(() {
                _hasResults = false;
                _probeResults = null;
                _summary = null;
                _passCount = 0;
                _failCount = 0;
              });
            },
            icon: const Icon(Icons.refresh, size: 18),
            label: Text(context.l10n.adminDiagRunAgain),
          ),
        ),
      ],
    );
  }

  Widget _buildProbeRow(BuildContext context, ProbeSummaryEntry entry) {
    final color = switch (entry.status) {
      'pass' => Colors.green,
      'fail' => Colors.red,
      _ => Colors.orange,
    };
    final icon = switch (entry.status) {
      'pass' => Icons.check_circle,
      'fail' => Icons.cancel,
      _ => Icons.skip_next,
    };

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: AppTheme.spacing8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: context.textPrimary,
                  ),
                ),
                if (entry.errorExcerpt != null)
                  Text(
                    entry.errorExcerpt!,
                    style: const TextStyle(fontSize: 11, color: Colors.red),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          Text(
            '${entry.durationMs}ms',
            style: TextStyle(fontSize: 11, color: context.textSecondary),
          ),
        ],
      ),
    );
  }

  Future<bool> _confirmWriteTests(BuildContext context) async {
    final l10n = context.l10n;
    final result = await AppBottomSheet.showConfirm(
      context: context,
      title: l10n.adminDiagWriteTestsDialogTitle,
      message: l10n.adminDiagWriteTestsDialogBody,
      cancelLabel: l10n.adminDiagWriteTestsCancel,
      confirmLabel: l10n.adminDiagWriteTestsEnable,
    );
    return result ?? false;
  }

  Future<void> _startDiagnostics() async {
    final protocol = ref.read(protocolServiceProvider);
    final myNodeNum = ref.read(myNodeNumProvider);
    final haptics = ref.haptics;
    final remoteTarget = ref.read(remoteAdminTargetProvider);

    if (myNodeNum == null) return;

    await haptics.buttonTap();

    // Build target
    final target = remoteTarget != null
        ? AdminTarget.remote(remoteTarget)
        : const AdminTarget.local();

    // Gather environment info
    final packageInfo = await PackageInfo.fromPlatform();
    final deviceInfoPlugin = DeviceInfoPlugin();
    String osVersion;
    String deviceModel;
    if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      osVersion = '${iosInfo.systemName} ${iosInfo.systemVersion}';
      deviceModel = iosInfo.utsname.machine;
    } else {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      osVersion = 'Android ${androidInfo.version.release}';
      deviceModel = '${androidInfo.manufacturer} ${androidInfo.model}';
    }

    if (!mounted) return;

    // Determine transport type
    final connectedDevice = ref.read(connectedDeviceProvider);
    final transportType = connectedDevice?.type.name ?? 'unknown';

    // Get firmware info from node
    final nodes = ref.read(nodesProvider);
    final myNode = nodes[myNodeNum];
    final firmwareVersion = myNode?.firmwareVersion;
    final hardwareModel = myNode?.hardwareModel;

    // Build run
    final runId = DiagnosticRun.generateRunId();
    final run = DiagnosticRun(
      runId: runId,
      startedAt: DateTime.now().toUtc(),
      appVersion: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
      platform: Platform.operatingSystem,
      osVersion: osVersion,
      deviceModel: deviceModel,
      transport: transportType,
      myNodeNum: myNodeNum,
      target: DiagnosticTarget(
        mode: target.isLocal
            ? DiagnosticTargetMode.local
            : DiagnosticTargetMode.remote,
        targetNodeNum: target.isRemote ? target.resolve(myNodeNum) : null,
      ),
      firmwareVersion: firmwareVersion,
      hardwareModel: hardwareModel,
    );

    // Build probes
    final probes = DiagnosticProbeRegistry.build(
      includeStressTests: _includeStressTests,
      includeWriteTests: _includeWriteTests,
    );

    // Set up capture
    final capture = DiagnosticCaptureService();
    capture.start();

    // Record environment event
    capture.recordInternal(
      phase: DiagnosticPhase.env,
      probeName: 'environment',
      decoded: DecodedPayload(messageType: 'DiagnosticRun', json: run.toJson()),
      notes: 'Diagnostic run started',
    );

    final diagContext = DiagnosticContext(
      protocolService: protocol,
      target: target,
      myNodeNum: myNodeNum,
      runId: runId,
      capture: capture,
    );

    final runner = DiagnosticRunner(
      capture: capture,
      context: diagContext,
      probes: probes,
      onProgress: (probeName, completed, total, lastOutcome) {
        if (!mounted) return;
        setState(() {
          _currentProbe = probeName;
          _completedProbes = completed;
          _totalProbes = total;
          if (lastOutcome == ProbeOutcome.pass) _passCount++;
          if (lastOutcome == ProbeOutcome.fail) _failCount++;
        });
      },
    );

    setState(() {
      _isRunning = true;
      _hasResults = false;
      _runner = runner;
      _capture = capture;
      _diagnosticRun = run;
      _currentProbe = probes.first.name;
      _completedProbes = 0;
      _totalProbes = probes.length;
      _passCount = 0;
      _failCount = 0;
    });

    // Execute
    final results = await runner.run();

    if (!mounted) return;

    // Finalize run
    capture.stop();
    run.finishedAt = DateTime.now().toUtc();
    run.result = DiagnosticResultCounts(
      passed: results.where((r) => r.status == 'pass').length,
      failed: results.where((r) => r.status == 'fail').length,
      skipped: results.where((r) => r.status == 'skipped').length,
    );

    final summary = DiagnosticSummary.fromRun(run, results);

    setState(() {
      _isRunning = false;
      _hasResults = true;
      _probeResults = results;
      _summary = summary;
    });

    await haptics.trigger(
      _failCount > 0 ? HapticType.warning : HapticType.success,
    );

    AppLogging.adminDiag(
      'Diagnostics complete: $_passCount pass, $_failCount fail',
    );
  }

  Future<void> _exportBundle(BuildContext context) async {
    final haptics = ref.haptics;
    final l10n = context.l10n;
    final box = context.findRenderObject() as RenderBox?;
    final position = box != null
        ? box.localToGlobal(Offset.zero) & box.size
        : null;

    await haptics.buttonTap();

    if (_diagnosticRun == null || _capture == null || _summary == null) return;

    try {
      final zipPath = await DiagnosticExportService.buildZip(
        run: _diagnosticRun!,
        summary: _summary!,
        capture: _capture!,
      );

      if (!mounted) return;

      await DiagnosticExportService.share(
        zipPath: zipPath,
        runId: _diagnosticRun!.runId,
        sharePosition: position,
      );
    } catch (e) {
      if (!mounted) return;
      safeShowSnackBar(
        l10n.adminDiagExportFailed('$e'),
        type: SnackBarType.error,
      );
    }
  }

  Future<void> _copySummaryToClipboard(BuildContext context) async {
    final haptics = ref.haptics;
    final l10n = context.l10n;
    await haptics.buttonTap();

    if (_summary == null) return;

    await Clipboard.setData(ClipboardData(text: _summary!.toJsonString()));

    if (!mounted) return;
    safeShowSnackBar(l10n.adminDiagCopiedToClipboard);
  }
}
