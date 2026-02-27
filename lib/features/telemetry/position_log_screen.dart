// SPDX-License-Identifier: GPL-3.0-or-later
import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/map_config.dart';
import '../../core/safety/lifecycle_mixin.dart';
import '../../core/theme.dart';
import '../../core/widgets/app_bar_overflow_menu.dart';
import '../../core/widgets/app_bottom_sheet.dart';
import '../../core/widgets/datetime_picker_sheet.dart';
import '../../core/widgets/glass_scaffold.dart';
import '../../core/widgets/ico_help_system.dart';
import '../../core/widgets/mesh_map_widget.dart';
import '../../core/widgets/map_controls.dart';
import '../../core/widgets/map_node_drawer.dart';
import '../../core/widgets/search_filter_header.dart';
import '../../core/widgets/section_header.dart';
import '../../models/telemetry_log.dart';
import '../../providers/help_providers.dart';
import '../../providers/splash_mesh_provider.dart';
import '../../providers/telemetry_providers.dart';
import '../../providers/app_providers.dart';
import '../../utils/share_utils.dart';
import '../../utils/snackbar.dart';

// ---------------------------------------------------------------------------
// Filter enum
// ---------------------------------------------------------------------------

enum _PositionFilter { all, today, thisWeek, goodFix, myNode }

extension _PositionFilterLabel on _PositionFilter {
  String get label => switch (this) {
    _PositionFilter.all => 'All',
    _PositionFilter.today => 'Today',
    _PositionFilter.thisWeek => 'This Week',
    _PositionFilter.goodFix => 'Good Fix',
    _PositionFilter.myNode => 'My Node',
  };

  IconData? get icon => switch (this) {
    _PositionFilter.all => null,
    _PositionFilter.today => Icons.today,
    _PositionFilter.thisWeek => Icons.date_range,
    _PositionFilter.goodFix => Icons.satellite_alt,
    _PositionFilter.myNode => Icons.person_pin_circle,
  };
}

/// Minimum satellites for a "good fix" filter.
const int _kGoodFixMinSats = 6;

// ---------------------------------------------------------------------------
// Position history screen with search, filter chips, and map view
// ---------------------------------------------------------------------------

class PositionLogScreen extends ConsumerStatefulWidget {
  const PositionLogScreen({super.key});

  @override
  ConsumerState<PositionLogScreen> createState() => _PositionLogScreenState();
}

