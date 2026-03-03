// SPDX-License-Identifier: GPL-3.0-or-later
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/l10n_extension.dart';
import '../../../../core/logging.dart';
import '../../../../core/safety/lifecycle_mixin.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/animations.dart';
import '../../../../core/widgets/glass_scaffold.dart';
import '../../../../core/widgets/remote_admin_selector_sheet.dart';
import '../../../../providers/app_providers.dart';
import '../../../../services/haptic_service.dart';
import '../../../../services/protocol/admin_target.dart';
import '../conformance_exporter.dart';
import '../conformance_models.dart';
import '../conformance_runner.dart';

/// Admin Conformance Harness screen.
///
/// Runs deterministic provider-bound conformance tests against a
/// connected Meshtastic device (local or remote) and exports a
/// structured bundle with packet capture and provider state snapshots.
class AdminConformanceScreen extends ConsumerStatefulWidget {
  const AdminConformanceScreen({super.key});

  @override
  ConsumerState<AdminConformanceScreen> createState() =>
      _AdminConformanceScreenState();
}

class _AdminConformanceScreenState extends ConsumerState<AdminConformanceScreen>
    with LifecycleSafeMixin<AdminConformanceScreen> {
  bool _destructiveMode = false;
  bool _isRunning = false;
  bool _hasResults = false;
  String _currentPhase = '';
  String _currentTest = '';
  int _completedTests = 0;
  int _totalTests = 0;
  int _passCount = 0;
  int _failCount = 0;

  /// Local target selection — independent of global remoteAdminProvider.
  int? _selectedNodeNum;
  String? _selectedNodeName;

  ConformanceRunner? _runner;
  ConformanceRunResult? _runResult;

  /// Whether the conformance run targets a remote node.
  bool get _isRemoteTarget => _selectedNodeNum != null;

  /// Human-readable label for the current target.
  String get _targetLabel => _isRemoteTarget
      ? '0x${_selectedNodeNum!.toRadixString(16).toUpperCase()}'
            '${_selectedNodeName != null ? ' ($_selectedNodeName)' : ''}'
      : 'Local device';

  @override
  Widget build(BuildContext context) {
    final myNodeNum = ref.watch(myNodeNumProvider);

    return GlassScaffold(
      title: context.l10n.adminConformanceTitle,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Description
              _buildInfoCard(context),
              const SizedBox(height: AppTheme.spacing16),

              // Target selector
              if (!_isRunning && !_hasResults) ...[
                _buildTargetSelector(context),
                const SizedBox(height: AppTheme.spacing16),
              ],

              // Options
              if (!_isRunning && !_hasResults) ...[
                _buildOptionsCard(context),
                const SizedBox(height: AppTheme.spacing16),
              ],

              // Run button
              if (!_isRunning && !_hasResults)
                _buildRunButton(context, myNodeNum),

              // Progress
              if (_isRunning) _buildProgressCard(context),

              // Results
              if (_hasResults && _runResult != null) ...[
                _buildResultsSummary(context),
                const SizedBox(height: AppTheme.spacing16),
                _buildResultsList(context),
                const SizedBox(height: AppTheme.spacing16),
                _buildExportButton(context),
                const SizedBox(height: AppTheme.spacing16),
                _buildResetButton(context),
              ],
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: context.border),
      ),
      child: Row(
        children: [
          Icon(Icons.verified, color: context.accentColor, size: 20),
          const SizedBox(width: AppTheme.spacing8),
          Expanded(
            child: Text(
              context.l10n.adminConformanceDescription,
              style: TextStyle(fontSize: 13, color: context.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTargetSelector(BuildContext context) {
    final nodes = ref.watch(nodesProvider);
    final myNodeNum = ref.watch(myNodeNumProvider);

    // Filter to nodes with public keys (PKI-capable for remote admin)
    final adminableNodes = nodes.values.where((node) {
      if (node.nodeNum == myNodeNum) return false;
      return node.hasPublicKey;
    }).toList();

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: _isRemoteTarget
            ? context.accentColor.withValues(alpha: 0.08)
            : context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(
          color: _isRemoteTarget
              ? context.accentColor.withValues(alpha: 0.4)
              : context.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.adminConformanceTargetDevice,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: context.textPrimary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          InkWell(
            onTap: adminableNodes.isNotEmpty
                ? () => _showNodePicker(context)
                : null,
            borderRadius: BorderRadius.circular(AppTheme.radius8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing4),
              child: Row(
                children: [
                  Icon(
                    _isRemoteTarget
                        ? Icons.admin_panel_settings
                        : Icons.bluetooth_connected,
                    size: 20,
                    color: _isRemoteTarget
                        ? context.accentColor
                        : context.textSecondary,
                  ),
                  const SizedBox(width: AppTheme.spacing8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _isRemoteTarget
                              ? context.l10n.adminConformanceTargetRemote(
                                  _targetLabel,
                                )
                              : context.l10n.adminConformanceTargetLocal,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: context.textPrimary,
                          ),
                        ),
                        if (!_isRemoteTarget && adminableNodes.isNotEmpty)
                          Text(
                            context.l10n.adminConformanceNodesAvailable(
                              adminableNodes.length,
                            ),
                            style: TextStyle(
                              fontSize: 12,
                              color: context.textSecondary,
                            ),
                          ),
                        if (_isRemoteTarget)
                          Text(
                            context.l10n.adminConformanceOtaPki,
                            style: TextStyle(
                              fontSize: 12,
                              color: context.textSecondary,
                            ),
                          ),
                        if (adminableNodes.isEmpty)
                          Text(
                            context.l10n.adminConformanceNoNodes,
                            style: TextStyle(
                              fontSize: 12,
                              color: context.textTertiary,
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (adminableNodes.isNotEmpty)
                    Icon(
                      Icons.chevron_right,
                      size: 20,
                      color: context.textSecondary,
                    ),
                ],
              ),
            ),
          ),
          if (_isRemoteTarget) ...[
            const SizedBox(height: AppTheme.spacing8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  ref.haptics.buttonTap();
                  safeSetState(() {
                    _selectedNodeNum = null;
                    _selectedNodeName = null;
                  });
                },
                icon: const Icon(Icons.close, size: 16),
                label: Text(context.l10n.adminConformanceSwitchLocal),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppTheme.spacing4,
                  ),
                  textStyle: const TextStyle(fontSize: 13),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildOptionsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: context.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.adminConformanceTestOptions,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: context.textPrimary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.adminConformanceDestructive,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: context.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacing2),
                    Text(
                      context.l10n.adminConformanceDestructiveSub,
                      style: TextStyle(
                        fontSize: 12,
                        color: context.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              ThemedSwitch(
                value: _destructiveMode,
                onChanged: (v) {
                  ref.haptics.buttonTap();
                  safeSetState(() => _destructiveMode = v);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRunButton(BuildContext context, int? myNodeNum) {
    final l10n = context.l10n;
    final label = _isRemoteTarget
        ? _destructiveMode
              ? l10n.adminConformanceRunRemoteDestructive
              : l10n.adminConformanceRunRemoteSafe
        : _destructiveMode
        ? l10n.adminConformanceRunLocalDestructive
        : l10n.adminConformanceRunLocalSafe;

    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: myNodeNum != null ? () => _startRun(myNodeNum) : null,
        icon: Icon(_isRemoteTarget ? Icons.cell_tower : Icons.play_arrow),
        label: Text(label),
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
          backgroundColor: _destructiveMode ? Colors.red : context.accentColor,
        ),
      ),
    );
  }

  Widget _buildProgressCard(BuildContext context) {
    final progress = _totalTests > 0 ? _completedTests / _totalTests : 0.0;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
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
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: context.accentColor,
                ),
              ),
              const SizedBox(width: AppTheme.spacing8),
              Text(
                '$_currentPhase: $_currentTest',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: context.border,
            color: context.accentColor,
          ),
          const SizedBox(height: AppTheme.spacing4),
          Text(
            context.l10n.adminConformanceProgress(
              _completedTests,
              _totalTests,
              _passCount,
              _failCount,
            ),
            style: TextStyle(fontSize: 12, color: context.textSecondary),
          ),
          const SizedBox(height: AppTheme.spacing12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _cancelRun,
              child: Text(context.l10n.adminConformanceCancel),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsSummary(BuildContext context) {
    final summary = _runResult!.summary;
    final allPassed = summary.failed == 0;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: allPassed ? Colors.green : Colors.red),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                allPassed ? Icons.check_circle : Icons.error,
                color: allPassed ? Colors.green : Colors.red,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacing8),
              Text(
                allPassed
                    ? context.l10n.adminConformanceAllPassed
                    : context.l10n.adminConformanceSomeFailed,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: allPassed ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing8),
          _statRow(
            context,
            context.l10n.adminConformanceLabelPassed,
            '${summary.passed}',
          ),
          _statRow(
            context,
            context.l10n.adminConformanceLabelFailed,
            '${summary.failed}',
          ),
          _statRow(
            context,
            context.l10n.adminConformanceLabelSkipped,
            '${summary.skipped}',
          ),
          _statRow(
            context,
            context.l10n.adminConformanceLabelTimeouts,
            '${summary.timeoutCount}',
          ),
          if (summary.suspectedAnomalies.isNotEmpty) ...[
            const SizedBox(height: AppTheme.spacing8),
            Text(
              context.l10n.adminConformanceAnomalies,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.orange,
              ),
            ),
            for (final anomaly in summary.suspectedAnomalies)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  '- $anomaly',
                  style: TextStyle(fontSize: 12, color: context.textSecondary),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildResultsList(BuildContext context) {
    final results = _runResult!.summary.results;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: context.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.adminConformanceTestResults,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: context.textPrimary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          for (final r in results) _buildResultRow(context, r),
        ],
      ),
    );
  }

  Widget _buildResultRow(BuildContext context, ConformanceTestResult r) {
    final icon = switch (r.outcome) {
      ConformanceOutcome.pass => Icons.check_circle,
      ConformanceOutcome.fail => Icons.cancel,
      ConformanceOutcome.skipped => Icons.skip_next,
    };
    final color = switch (r.outcome) {
      ConformanceOutcome.pass => Colors.green,
      ConformanceOutcome.fail => Colors.red,
      ConformanceOutcome.skipped => context.textSecondary,
    };

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: AppTheme.spacing8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  r.name,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: context.textPrimary,
                  ),
                ),
                if (r.error != null)
                  Text(
                    r.error!,
                    style: const TextStyle(fontSize: 11, color: Colors.red),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
          Text(
            '${r.durationMs}ms',
            style: TextStyle(
              fontSize: 11,
              color: context.textSecondary,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: _exportResults,
        icon: const Icon(Icons.share),
        label: Text(context.l10n.adminConformanceExportBundle),
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
          backgroundColor: context.accentColor,
        ),
      ),
    );
  }

  Widget _buildResetButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: _resetResults,
        icon: const Icon(Icons.refresh),
        label: Text(context.l10n.adminConformanceRunAgain),
      ),
    );
  }

  Widget _statRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 13, color: context.textSecondary),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: context.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  // -----------------------------------------------------------------------
  // Actions
  // -----------------------------------------------------------------------

  Future<void> _startRun(int myNodeNum) async {
    final protocol = ref.read(protocolServiceProvider);
    final target = AdminTarget.fromNullable(_selectedNodeNum);
    final initLabel = context.l10n.adminConformanceInitializing;

    safeSetState(() {
      _isRunning = true;
      _hasResults = false;
      _completedTests = 0;
      _totalTests = 0;
      _passCount = 0;
      _failCount = 0;
      _currentPhase = initLabel;
      _currentTest = '';
    });

    final haptics = ref.haptics;
    await haptics.buttonTap();

    _runner = ConformanceRunner(
      protocolService: protocol,
      target: target,
      myNodeNum: myNodeNum,
      destructiveMode: _destructiveMode,
      onProgress: (phase, test, completed, total, outcome) {
        if (!mounted) return;
        safeSetState(() {
          _currentPhase = phase;
          _currentTest = test;
          _completedTests = completed;
          _totalTests = total;
          if (outcome == ConformanceOutcome.pass) _passCount++;
          if (outcome == ConformanceOutcome.fail) _failCount++;
        });
      },
    );

    try {
      final result = await _runner!.run();
      if (!mounted) return;
      safeSetState(() {
        _runResult = result;
        _isRunning = false;
        _hasResults = true;
      });
      await haptics.trigger(HapticType.success);
    } catch (e) {
      AppLogging.adminDiag('Conformance run failed: $e');
      if (mounted) {
        safeSetState(() {
          _isRunning = false;
        });
      }
      await haptics.trigger(HapticType.error);
    }
  }

  void _cancelRun() {
    _runner?.cancel();
    ref.haptics.buttonTap();
    safeSetState(() {
      _isRunning = false;
    });
  }

  Future<void> _exportResults() async {
    if (_runResult == null) return;

    // Capture context-dependent values before await
    final box = context.findRenderObject() as RenderBox?;
    final sharePosition = box != null
        ? box.localToGlobal(Offset.zero) & box.size
        : null;

    await ref.haptics.buttonTap();
    if (!mounted) return;

    try {
      await ConformanceExporter.share(
        _runResult!,
        sharePositionOrigin: sharePosition,
      );
    } catch (e) {
      AppLogging.adminDiag('Export failed: $e');
    }
  }

  Future<void> _showNodePicker(BuildContext context) async {
    unawaited(ref.haptics.buttonTap());

    final selection = await RemoteAdminSelectorSheet.show(
      context,
      currentTarget: _selectedNodeNum,
    );
    if (!mounted || selection == null) return;

    safeSetState(() {
      if (selection.isLocal) {
        _selectedNodeNum = null;
        _selectedNodeName = null;
      } else {
        _selectedNodeNum = selection.nodeNum;
        _selectedNodeName = selection.nodeName;
      }
    });
  }

  void _resetResults() {
    ref.haptics.buttonTap();
    safeSetState(() {
      _hasResults = false;
      _runResult = null;
      _completedTests = 0;
      _totalTests = 0;
      _passCount = 0;
      _failCount = 0;
    });
  }
}
