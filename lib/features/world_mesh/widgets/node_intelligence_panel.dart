// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/l10n/l10n_extension.dart';
import '../../../core/theme.dart';
import '../../../models/world_mesh_node.dart';
import '../../../models/presence_confidence.dart';
import '../node_analytics_screen.dart';

/// Computed intelligence derived from WorldMeshNode data (mesh-observer snapshot)
class NodeIntelligenceData {
  final double healthScore; // 0-1 based on battery, uptime, last seen
  final double connectivityScore; // 0-1 based on neighbors, gateways
  final String mobilityClass; // Stationary, Mobile, Unknown
  final int neighborCount;
  final int gatewayCount;
  final String activityLevel; // Hot, Active, Quiet, Cold
  final double? channelUtilization;

  NodeIntelligenceData({
    required this.healthScore,
    required this.connectivityScore,
    required this.mobilityClass,
    required this.neighborCount,
    required this.gatewayCount,
    required this.activityLevel,
    this.channelUtilization,
  });

  /// Compute intelligence from WorldMeshNode data
  factory NodeIntelligenceData.fromNode(WorldMeshNode node) {
    // Health Score: based on battery, voltage, uptime, recency
    double health = 0;
    int healthFactors = 0;

    // Battery factor
    if (node.batteryLevel != null) {
      if (node.batteryLevel! > 100) {
        health += 1.0; // Plugged in = perfect
      } else {
        health += node.batteryLevel! / 100.0;
      }
      healthFactors++;
    }

    // Voltage factor (3.0V = dead, 4.2V = full for LiPo)
    if (node.voltage != null) {
      health += ((node.voltage! - 3.0) / 1.2).clamp(0.0, 1.0);
      healthFactors++;
    }

    // Recency factor
    switch (node.presenceConfidence) {
      case PresenceConfidence.active:
        health += 1.0;
        healthFactors++;
      case PresenceConfidence.fading:
        health += 0.7;
        healthFactors++;
      case PresenceConfidence.stale:
        health += 0.3;
        healthFactors++;
      case PresenceConfidence.unknown:
        health += 0.1;
        healthFactors++;
    }

    // Uptime factor (longer uptime = more stable)
    if (node.uptime != null) {
      // Uptime > 24h gets full score, scales down from there
      health += (node.uptime! / 86400.0).clamp(0.0, 1.0);
      healthFactors++;
    }

    final healthScore = healthFactors > 0 ? health / healthFactors : 0.5;

    // Connectivity Score: neighbors + gateways
    final neighborCount = node.neighbors?.length ?? 0;
    final gatewayCount = node.seenBy.length;

    double connectivity = 0;
    // Neighbors: 5+ is excellent
    connectivity += (neighborCount / 5.0).clamp(0.0, 1.0) * 0.5;
    // Gateways: 3+ is excellent
    connectivity += (gatewayCount / 3.0).clamp(0.0, 1.0) * 0.5;

    // Mobility classification
    String mobility = 'Unknown';
    if (node.role.toLowerCase().contains('router') ||
        node.role.toLowerCase().contains('repeater')) {
      mobility = 'Infrastructure';
    } else if (node.role.toLowerCase().contains('client')) {
      mobility = 'Mobile';
    } else if (node.role.toLowerCase().contains('tracker')) {
      mobility = 'Tracker';
    } else if (node.altitude != null && node.altitude! > 100) {
      mobility = 'Elevated';
    } else {
      mobility = 'Stationary';
    }

    // Activity level based on channel utilization and air time
    String activity = 'Unknown';
    final chUtil = node.chUtil;
    final airUtil = node.airUtilTx;

    if (chUtil != null || airUtil != null) {
      final avgUtil = ((chUtil ?? 0) + (airUtil ?? 0)) / 2;
      if (avgUtil > 50) {
        activity = 'Hot';
      } else if (avgUtil > 20) {
        activity = 'Active';
      } else if (avgUtil > 5) {
        activity = 'Quiet';
      } else {
        activity = 'Cold';
      }
    } else {
      switch (node.presenceConfidence) {
        case PresenceConfidence.active:
          activity = 'Active';
        case PresenceConfidence.fading:
          activity = 'Quiet';
        case PresenceConfidence.stale:
          activity = 'Cold';
        case PresenceConfidence.unknown:
          activity = 'Unknown';
      }
    }

    return NodeIntelligenceData(
      healthScore: healthScore,
      connectivityScore: connectivity,
      mobilityClass: mobility,
      neighborCount: neighborCount,
      gatewayCount: gatewayCount,
      activityLevel: activity,
      channelUtilization: chUtil,
    );
  }
}