class _PositionLogScreenState extends ConsumerState<PositionLogScreen>
    with LifecycleSafeMixin<PositionLogScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  _PositionFilter _activeFilter = _PositionFilter.all;

  // Optional custom date range (applied when user picks via DatePickerSheet).
  DateTime? _customStartDate;
  DateTime? _customEndDate;

  bool _showMap = false;
  MapTileStyle _mapStyle = MapTileStyle.dark;
  bool _isExporting = false;

  @override
  void initState() {
    super.initState();
    _loadMapStyle();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadMapStyle() async {
    final settings = await ref.read(settingsServiceProvider.future);
    final index = settings.mapTileStyleIndex;
    if (!mounted) return;
    if (index >= 0 && index < MapTileStyle.values.length) {
      safeSetState(() => _mapStyle = MapTileStyle.values[index]);
    }
  }

  Future<void> _saveMapStyle(MapTileStyle style) async {
    final settings = await ref.read(settingsServiceProvider.future);
    if (!mounted) return;
    unawaited(settings.setMapTileStyleIndex(style.index));
  }

  // -----------------------------------------------------------------------
  // Filtering
  // -----------------------------------------------------------------------

  List<PositionLog> _filterLogs(List<PositionLog> logs) {
    final now = DateTime.now();
    final myNodeNum = ref.read(myNodeNumProvider);

    return logs.where((log) {
      // ---- enum-based filter ----
      switch (_activeFilter) {
        case _PositionFilter.today:
          final startOfDay = DateTime(now.year, now.month, now.day);
          if (log.timestamp.isBefore(startOfDay)) return false;
        case _PositionFilter.thisWeek:
          final startOfWeek = DateTime(
            now.year,
            now.month,
            now.day,
          ).subtract(Duration(days: now.weekday - 1));
          if (log.timestamp.isBefore(startOfWeek)) return false;
        case _PositionFilter.goodFix:
          if (log.satsInView == null || log.satsInView! < _kGoodFixMinSats) {
            return false;
          }
        case _PositionFilter.myNode:
          if (myNodeNum == null || log.nodeNum != myNodeNum) return false;
        case _PositionFilter.all:
          break;
      }

      // ---- optional custom date range ----
      if (_customStartDate != null &&
          log.timestamp.isBefore(_customStartDate!)) {
        return false;
      }
      if (_customEndDate != null &&
          log.timestamp.isAfter(_customEndDate!.add(const Duration(days: 1)))) {
        return false;
      }

      // ---- text search by node name ----
      if (_searchQuery.isNotEmpty) {
        final nodes = ref.read(nodesProvider);
        final nodeName =
            nodes[log.nodeNum]?.displayName ??
            '!${log.nodeNum.toRadixString(16).toUpperCase()}';
        if (!nodeName.toLowerCase().contains(_searchQuery.toLowerCase())) {
          return false;
        }
      }

      return true;
    }).toList();
  }

  bool get _hasActiveFilters =>
      _activeFilter != _PositionFilter.all ||
      _customStartDate != null ||
      _customEndDate != null ||
      _searchQuery.isNotEmpty;

  void _clearFilters() {
    HapticFeedback.selectionClick();
    safeSetState(() {
      _activeFilter = _PositionFilter.all;
      _customStartDate = null;
      _customEndDate = null;
      _searchQuery = '';
      _searchController.clear();
    });
  }

  // -----------------------------------------------------------------------
  // Date range picker (uses DatePickerSheet, not banned Material dialogs)
  // -----------------------------------------------------------------------

  Future<void> _selectDateRange() async {
    final start = await DatePickerSheet.show(
      context,
      initialDate: _customStartDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      title: 'Start Date',
    );
    if (!mounted || start == null) return;

    final end = await DatePickerSheet.show(
      context,
      initialDate: _customEndDate ?? start,
      firstDate: start,
      lastDate: DateTime.now(),
      title: 'End Date',
    );
    if (!mounted || end == null) return;

    safeSetState(() {
      _customStartDate = start;
      _customEndDate = end;
    });
  }

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  // -----------------------------------------------------------------------
  // Filter chips
  // -----------------------------------------------------------------------

  List<Widget> _buildFilterChips(
    BuildContext context,
    List<PositionLog> allLogs,
  ) {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final startOfWeek = startOfDay.subtract(Duration(days: now.weekday - 1));
    final myNodeNum = ref.watch(myNodeNumProvider);

    final todayCount = allLogs
        .where((l) => !l.timestamp.isBefore(startOfDay))
        .length;
    final weekCount = allLogs
        .where((l) => !l.timestamp.isBefore(startOfWeek))
        .length;
    final goodFixCount = allLogs
        .where((l) => l.satsInView != null && l.satsInView! >= _kGoodFixMinSats)
        .length;
    final myNodeCount = myNodeNum != null
        ? allLogs.where((l) => l.nodeNum == myNodeNum).length
        : 0;

    return [
      SectionFilterChip(
        label: _PositionFilter.all.label,
        count: allLogs.length,
        isSelected: _activeFilter == _PositionFilter.all,
        onTap: () {
          HapticFeedback.selectionClick();
          safeSetState(() => _activeFilter = _PositionFilter.all);
        },
      ),
      SectionFilterChip(
        label: _PositionFilter.today.label,
        count: todayCount,
        isSelected: _activeFilter == _PositionFilter.today,
        icon: _PositionFilter.today.icon,
        color: AccentColors.cyan,
        onTap: () {
          HapticFeedback.selectionClick();
          safeSetState(() => _activeFilter = _PositionFilter.today);
        },
      ),
      SectionFilterChip(
        label: _PositionFilter.thisWeek.label,
        count: weekCount,
        isSelected: _activeFilter == _PositionFilter.thisWeek,
        icon: _PositionFilter.thisWeek.icon,
        color: AccentColors.purple,
        onTap: () {
          HapticFeedback.selectionClick();
          safeSetState(() => _activeFilter = _PositionFilter.thisWeek);
        },
      ),
      SectionFilterChip(
        label: _PositionFilter.goodFix.label,
        count: goodFixCount,
        isSelected: _activeFilter == _PositionFilter.goodFix,
        icon: _PositionFilter.goodFix.icon,
        color: AccentColors.green,
        onTap: () {
          HapticFeedback.selectionClick();
          safeSetState(() => _activeFilter = _PositionFilter.goodFix);
        },
      ),
      if (myNodeNum != null)
        SectionFilterChip(
          label: _PositionFilter.myNode.label,
          count: myNodeCount,
          isSelected: _activeFilter == _PositionFilter.myNode,
          icon: _PositionFilter.myNode.icon,
          color: AppTheme.primaryMagenta,
          onTap: () {
            HapticFeedback.selectionClick();
            safeSetState(() => _activeFilter = _PositionFilter.myNode);
          },
        ),
    ];
  }

  // -----------------------------------------------------------------------
  // Build
  // -----------------------------------------------------------------------

  // -----------------------------------------------------------------------
  // Export CSV
  // -----------------------------------------------------------------------

  Future<void> _exportCsv() async {
    safeSetState(() => _isExporting = true);

    try {
      final logs = await ref.read(positionLogsProvider.future);
      if (!mounted) return;

      if (logs.isEmpty) {
        showInfoSnackBar(context, 'No position data to export');
        return;
      }

      final nodes = ref.read(nodesProvider);
      final buffer = StringBuffer();
      buffer.writeln(
        'timestamp,node_num,node_name,latitude,longitude,altitude,sats_in_view,ground_speed,ground_track',
      );

      for (final log in logs) {
        final nodeName =
            nodes[log.nodeNum]?.displayName ??
            '!${log.nodeNum.toRadixString(16).toUpperCase()}';
        buffer.writeln(
          '${log.timestamp.toIso8601String()},'
          '${log.nodeNum},'
          '"$nodeName",'
          '${log.latitude},'
          '${log.longitude},'
          '${log.altitude ?? ""},'
          '${log.satsInView ?? ""},'
          '${log.speed ?? ""},'
          '${log.heading ?? ""}',
        );
      }

      if (!mounted) return;

      final timestamp = DateTime.now()
          .toIso8601String()
          .replaceAll(':', '-')
          .split('.')
          .first;
      final fileName = 'position_export_$timestamp.csv';

      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/$fileName');
      await file.writeAsString(buffer.toString());

      if (!mounted) return;

      await shareFiles(
        [XFile(file.path)],
        subject: 'Socialmesh Position Export',
        context: context,
      );

      if (!mounted) return;
      showSuccessSnackBar(context, 'Exported ${logs.length} positions');
    } catch (e) {
      showErrorSnackBar(context, 'Export failed: $e');
    } finally {
      if (mounted) {
        safeSetState(() => _isExporting = false);
      }
    }
  }

  // -----------------------------------------------------------------------
  // Clear data
  // -----------------------------------------------------------------------

  Future<void> _confirmClearData() async {
    final messenger = ScaffoldMessenger.of(context);

    final confirmed = await AppBottomSheet.showConfirm(
      context: context,
      title: 'Clear Position Data',
      message:
          'This will permanently delete all position history for all nodes. This cannot be undone.',
      confirmLabel: 'Clear',
      isDestructive: true,
    );

    if (confirmed != true || !mounted) return;

    try {
      final storage = await ref.read(telemetryStorageProvider.future);
      if (!mounted) return;
      await storage.clearPositionLogs();
      ref.invalidate(positionLogsProvider);

      if (!mounted) return;
      messenger.showSnackBar(
        const SnackBar(content: Text('Position data cleared')),
      );
    } catch (e) {
      showErrorSnackBar(context, 'Failed to clear data: $e');
    }
  }

  // -----------------------------------------------------------------------
  // Build
  // -----------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final logsAsync = ref.watch(positionLogsProvider);
    final nodes = ref.watch(nodesProvider);

    return GestureDetector(
      onTap: _dismissKeyboard,
      child: HelpTourController(
        topicId: 'position_overview',
        stepKeys: const {},
        child: GlassScaffold(
          resizeToAvoidBottomInset: false,
          title: 'Position',
          actions: [
            // Date range selector
            IconButton(
              icon: Badge(
                isLabelVisible:
                    _customStartDate != null || _customEndDate != null,
                child: const Icon(Icons.date_range),
              ),
              tooltip: 'Date range',
              onPressed: _selectDateRange,
            ),
            // Overflow menu with all secondary actions
            AppBarOverflowMenu<String>(
              onSelected: (value) {
                switch (value) {
                  case 'toggle_view':
                    HapticFeedback.selectionClick();
                    safeSetState(() => _showMap = !_showMap);
                  case 'export':
                    _exportCsv();
                  case 'clear':
                    _confirmClearData();
                  case 'help':
                    ref
                        .read(helpProvider.notifier)
                        .startTour('position_overview');
                  case 'settings':
                    Navigator.of(context).pushNamed('/settings');
                  default:
                    // Map style selections
                    if (value.startsWith('map_style_')) {
                      final index = int.tryParse(
                        value.replaceFirst('map_style_', ''),
                      );
                      if (index != null &&
                          index >= 0 &&
                          index < MapTileStyle.values.length) {
                        final style = MapTileStyle.values[index];
                        safeSetState(() => _mapStyle = style);
                        unawaited(_saveMapStyle(style));
                      }
                    }
                }
              },
              itemBuilder: (context) => [
                // Map / list toggle
                PopupMenuItem<String>(
                  value: 'toggle_view',
                  child: Row(
                    children: [
                      Icon(
                        _showMap ? Icons.list : Icons.map,
                        size: 20,
                        color: context.textSecondary,
                      ),
                      const SizedBox(width: AppTheme.spacing12),
                      Text(_showMap ? 'List view' : 'Map view'),
                    ],
                  ),
                ),
                // Map style submenu (only in map mode)
                if (_showMap) ...[
                  const PopupMenuDivider(),
                  PopupMenuItem<String>(
                    enabled: false,
                    height: 32,
                    child: Text(
                      'Map Style',
                      style: TextStyle(
                        fontSize: 12,
                        color: context.textTertiary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  ...MapTileStyle.values.map((style) {
                    final isSelected = _mapStyle == style;
                    return PopupMenuItem<String>(
                      value: 'map_style_${style.index}',
                      child: Row(
                        children: [
                          Icon(
                            isSelected ? Icons.check : Icons.map_outlined,
                            size: 18,
                            color: isSelected
                                ? context.accentColor
                                : context.textSecondary,
                          ),
                          const SizedBox(width: AppTheme.spacing8),
                          Text(style.label),
                        ],
                      ),
                    );
                  }),
                ],
                const PopupMenuDivider(),
                // Export
                PopupMenuItem<String>(
                  value: 'export',
                  enabled: !_isExporting,
                  child: Row(
                    children: [
                      Icon(
                        _isExporting ? Icons.hourglass_top : Icons.ios_share,
                        size: 20,
                        color: context.textSecondary,
                      ),
                      const SizedBox(width: AppTheme.spacing12),
                      Text(_isExporting ? 'Exporting...' : 'Export CSV'),
                    ],
                  ),
                ),
                // Clear data
                PopupMenuItem<String>(
                  value: 'clear',
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_outline,
                        size: 20,
                        color: AppTheme.errorRed,
                      ),
                      const SizedBox(width: AppTheme.spacing12),
                      Text(
                        'Clear Data',
                        style: TextStyle(color: AppTheme.errorRed),
                      ),
                    ],
                  ),
                ),
                const PopupMenuDivider(),
                // Help
                const PopupMenuItem<String>(
                  value: 'help',
                  child: ListTile(
                    leading: Icon(Icons.help_outline),
                    title: Text('Help'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                // Settings
                const PopupMenuItem<String>(
                  value: 'settings',
                  child: ListTile(
                    leading: Icon(Icons.settings_outlined),
                    title: Text('Settings'),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ],
          slivers: [
            logsAsync.when(
              loading: () =>
                  const SliverFillRemaining(child: ScreenLoadingIndicator()),
              error: (e, s) =>
                  SliverFillRemaining(child: Center(child: Text('Error: $e'))),
              data: (logs) {
                final filtered = _filterLogs(logs)
                  ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

                // Build the list of slivers for the data state
                return SliverMainAxisGroup(
                  slivers: [
                    // Pinned search + filter chips
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: SearchFilterHeaderDelegate(
                        searchController: _searchController,
                        searchQuery: _searchQuery,
                        onSearchChanged: (value) =>
                            safeSetState(() => _searchQuery = value),
                        hintText: 'Search by node name',
                        textScaler: MediaQuery.textScalerOf(context),
                        rebuildKey: Object.hashAll([
                          _activeFilter,
                          _customStartDate,
                          _customEndDate,
                          logs.length,
                          _searchQuery,
                        ]),
                        filterChips: _buildFilterChips(context, logs),
                      ),
                    ),

                    // Date range indicator (when custom range is active)
                    if (_customStartDate != null || _customEndDate != null)
                      SliverToBoxAdapter(
                        child: _DateRangeBanner(
                          startDate: _customStartDate,
                          endDate: _customEndDate,
                          onClear: () {
                            HapticFeedback.selectionClick();
                            safeSetState(() {
                              _customStartDate = null;
                              _customEndDate = null;
                            });
                          },
                        ),
                      ),

                    // Empty state
                    if (filtered.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.location_off,
                                size: 64,
                                color: context.textTertiary,
                              ),
                              const SizedBox(height: AppTheme.spacing16),
                              Text(
                                _hasActiveFilters
                                    ? 'No positions match filters'
                                    : 'No position history',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: context.textSecondary,
                                ),
                              ),
                              if (_hasActiveFilters) ...[
                                const SizedBox(height: AppTheme.spacing12),
                                TextButton.icon(
                                  onPressed: _clearFilters,
                                  icon: const Icon(
                                    Icons.filter_alt_off,
                                    size: 18,
                                  ),
                                  label: const Text('Clear all filters'),
                                ),
                              ],
                            ],
                          ),
                        ),
                      )
                    // Map view
                    else if (_showMap)
                      SliverFillRemaining(
                        child: _PositionMapView(
                          logs: filtered,
                          nodes: nodes,
                          mapStyle: _mapStyle,
                        ),
                      )
                    // List view
                    else ...[
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacing16,
                          vertical: AppTheme.spacing8,
                        ),
                        sliver: SliverList.separated(
                          itemCount: filtered.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(height: AppTheme.spacing8),
                          itemBuilder: (context, index) {
                            final log = filtered[index];
                            // Only show distance from the previous log if it
                            // belongs to the same node — otherwise the delta
                            // is a phantom jump between unrelated nodes.
                            final prevLog = index < filtered.length - 1
                                ? filtered[index + 1]
                                : null;
                            final distance =
                                prevLog != null &&
                                    prevLog.nodeNum == log.nodeNum
                                ? _calculateDistance(
                                    log.latitude,
                                    log.longitude,
                                    prevLog.latitude,
                                    prevLog.longitude,
                                  )
                                : null;

                            final nodeName =
                                nodes[log.nodeNum]?.displayName ??
                                '!${log.nodeNum.toRadixString(16).toUpperCase()}';

                            return _PositionCard(
                              log: log,
                              nodeName: nodeName,
                              distanceFromPrev: distance,
                            );
                          },
                        ),
                      ),
                      // Bottom safe area
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height:
                              MediaQuery.of(context).padding.bottom +
                              AppTheme.spacing16,
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const r = 6371000.0;
    final dLat = (lat2 - lat1) * math.pi / 180;
    final dLon = (lon2 - lon1) * math.pi / 180;
    final a =
        math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1 * math.pi / 180) *
            math.cos(lat2 * math.pi / 180) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);
    final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return r * c;
  }
}

// ---------------------------------------------------------------------------
// Date range banner — shown below filter chips when a custom range is active
// ---------------------------------------------------------------------------

class _DateRangeBanner extends StatelessWidget {
  final DateTime? startDate;
  final DateTime? endDate;
  final VoidCallback onClear;

  const _DateRangeBanner({this.startDate, this.endDate, required this.onClear});

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat.MMMd();
    final label = startDate != null && endDate != null
        ? '${fmt.format(startDate!)} – ${fmt.format(endDate!)}'
        : startDate != null
        ? 'From ${fmt.format(startDate!)}'
        : 'Until ${fmt.format(endDate!)}';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: context.accentColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppTheme.radius8),
          border: Border.all(color: context.accentColor.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(Icons.date_range, size: 16, color: context.accentColor),
            const SizedBox(width: AppTheme.spacing8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: context.accentColor,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                HapticFeedback.selectionClick();
                onClear();
              },
              child: Icon(Icons.close, size: 16, color: context.accentColor),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Map view — compact node picker, auto-fit bounds, proper controls layout
// ---------------------------------------------------------------------------

class _PositionMapView extends StatefulWidget {
  final List<PositionLog> logs;
  final Map<int, dynamic> nodes;
  final MapTileStyle mapStyle;

  const _PositionMapView({
    required this.logs,
    required this.nodes,
    required this.mapStyle,
  });

  @override
  State<_PositionMapView> createState() => _PositionMapViewState();
}

class _PositionMapViewState extends State<_PositionMapView> {
  final MapController _mapController = MapController();
  final TextEditingController _nodeSearchController = TextEditingController();
  String _nodeSearchQuery = '';
  bool _showNodeList = false;
  int? _selectedNodeNum;
  PositionLog? _selectedLog;
  double _currentZoom = 14.0;
  bool _didInitialFit = false;

  List<int> get _nodeNums => widget.logs.map((l) => l.nodeNum).toSet().toList();

  List<PositionLog> get _filteredLogs => _selectedNodeNum == null
      ? widget.logs
      : widget.logs.where((l) => l.nodeNum == _selectedNodeNum).toList();

  @override
  void initState() {
    super.initState();
    // Auto-fit to bounds on first frame after map is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_didInitialFit && mounted) {
        _didInitialFit = true;
        _fitToVisible();
      }
    });
  }

  @override
  void dispose() {
    _nodeSearchController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _PositionMapView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_selectedNodeNum != null) {
      final stillPresent = widget.logs.any(
        (l) => l.nodeNum == _selectedNodeNum,
      );
      if (!stillPresent) {
        _selectedNodeNum = null;
      }
    }
  }

  void _fitToVisible() {
    final visibleLogs = _filteredLogs;
    if (visibleLogs.isEmpty) return;
    final lats = visibleLogs.map((l) => l.latitude).toList();
    final lons = visibleLogs.map((l) => l.longitude).toList();
    final bounds = LatLngBounds(
      LatLng(lats.reduce(math.min), lons.reduce(math.min)),
      LatLng(lats.reduce(math.max), lons.reduce(math.max)),
    );
    _mapController.fitCamera(
      CameraFit.bounds(
        bounds: bounds,
        padding: const EdgeInsets.all(AppTheme.spacing50),
      ),
    );
  }

  Color _getNodeColor(int nodeNum) {
    const colors = [
      AppTheme.primaryMagenta,
      AppTheme.primaryPurple,
      AppTheme.primaryBlue,
      AccentColors.cyan,
      AccentColors.green,
      AccentColors.orange,
    ];
    return colors[nodeNum % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final logs = _filteredLogs;
    if (logs.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.map_outlined, size: 48, color: context.textTertiary),
            const SizedBox(height: AppTheme.spacing12),
            Text(
              'No positions to display',
              style: TextStyle(color: context.textSecondary),
            ),
          ],
        ),
      );
    }

    // Calculate bounds
    final lats = logs.map((l) => l.latitude).toList();
    final lons = logs.map((l) => l.longitude).toList();
    final center = LatLng(
      (lats.reduce(math.min) + lats.reduce(math.max)) / 2,
      (lons.reduce(math.min) + lons.reduce(math.max)) / 2,
    );

    // Group logs by node for trails (downsampled to max 300 points per node)
    final nodeTrails = <int, List<LatLng>>{};
    final rawByNode = <int, List<LatLng>>{};
    for (final log in logs) {
      rawByNode.putIfAbsent(log.nodeNum, () => []);
      rawByNode[log.nodeNum]!.add(LatLng(log.latitude, log.longitude));
    }
    for (final entry in rawByNode.entries) {
      final pts = entry.value;
      if (pts.length <= 300) {
        nodeTrails[entry.key] = pts;
      } else {
        final sampled = <LatLng>[pts.first];
        final step = (pts.length - 1) / 299;
        for (int i = 1; i < 299; i++) {
          sampled.add(pts[(i * step).round()]);
        }
        sampled.add(pts.last);
        nodeTrails[entry.key] = sampled;
      }
    }

    // Downsample markers (max 500 total)
    final cappedLogs = logs.length > 500
        ? [
            for (int i = 0; i < 500; i++)
              logs[(i * (logs.length - 1) / 499).round()],
          ]
        : logs;

    // Count unique nodes for stats
    final uniqueNodes = logs.map((l) => l.nodeNum).toSet().length;

    return Stack(
      children: [
        MeshMapWidget(
          mapController: _mapController,
          mapStyle: widget.mapStyle,
          initialCenter: center,
          initialZoom: _currentZoom,
          onTap: (_, _) {
            if (_selectedLog != null) {
              setState(() => _selectedLog = null);
            }
          },
          onPositionChanged: (camera, hasGesture) {
            _currentZoom = camera.zoom;
          },
          additionalLayers: [
            // Trails per node
            PolylineLayer(
              polylines: nodeTrails.entries.map((entry) {
                final color = _getNodeColor(entry.key);
                return Polyline(
                  points: entry.value,
                  strokeWidth: 3,
                  color: color.withValues(alpha: 0.7),
                );
              }).toList(),
            ),

            // Position markers (tappable)
            MarkerLayer(
              markers: cappedLogs.map((log) {
                final color = _getNodeColor(log.nodeNum);
                final isSelected = _selectedLog == log;
                return Marker(
                  point: LatLng(log.latitude, log.longitude),
                  width: isSelected ? 24 : 16,
                  height: isSelected ? 24 : 16,
                  child: GestureDetector(
                    onTap: () {
                      HapticFeedback.selectionClick();
                      setState(() {
                        _selectedLog = _selectedLog == log ? null : log;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? Colors.white
                              : Colors.white.withValues(alpha: 0.8),
                          width: isSelected ? 3 : 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: color.withValues(
                              alpha: isSelected ? 0.7 : 0.4,
                            ),
                            blurRadius: isSelected ? 8 : 4,
                            spreadRadius: isSelected ? 2 : 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),

        // ----- Node list drawer (slides from left, matching world map) -----
        AnimatedPositioned(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          left: _showNodeList ? 0 : -300,
          top: 0,
          bottom: 0,
          width: 300,
          child: _PositionNodeListPanel(
            nodeNums: _nodeNums,
            nodes: widget.nodes,
            logs: widget.logs,
            selectedNodeNum: _selectedNodeNum,
            getNodeColor: _getNodeColor,
            searchController: _nodeSearchController,
            searchQuery: _nodeSearchQuery,
            onSearchChanged: (q) => setState(() => _nodeSearchQuery = q),
            onNodeSelected: (nodeNum) {
              setState(() {
                _selectedNodeNum = nodeNum;
                _selectedLog = null;
                _showNodeList = false;
                _nodeSearchQuery = '';
                _nodeSearchController.clear();
              });
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) _fitToVisible();
              });
            },
            onShowAll: () {
              setState(() {
                _selectedNodeNum = null;
                _selectedLog = null;
                _showNodeList = false;
                _nodeSearchQuery = '';
                _nodeSearchController.clear();
              });
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) _fitToVisible();
              });
            },
            onClose: () => setState(() => _showNodeList = false),
          ),
        ),

        // ----- Node count pill (top-left, opens drawer) -----
        if (!_showNodeList && _nodeNums.length > 1)
          Positioned(
            top: AppTheme.spacing8,
            left: AppTheme.spacing8,
            child: GestureDetector(
              onTap: () => setState(() {
                _showNodeList = true;
                _selectedLog = null;
              }),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: context.card.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(AppTheme.radius20),
                  border: Border.all(
                    color: _selectedNodeNum != null
                        ? context.accentColor.withValues(alpha: 0.5)
                        : context.border.withValues(alpha: 0.5),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_selectedNodeNum != null) ...[
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _getNodeColor(_selectedNodeNum!),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacing6),
                    ],
                    Text(
                      _selectedNodeNum != null
                          ? (widget.nodes[_selectedNodeNum]?.displayName ??
                                '!${_selectedNodeNum!.toRadixString(16).toUpperCase()}')
                          : '${_nodeNums.length} nodes',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: _selectedNodeNum != null
                            ? context.accentColor
                            : context.textPrimary,
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacing4),
                    Icon(
                      Icons.chevron_right,
                      size: 16,
                      color: context.textTertiary,
                    ),
                  ],
                ),
              ),
            ),
          ),

        // ----- Controls column (right edge) -----
        Positioned(
          top: AppTheme.spacing8,
          right: AppTheme.spacing8,
          child: Column(
            children: [
              MapZoomControls(
                currentZoom: _currentZoom,
                minZoom: 3.0,
                maxZoom: 18.0,
                showFitAll: true,
                onZoomIn: () {
                  final newZoom = (_currentZoom + 1).clamp(3.0, 18.0);
                  _mapController.move(_mapController.camera.center, newZoom);
                },
                onZoomOut: () {
                  final newZoom = (_currentZoom - 1).clamp(3.0, 18.0);
                  _mapController.move(_mapController.camera.center, newZoom);
                },
                onFitAll: _fitToVisible,
              ),
            ],
          ),
        ),

        // ----- Selected position info card OR stats bar (bottom) -----
        if (!_showNodeList)
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + AppTheme.spacing12,
            left: AppTheme.spacing12,
            right: AppTheme.spacing12,
            child: _selectedLog != null
                ? _PositionInfoCard(
                    log: _selectedLog!,
                    nodeName:
                        widget.nodes[_selectedLog!.nodeNum]?.displayName ??
                        '!${_selectedLog!.nodeNum.toRadixString(16).toUpperCase()}',
                    nodeColor: _getNodeColor(_selectedLog!.nodeNum),
                    onClose: () => setState(() => _selectedLog = null),
                  )
                : Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacing16,
                      vertical: AppTheme.spacing12,
                    ),
                    decoration: BoxDecoration(
                      color: context.card.withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(AppTheme.radius12),
                      border: Border.all(
                        color: context.border.withValues(alpha: 0.5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatItem(
                          label: 'Points',
                          value: '${logs.length}',
                          icon: Icons.location_on,
                        ),
                        _StatItem(
                          label: 'Nodes',
                          value: '$uniqueNodes',
                          icon: Icons.device_hub,
                        ),
                        _StatItem(
                          label: 'Distance',
                          value: _formatDistance(_calculateTotalDistance(logs)),
                          icon: Icons.straighten,
                        ),
                      ],
                    ),
                  ),
          ),
      ],
    );
  }

  double _calculateTotalDistance(List<PositionLog> logs) {
    if (logs.length < 2) return 0;
    final byNode = <int, List<PositionLog>>{};
    for (final log in logs) {
      byNode.putIfAbsent(log.nodeNum, () => []).add(log);
    }
    double total = 0;
    for (final nodeLogs in byNode.values) {
      if (nodeLogs.length < 2) continue;
      for (int i = 1; i < nodeLogs.length; i++) {
        const r = 6371000.0;
        final lat1 = nodeLogs[i - 1].latitude * math.pi / 180;
        final lat2 = nodeLogs[i].latitude * math.pi / 180;
        final dLat =
            (nodeLogs[i].latitude - nodeLogs[i - 1].latitude) * math.pi / 180;
        final dLon =
            (nodeLogs[i].longitude - nodeLogs[i - 1].longitude) * math.pi / 180;
        final a =
            math.sin(dLat / 2) * math.sin(dLat / 2) +
            math.cos(lat1) *
                math.cos(lat2) *
                math.sin(dLon / 2) *
                math.sin(dLon / 2);
        final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
        total += r * c;
      }
    }
    return total;
  }

  String _formatDistance(double meters) {
    if (meters < 1000) return '${meters.toStringAsFixed(0)}m';
    return '${(meters / 1000).toStringAsFixed(1)}km';
  }
}

