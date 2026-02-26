// SPDX-License-Identifier: GPL-3.0-or-later
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/logging.dart';
import '../../../../core/safety/lifecycle_mixin.dart';
import '../../../../core/theme.dart';
import '../../../../core/widgets/animations.dart';
import '../../../../core/widgets/glass_scaffold.dart';
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

  ConformanceRunner? _runner;
  ConformanceRunResult? _runResult;

  @override
  Widget build(BuildContext context) {
    final myNodeNum = ref.watch(myNodeNumProvider);
    final remoteTarget = ref.watch(remoteAdminTargetProvider);
    final isRemote = remoteTarget != null;
    final targetLabel = isRemote
        ? 'Remote: 0x${remoteTarget.toRadixString(16).toUpperCase()}'
        : 'Local device';

    return GlassScaffold(
      title: 'Conformance Harness',
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Description
              _buildInfoCard(context, targetLabel),
              const SizedBox(height: AppTheme.spacing16),

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

  Widget _buildInfoCard(BuildContext context, String targetLabel) {
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
          Row(
            children: [
              Icon(Icons.verified, color: context.accentColor, size: 20),
              const SizedBox(width: AppTheme.spacing8),
              Expanded(
                child: Text(
                  'Provider-bound device conformance testing. '
                  'All mutations flow through the same provider '
                  'entrypoints used by the actual screens.',
                  style: TextStyle(fontSize: 13, color: context.textSecondary),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing8),
          Row(
            children: [
              Icon(Icons.device_hub, size: 16, color: context.textSecondary),
              const SizedBox(width: AppTheme.spacing4),
              Text(
                targetLabel,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: context.textPrimary,
                ),
              ),
            ],
          ),
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
            'Test Options',
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
                      'Destructive Tests',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: context.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacing2),
                    Text(
                      'Randomized mutations, burst stress, node DB reset. '
                      'May temporarily change device config.',
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
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: myNodeNum != null ? () => _startRun(myNodeNum) : null,
        icon: const Icon(Icons.play_arrow),
        label: Text(
          _destructiveMode
              ? 'Run Conformance (Destructive)'
              : 'Run Conformance (Safe)',
        ),
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
            '$_completedTests / $_totalTests  '
            '(pass: $_passCount, fail: $_failCount)',
            style: TextStyle(fontSize: 12, color: context.textSecondary),
          ),
          const SizedBox(height: AppTheme.spacing12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: _cancelRun,
              child: const Text('Cancel'),
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
                allPassed ? 'All Tests Passed' : 'Some Tests Failed',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: allPassed ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing8),
          _statRow(context, 'Passed', '${summary.passed}'),
          _statRow(context, 'Failed', '${summary.failed}'),
          _statRow(context, 'Skipped', '${summary.skipped}'),
          _statRow(context, 'Timeouts', '${summary.timeoutCount}'),
          if (summary.suspectedAnomalies.isNotEmpty) ...[
            const SizedBox(height: AppTheme.spacing8),
            Text(
              'Anomalies:',
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
            'Test Results',
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
        label: const Text('Export Bundle'),
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
        label: const Text('Run Again'),
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
    final remoteTarget = ref.read(remoteAdminTargetProvider);
    final target = AdminTarget.fromNullable(remoteTarget);

    safeSetState(() {
      _isRunning = true;
      _hasResults = false;
      _completedTests = 0;
      _totalTests = 0;
      _passCount = 0;
      _failCount = 0;
      _currentPhase = 'Initializing';
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
