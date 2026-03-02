// SPDX-License-Identifier: GPL-3.0-or-later
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/l10n/l10n_extension.dart';
import '../../core/safety/lifecycle_mixin.dart';
import '../../core/theme.dart';
import '../../core/widgets/ico_help_system.dart';
import '../../core/widgets/mesh_globe.dart';
import '../../core/widgets/glass_scaffold.dart';
import '../../core/widgets/node_info_card.dart';
import '../../core/widgets/node_selector_sheet.dart';
import '../../providers/help_providers.dart';
import '../../models/mesh_models.dart';
import '../../providers/app_providers.dart';
import '../../providers/presence_providers.dart';
import '../messaging/messaging_screen.dart';

/// Screen showing the 3D mesh globe with node positions
class GlobeScreen extends ConsumerStatefulWidget {
  /// Optional node number to focus on initially
  final int? initialNodeNum;

  const GlobeScreen({super.key, this.initialNodeNum});

  @override
  ConsumerState<GlobeScreen> createState() => _GlobeScreenState();
}

class _GlobeScreenState extends ConsumerState<GlobeScreen>
    with LifecycleSafeMixin {
  final GlobalKey<MeshGlobeState> _globeKey = GlobalKey();
  MeshNode? _selectedNode;
  bool _showConnections = true;

  @override
  void initState() {
    super.initState();
    // Focus on initial node after a short delay to let globe initialize
    if (widget.initialNodeNum != null) {
      Future.delayed(const Duration(milliseconds: 500), () {
        _focusOnNode(widget.initialNodeNum!);
      });
    }
  }

  void _focusOnNode(int nodeNum) {
    final nodes = ref.read(nodesProvider);
    final node = nodes[nodeNum];
    if (node != null && node.hasPosition) {
      _globeKey.currentState?.rotateToNode(node);
      safeSetState(() {
        _selectedNode = node;
      });
    }
  }

  void _onNodeSelected(MeshNode node) {
    // Rotate to the node first
    _globeKey.currentState?.rotateToNode(node);
    // Show the info card after a brief delay to let the rotation start
    Future.delayed(const Duration(milliseconds: 100), () {
      safeSetState(() {
        _selectedNode = node;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final nodes = ref.watch(nodesProvider);
    final presenceMap = ref.watch(presenceMapProvider);
    final nodesList = nodes.values.where((n) => n.hasPosition).toList();
    final myNodeNum = ref.watch(myNodeNumProvider);

    return HelpTourController(
      topicId: 'globe_overview',
      stepKeys: const {},
      child: GlassScaffold.body(
        title: context.l10n.globeScreenTitle,
        physics: const NeverScrollableScrollPhysics(),
        actions: [
          // Toggle connections
          IconButton(
            icon: Icon(
              _showConnections ? Icons.link : Icons.link_off,
              color: _showConnections
                  ? context.accentColor
                  : context.textTertiary,
            ),
            onPressed: () {
              setState(() {
                _showConnections = !_showConnections;
              });
            },
            tooltip: _showConnections
                ? context.l10n.globeHideConnections
                : context.l10n.globeShowConnections,
          ),
          // Reset view
          IconButton(
            icon: const Icon(Icons.center_focus_strong),
            onPressed: () {
              _globeKey.currentState?.rotateToLocation(0, 0);
              setState(() {
                _selectedNode = null;
              });
            },
            tooltip: context.l10n.globeResetView,
          ),
          // Help button
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () =>
                ref.read(helpProvider.notifier).startTour('globe_overview'),
            tooltip: context.l10n.globeHelp,
          ),
        ],
        body: Stack(
          children: [
            // Globe - fullscreen
            Positioned.fill(
              child: MeshGlobe(
                key: _globeKey,
                nodes: nodesList,
                presenceMap: presenceMap.map(
                  (key, value) => MapEntry(key, value.confidence),
                ),
                showConnections: _showConnections,
                onNodeSelected: _onNodeSelected,
                autoRotateSpeed: 0.0, // No auto-rotation
                markerColor: context.accentColor,
                connectionColor: context.accentColor.withAlpha(150),
              ),
            ),

            // Node count badge - top left (tap to open node selector)
            Positioned(
              left: 16,
              top: 16,
              child: GestureDetector(
                onTap: () async {
                  HapticFeedback.lightImpact();
                  final selection = await NodeSelectorSheet.show(
                    context,
                    title: context.l10n.globeSelectNode,
                    allowBroadcast: false,
                  );
                  if (!mounted) return;
                  if (selection != null && selection.nodeNum != null) {
                    final node = nodes[selection.nodeNum];
                    if (node != null && node.hasPosition) {
                      _onNodeSelected(node);
                    }
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: context.card.withAlpha(220),
                    borderRadius: BorderRadius.circular(AppTheme.radius20),
                    border: Border.all(color: context.border),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.public, size: 14, color: context.accentColor),
                      SizedBox(width: AppTheme.spacing6),
                      Text(
                        context.l10n.globeNodeCount(nodesList.length),
                        style: TextStyle(
                          color: context.textPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppTheme.fontFamily,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Selected node info card at bottom
            if (_selectedNode != null)
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: NodeInfoCard(
                  node: _selectedNode!,
                  isMyNode: _selectedNode!.nodeNum == myNodeNum,
                  onClose: () => setState(() => _selectedNode = null),
                  onMessage: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatScreen(
                          type: ConversationType.directMessage,
                          nodeNum: _selectedNode!.nodeNum,
                          title: _selectedNode!.displayName,
                          avatarColor: _selectedNode!.avatarColor,
                        ),
                      ),
                    );
                  },
                ),
              ),

            // Empty state
            if (nodesList.isEmpty)
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.public,
                      size: 64,
                      color: context.textTertiary.withAlpha(100),
                    ),
                    SizedBox(height: AppTheme.spacing16),
                    Text(
                      context.l10n.globeEmptyTitle,
                      style: TextStyle(
                        color: context.textTertiary,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: AppTheme.spacing8),
                    Text(
                      context.l10n.globeEmptyDescription,
                      style: TextStyle(
                        color: context.textTertiary,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