/// A futuristic panel displaying computed mesh intelligence for a node
class NodeIntelligencePanel extends StatelessWidget {
  final WorldMeshNode node;
  final VoidCallback? onShowOnMap;

  const NodeIntelligencePanel({
    super.key,
    required this.node,
    this.onShowOnMap,
  });

  void _openAnalyticsScreen(BuildContext context) {
    HapticFeedback.mediumImpact();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            NodeAnalyticsScreen(node: node, onShowOnMap: onShowOnMap),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final intelligence = NodeIntelligenceData.fromNode(node);
    final theme = Theme.of(context);
    final accentColor = theme.colorScheme.primary;

    return GestureDetector(
      onTap: () => _openAnalyticsScreen(context),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppTheme.radius12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              theme,
              Icons.psychology,
              context.l10n.nodeIntelligenceTitle,
              context,
            ),
            const SizedBox(height: AppTheme.spacing12),

            // Primary metrics row - Health & Connectivity
            Row(
              children: [
                Expanded(
                  child: _IntelligenceGauge(
                    label: context.l10n.nodeIntelligenceHealth,
                    value: intelligence.healthScore,
                    icon: Icons.favorite,
                    color: _getHealthColor(intelligence.healthScore),
                  ),
                ),
                const SizedBox(width: AppTheme.spacing12),
                Expanded(
                  child: _IntelligenceGauge(
                    label: context.l10n.nodeIntelligenceConnectivity,
                    value: intelligence.connectivityScore,
                    icon: Icons.hub,
                    color: _getConnectivityColor(
                      intelligence.connectivityScore,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppTheme.spacing12),

            // Secondary metrics
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _IntelligenceChip(
                  icon: _getMobilityIcon(intelligence.mobilityClass),
                  label: _localizedMobility(
                    context,
                    intelligence.mobilityClass,
                  ),
                  color: _getMobilityColor(intelligence.mobilityClass),
                ),
                _IntelligenceChip(
                  icon: Icons.people,
                  label: context.l10n.nodeIntelligenceNeighborCount(
                    intelligence.neighborCount,
                  ),
                  color: intelligence.neighborCount > 5
                      ? AppTheme.successGreen
                      : intelligence.neighborCount > 0
                      ? AppTheme.warningYellow
                      : SemanticColors.disabled,
                ),
                _IntelligenceChip(
                  icon: Icons.wifi_tethering,
                  label: context.l10n.nodeIntelligenceGatewayCount(
                    intelligence.gatewayCount,
                  ),
                  color: intelligence.gatewayCount > 2
                      ? AppTheme.successGreen
                      : intelligence.gatewayCount > 0
                      ? AppTheme.warningYellow
                      : SemanticColors.disabled,
                ),
                _ActivityChip(activity: intelligence.activityLevel),
              ],
            ),

            // Channel utilization bar if available
            if (intelligence.channelUtilization != null) ...[
              const SizedBox(height: AppTheme.spacing12),
              _ChannelUtilizationBar(
                utilization: intelligence.channelUtilization!,
                accentColor: accentColor,
              ),
            ],

            // Tap hint
            const SizedBox(height: AppTheme.spacing12),
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radius16),
                  border: Border.all(color: accentColor.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.analytics, size: 14, color: accentColor),
                    const SizedBox(width: AppTheme.spacing6),
                    Text(
                      context.l10n.nodeIntelligenceTapHint,
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacing4),
                    Icon(Icons.chevron_right, size: 14, color: accentColor),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    ThemeData theme,
    IconData icon,
    String title,
    BuildContext context,
  ) {
    return Row(
      children: [
        Icon(icon, size: 16, color: theme.colorScheme.primary),
        const SizedBox(width: AppTheme.spacing8),
        Text(
          title,
          style: TextStyle(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: AccentColors.cyan.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(AppTheme.radius4),
          ),
          child: Text(
            context.l10n.nodeIntelligenceDerivedBadge,
            style: TextStyle(
              color: AccentColors.cyan,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Color _getHealthColor(double score) {
    if (score >= 0.8) return AppTheme.successGreen;
    if (score >= 0.5) return AppTheme.warningYellow;
    if (score >= 0.3) return AccentColors.orange;
    return AppTheme.errorRed;
  }

  Color _getConnectivityColor(double score) {
    if (score >= 0.7) return AppTheme.successGreen;
    if (score >= 0.4) return AppTheme.warningYellow;
    return AccentColors.orange;
  }

  IconData _getMobilityIcon(String mobility) {
    switch (mobility) {
      case 'Infrastructure':
        return Icons.cell_tower;
      case 'Mobile':
        return Icons.smartphone;
      case 'Tracker':
        return Icons.gps_fixed;
      case 'Elevated':
        return Icons.terrain;
      case 'Stationary':
        return Icons.location_on;
      default:
        return Icons.help_outline;
    }
  }

  Color _getMobilityColor(String mobility) {
    switch (mobility) {
      case 'Infrastructure':
        return AccentColors.purple;
      case 'Mobile':
        return AccentColors.teal;
      case 'Tracker':
        return AccentColors.orange;
      case 'Elevated':
        return AccentColors.blue;
      case 'Stationary':
        return AccentColors.slate;
      default:
        return SemanticColors.disabled;
    }
  }

  String _localizedMobility(BuildContext context, String mobility) {
    switch (mobility) {
      case 'Infrastructure':
        return context.l10n.nodeIntelligenceMobilityInfra;
      case 'Mobile':
        return context.l10n.nodeIntelligenceMobilityMobile;
      case 'Tracker':
        return context.l10n.nodeIntelligenceMobilityTracker;
      case 'Elevated':
        return context.l10n.nodeIntelligenceMobilityElevated;
      case 'Stationary':
        return context.l10n.nodeIntelligenceMobilityStationary;
      default:
        return context.l10n.nodeIntelligenceUnknown;
    }
  }
}

/// Circular gauge showing a 0-1 score with glow effect
class _IntelligenceGauge extends StatelessWidget {
  final String label;
  final double value;
  final IconData icon;
  final Color color;

  const _IntelligenceGauge({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: CustomPaint(
              painter: _GaugePainter(value: value, color: color),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 16, color: color),
                    Text(
                      '${(value * 100).toInt()}%',
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: AppTheme.spacing8),
          Text(
            label,
            style: TextStyle(color: context.textSecondary, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  final double value;
  final Color color;

  _GaugePainter({required this.value, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    // Background arc
    final bgPaint = Paint()
      ..color = color.withValues(alpha: 0.2)
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi * 0.75,
      math.pi * 1.5,
      false,
      bgPaint,
    );

    // Value arc with glow
    final glowPaint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final valuePaint = Paint()
      ..color = color
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final sweepAngle = math.pi * 1.5 * value;

    // Draw glow
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi * 0.75,
      sweepAngle,
      false,
      glowPaint,
    );

    // Draw value arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi * 0.75,
      sweepAngle,
      false,
      valuePaint,
    );
  }

  @override
  bool shouldRepaint(_GaugePainter oldDelegate) =>
      value != oldDelegate.value || color != oldDelegate.color;
}

/// Compact chip showing a single intelligence metric
class _IntelligenceChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _IntelligenceChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radius16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: AppTheme.spacing6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// Activity level chip with color coding
class _ActivityChip extends StatelessWidget {
  final String activity;

  const _ActivityChip({required this.activity});

  @override
  Widget build(BuildContext context) {
    final (icon, color) = _getActivityConfig();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radius16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: AppTheme.spacing6),
          Text(
            _localizedActivity(context),
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  (IconData, Color) _getActivityConfig() {
    switch (activity) {
      case 'Hot':
        return (Icons.local_fire_department, AppTheme.errorRed);
      case 'Active':
        return (Icons.bolt, AccentColors.orange);
      case 'Quiet':
        return (Icons.nights_stay, AccentColors.blue);
      case 'Cold':
        return (Icons.ac_unit, AccentColors.slate);
      default:
        return (Icons.help_outline, SemanticColors.disabled);
    }
  }

  String _localizedActivity(BuildContext context) {
    switch (activity) {
      case 'Hot':
        return context.l10n.nodeIntelligenceActivityHot;
      case 'Active':
        return context.l10n.nodeIntelligenceActivityActive;
      case 'Quiet':
        return context.l10n.nodeIntelligenceActivityQuiet;
      case 'Cold':
        return context.l10n.nodeIntelligenceActivityCold;
      default:
        return context.l10n.nodeIntelligenceUnknown;
    }
  }
}

/// Channel utilization progress bar
class _ChannelUtilizationBar extends StatelessWidget {
  final double utilization;
  final Color accentColor;

  const _ChannelUtilizationBar({
    required this.utilization,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = utilization > 50
        ? AppTheme.errorRed
        : utilization > 25
        ? AccentColors.orange
        : AppTheme.successGreen;

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing10),
      decoration: BoxDecoration(
        color: context.border.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: context.border.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.nodeIntelligenceChannelUtil,
                style: TextStyle(color: context.textSecondary, fontSize: 11),
              ),
              Text(
                '${utilization.toStringAsFixed(1)}%',
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing6),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppTheme.radius4),
            child: LinearProgressIndicator(
              value: utilization / 100,
              backgroundColor: color.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