// ---------------------------------------------------------------------------
// Node list drawer panel — slides from left, matching world map pattern
// ---------------------------------------------------------------------------

class _PositionNodeListPanel extends StatelessWidget {
  final List<int> nodeNums;
  final Map<int, dynamic> nodes;
  final List<PositionLog> logs;
  final int? selectedNodeNum;
  final Color Function(int) getNodeColor;
  final TextEditingController searchController;
  final String searchQuery;
  final void Function(String) onSearchChanged;
  final void Function(int) onNodeSelected;
  final VoidCallback onShowAll;
  final VoidCallback onClose;

  const _PositionNodeListPanel({
    required this.nodeNums,
    required this.nodes,
    required this.logs,
    required this.selectedNodeNum,
    required this.getNodeColor,
    required this.searchController,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.onNodeSelected,
    required this.onShowAll,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    // Build node entries with position counts, sorted by count descending.
    final countByNode = <int, int>{};
    for (final log in logs) {
      countByNode[log.nodeNum] = (countByNode[log.nodeNum] ?? 0) + 1;
    }

    var sortedNums = List<int>.from(nodeNums);
    sortedNums.sort((a, b) {
      final countA = countByNode[a] ?? 0;
      final countB = countByNode[b] ?? 0;
      return countB.compareTo(countA);
    });

    // Apply search filter.
    if (searchQuery.isNotEmpty) {
      final q = searchQuery.toLowerCase();
      sortedNums = sortedNums.where((nodeNum) {
        final name =
            nodes[nodeNum]?.displayName ??
            '!${nodeNum.toRadixString(16).toUpperCase()}';
        return name.toLowerCase().contains(q);
      }).toList();
    }

    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return MapNodeDrawer(
      title: 'Nodes',
      headerIcon: Icons.hub,
      itemCount: nodeNums.length,
      onClose: onClose,
      searchController: searchController,
      onSearchChanged: onSearchChanged,
      content: Expanded(
        child: Column(
          children: [
            // "All Nodes" option.
            Material(
              color: selectedNodeNum == null
                  ? context.accentColor.withValues(alpha: 0.15)
                  : Colors.transparent,
              child: InkWell(
                onTap: () {
                  HapticFeedback.selectionClick();
                  onShowAll();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: context.accentColor.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: context.accentColor.withValues(alpha: 0.6),
                            width: 1.5,
                          ),
                        ),
                        child: Icon(
                          Icons.layers,
                          size: 18,
                          color: context.accentColor,
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacing10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'All Nodes',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: selectedNodeNum == null
                                    ? context.accentColor
                                    : context.textPrimary,
                              ),
                            ),
                            const SizedBox(height: AppTheme.spacing2),
                            Text(
                              'Show positions from all nodes',
                              style: TextStyle(
                                fontSize: 11,
                                color: context.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (selectedNodeNum == null)
                        Icon(
                          Icons.check_circle,
                          size: 18,
                          color: context.accentColor,
                        ),
                    ],
                  ),
                ),
              ),
            ),

            Divider(height: 1, color: context.border.withValues(alpha: 0.3)),

            // Node list.
            Expanded(
              child: sortedNums.isEmpty
                  ? const DrawerEmptyState()
                  : ListView.builder(
                      padding: EdgeInsets.only(
                        top: 4,
                        bottom: bottomPadding + 8,
                      ),
                      itemCount: sortedNums.length,
                      itemBuilder: (context, index) {
                        final nodeNum = sortedNums[index];
                        final node = nodes[nodeNum];
                        final nodeName =
                            (node?.displayName as String?) ??
                            '!${nodeNum.toRadixString(16).toUpperCase()}';
                        final shortName = node?.shortName as String?;
                        final color = getNodeColor(nodeNum);
                        final count = countByNode[nodeNum] ?? 0;
                        final isSelected = selectedNodeNum == nodeNum;

                        return StaggeredDrawerTile(
                          index: index,
                          child: Material(
                            color: isSelected
                                ? context.accentColor.withValues(alpha: 0.15)
                                : Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                HapticFeedback.selectionClick();
                                onNodeSelected(nodeNum);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 10,
                                ),
                                child: Row(
                                  children: [
                                    // Node color circle with initial.
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: color.withValues(alpha: 0.2),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: color.withValues(alpha: 0.6),
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          (shortName != null &&
                                                      shortName.isNotEmpty
                                                  ? shortName[0]
                                                  : nodeNum
                                                        .toRadixString(16)
                                                        .substring(0, 1))
                                              .toUpperCase(),
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: color,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: AppTheme.spacing10),
                                    // Node info.
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            nodeName,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: isSelected
                                                  ? context.accentColor
                                                  : context.textPrimary,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            height: AppTheme.spacing2,
                                          ),
                                          Text(
                                            '$count position${count == 1 ? '' : 's'}',
                                            style: TextStyle(
                                              fontSize: 11,
                                              color: context.textTertiary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Count badge.
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: context.background,
                                        borderRadius: BorderRadius.circular(
                                          AppTheme.radius12,
                                        ),
                                      ),
                                      child: Text(
                                        '$count',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: color,
                                          fontFamily: AppTheme.fontFamily,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Position info card — shown at bottom when a marker is tapped
// ---------------------------------------------------------------------------

class _PositionInfoCard extends StatelessWidget {
  final PositionLog log;
  final String nodeName;
  final Color nodeColor;
  final VoidCallback onClose;

  const _PositionInfoCard({
    required this.log,
    required this.nodeName,
    required this.nodeColor,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat('HH:mm:ss');
    final dateFormat = DateFormat('MMM d, yyyy');

    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: context.card.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: context.border.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: color dot + node name + timestamp + close button
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: nodeColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: nodeColor.withValues(alpha: 0.5),
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppTheme.spacing8),
              Expanded(
                child: Text(
                  nodeName,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${dateFormat.format(log.timestamp)}  ${timeFormat.format(log.timestamp)}',
                style: TextStyle(
                  fontSize: 11,
                  color: context.textTertiary,
                  fontFamily: AppTheme.fontFamily,
                ),
              ),
              const SizedBox(width: AppTheme.spacing8),
              GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  onClose();
                },
                child: Icon(Icons.close, size: 16, color: context.textTertiary),
              ),
            ],
          ),

          const SizedBox(height: AppTheme.spacing4),

          // Coordinates
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text(
              '${log.latitude.toStringAsFixed(6)}, ${log.longitude.toStringAsFixed(6)}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: context.textSecondary,
                fontFamily: AppTheme.fontFamily,
              ),
            ),
          ),

          const SizedBox(height: AppTheme.spacing8),

          // Metric badges
          Wrap(
            spacing: AppTheme.spacing6,
            runSpacing: AppTheme.spacing6,
            children: [
              if (log.altitude != null)
                _InfoBadge(
                  icon: Icons.terrain,
                  value: '${log.altitude!.round()}m',
                ),
              if (log.satsInView != null)
                _InfoBadge(
                  icon: Icons.satellite_alt,
                  value: '${log.satsInView} sats',
                  color: log.satsInView! >= _kGoodFixMinSats
                      ? AccentColors.green
                      : null,
                ),
              if (log.speed != null && log.speed! > 0)
                _InfoBadge(
                  icon: Icons.speed,
                  value: '${log.speed!.round()} km/h',
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Stat item (map overlay)
// ---------------------------------------------------------------------------

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatItem({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: context.textTertiary),
        const SizedBox(height: AppTheme.spacing4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: context.textPrimary,
            fontFamily: AppTheme.fontFamily,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: context.textTertiary,
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Position card (list view) — matches NodeDex / Presence tile styling
// ---------------------------------------------------------------------------

class _PositionCard extends StatelessWidget {
  final PositionLog log;
  final String nodeName;
  final double? distanceFromPrev;

  const _PositionCard({
    required this.log,
    required this.nodeName,
    this.distanceFromPrev,
  });

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat('HH:mm:ss');
    final dateFormat = DateFormat('MMM d');

    return Container(
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(color: context.border.withValues(alpha: 0.3)),
      ),
      padding: const EdgeInsets.all(AppTheme.spacing12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: node name + timestamp
          Row(
            children: [
              Icon(Icons.location_on, size: 14, color: context.accentColor),
              const SizedBox(width: AppTheme.spacing8),
              Expanded(
                child: Text(
                  nodeName,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: context.textPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${dateFormat.format(log.timestamp)}  ${timeFormat.format(log.timestamp)}',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: context.textTertiary,
                  fontFamily: AppTheme.fontFamily,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppTheme.spacing4),

          // Coordinates (compact, mono)
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Text(
              '${log.latitude.toStringAsFixed(6)}, ${log.longitude.toStringAsFixed(6)}',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: context.textSecondary,
                fontFamily: AppTheme.fontFamily,
              ),
            ),
          ),

          const SizedBox(height: AppTheme.spacing8),

          // Metrics
          Wrap(
            spacing: AppTheme.spacing6,
            runSpacing: AppTheme.spacing6,
            children: [
              if (log.altitude != null)
                _InfoBadge(
                  icon: Icons.terrain,
                  value: '${log.altitude!.round()}m',
                ),
              if (log.satsInView != null)
                _InfoBadge(
                  icon: Icons.satellite_alt,
                  value: '${log.satsInView} sats',
                  color: log.satsInView! >= _kGoodFixMinSats
                      ? AccentColors.green
                      : null,
                ),
              if (log.speed != null && log.speed! > 0)
                _InfoBadge(
                  icon: Icons.speed,
                  value: '${log.speed!.round()} km/h',
                ),
              if (distanceFromPrev != null)
                _InfoBadge(
                  icon: Icons.straighten,
                  value: distanceFromPrev! < 1000
                      ? '${distanceFromPrev!.toStringAsFixed(0)}m'
                      : '${(distanceFromPrev! / 1000).toStringAsFixed(1)}km',
                  color: AppTheme.primaryBlue,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Info badge — matches InfoChip pattern from core/widgets
// ---------------------------------------------------------------------------

class _InfoBadge extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color? color;

  const _InfoBadge({required this.icon, required this.value, this.color});

  @override
  Widget build(BuildContext context) {
    final badgeColor = color ?? context.textTertiary;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing8,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        border: Border.all(color: badgeColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: badgeColor),
          const SizedBox(width: AppTheme.spacing4),
          Text(
            value,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: badgeColor,
              fontFamily: AppTheme.fontFamily,
            ),
          ),
        ],
      ),
    );
  }
}
