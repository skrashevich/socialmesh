// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/safety/lifecycle_mixin.dart';
import '../../../core/theme.dart';
import '../../../core/widgets/search_filter_header.dart';
import '../../../core/widgets/status_filter_chip.dart';
import '../../../core/widgets/fullscreen_gallery.dart';
import '../../../core/widgets/glass_scaffold.dart';
import '../../../utils/snackbar.dart';
import '../../feedback/bug_report_repository.dart';
import 'admin_bug_report_providers.dart';

/// Filter options for admin bug reports.
enum _AdminBugFilter {
  all('All'),
  open('Open'),
  userReplied('User Replied'),
  responded('Responded'),
  resolved('Resolved'),
  anonymous('Anonymous');

  const _AdminBugFilter(this.label);
  final String label;
}

/// Admin screen for viewing and responding to all bug reports.
class AdminBugReportsScreen extends ConsumerStatefulWidget {
  const AdminBugReportsScreen({super.key});

  @override
  ConsumerState<AdminBugReportsScreen> createState() =>
      _AdminBugReportsScreenState();
}

class _AdminBugReportsScreenState extends ConsumerState<AdminBugReportsScreen>
    with LifecycleSafeMixin<AdminBugReportsScreen> {
  _AdminBugFilter _activeFilter = _AdminBugFilter.open;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  final Set<String> _expandedIds = {};
  final Map<String, TextEditingController> _replyControllers = {};
  final Map<String, BugReportStatus> _optimisticStatuses = {};
  final Set<String> _updatingStatus = {};
  final Set<String> _sendingReply = {};

  @override
  void dispose() {
    _searchController.dispose();
    for (final controller in _replyControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  BugReportStatus _effectiveStatus(AdminBugReport r) =>
      _optimisticStatuses[r.id] ?? r.status;

  List<AdminBugReport> _applyFilters(List<AdminBugReport> reports) {
    var filtered = reports;

    switch (_activeFilter) {
      case _AdminBugFilter.all:
        break;
      case _AdminBugFilter.open:
        filtered = filtered
            .where((r) => _effectiveStatus(r) == BugReportStatus.open)
            .toList();
      case _AdminBugFilter.userReplied:
        filtered = filtered
            .where((r) => _effectiveStatus(r) == BugReportStatus.userReplied)
            .toList();
      case _AdminBugFilter.responded:
        filtered = filtered
            .where((r) => _effectiveStatus(r) == BugReportStatus.responded)
            .toList();
      case _AdminBugFilter.resolved:
        filtered = filtered
            .where((r) => _effectiveStatus(r) == BugReportStatus.resolved)
            .toList();
      case _AdminBugFilter.anonymous:
        filtered = filtered.where((r) => r.isAnonymous).toList();
    }

    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      filtered = filtered.where((r) {
        return r.description.toLowerCase().contains(q) ||
            (r.uid ?? '').toLowerCase().contains(q) ||
            (r.email ?? '').toLowerCase().contains(q) ||
            (r.platform ?? '').toLowerCase().contains(q) ||
            r.id.toLowerCase().contains(q);
      }).toList();
    }

    return filtered;
  }

  Map<_AdminBugFilter, int> _computeCounts(List<AdminBugReport> reports) {
    return {
      _AdminBugFilter.all: reports.length,
      _AdminBugFilter.open: reports
          .where((r) => r.status == BugReportStatus.open)
          .length,
      _AdminBugFilter.userReplied: reports
          .where((r) => r.status == BugReportStatus.userReplied)
          .length,
      _AdminBugFilter.responded: reports
          .where((r) => _effectiveStatus(r) == BugReportStatus.responded)
          .length,
      _AdminBugFilter.resolved: reports
          .where((r) => _effectiveStatus(r) == BugReportStatus.resolved)
          .length,
      _AdminBugFilter.anonymous: reports.where((r) => r.isAnonymous).length,
    };
  }

  @override
  Widget build(BuildContext context) {
    final reportsAsync = ref.watch(adminBugReportsProvider);

    return GestureDetector(
      onTap: _dismissKeyboard,
      child: GlassScaffold(
        title: 'Bug Reports',
        slivers: [
          reportsAsync.when(
            data: (reports) {
              final counts = _computeCounts(reports);
              final filtered = _applyFilters(reports);

              return SliverMainAxisGroup(
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: SearchFilterHeaderDelegate(
                      searchController: _searchController,
                      searchQuery: _searchQuery,
                      onSearchChanged: (value) =>
                          setState(() => _searchQuery = value),
                      hintText: 'Search reports',
                      textScaler: MediaQuery.textScalerOf(context),
                      rebuildKey: Object.hashAll([
                        _activeFilter,
                        ...counts.values,
                      ]),
                      filterChips: _AdminBugFilter.values.map((filter) {
                        return StatusFilterChip(
                          label: filter.label,
                          count: counts[filter] ?? 0,
                          color: _filterColor(filter),
                          isSelected: _activeFilter == filter,
                          onTap: () => setState(() => _activeFilter = filter),
                        );
                      }).toList(),
                    ),
                  ),
                  if (filtered.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: _EmptyState(hasReports: reports.isNotEmpty),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacing16,
                      ),
                      sliver: SliverList.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final report = filtered[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppTheme.spacing12,
                            ),
                            child: _ReportCard(
                              report: report,
                              isExpanded: _expandedIds.contains(report.id),
                              replyController: _getReplyController(report.id),
                              onToggle: () => _toggleReport(report),
                              onSendReply: () => _sendReply(report.id),
                              statusOverride: _optimisticStatuses[report.id],
                              isStatusUpdating: _updatingStatus.contains(
                                report.id,
                              ),
                              isSendingReply: _sendingReply.contains(report.id),
                              onResolve: () =>
                                  _updateStatus(report.id, 'resolved'),
                              onReopen: () => _updateStatus(report.id, 'open'),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, _) => SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.red.shade400,
                    ),
                    const SizedBox(height: AppTheme.spacing16),
                    Text(
                      'Failed to load reports',
                      style: TextStyle(color: context.textSecondary),
                    ),
                    const SizedBox(height: AppTheme.spacing8),
                    Text(
                      error.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: context.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _dismissKeyboard() {
    FocusScope.of(context).unfocus();
  }

  Color _filterColor(_AdminBugFilter filter) {
    return switch (filter) {
      _AdminBugFilter.all => Colors.grey,
      _AdminBugFilter.open => Colors.amber,
      _AdminBugFilter.userReplied => Colors.blue,
      _AdminBugFilter.responded => Colors.purple,
      _AdminBugFilter.resolved => Colors.green,
      _AdminBugFilter.anonymous => Colors.orange,
    };
  }

  TextEditingController _getReplyController(String reportId) {
    return _replyControllers.putIfAbsent(
      reportId,
      () => TextEditingController(),
    );
  }

  void _toggleReport(AdminBugReport report) {
    HapticFeedback.selectionClick();
    setState(() {
      if (_expandedIds.contains(report.id)) {
        _expandedIds.remove(report.id);
      } else {
        _expandedIds.add(report.id);
        // Mark user responses as read when expanding
        if (report.hasUnreadUserReplies) {
          ref
              .read(adminBugReportRepositoryProvider)
              .markUserResponsesAsRead(report.id);
        }
      }
    });
  }

  Future<void> _sendReply(String reportId) async {
    final controller = _replyControllers[reportId];
    if (controller == null) return;

    final message = controller.text.trim();
    if (message.isEmpty) return;
    if (_sendingReply.contains(reportId)) return;
    if (message.length > 2000) {
      if (mounted) {
        showErrorSnackBar(context, 'Message exceeds 2,000 characters.');
      }
      return;
    }

    setState(() => _sendingReply.add(reportId));
    try {
      await ref
          .read(adminBugReportRepositoryProvider)
          .respondToReport(reportId: reportId, message: message);
      controller.clear();
      if (mounted) {
        showSuccessSnackBar(context, 'Response sent.');
      }
    } catch (e) {
      if (mounted) {
        showErrorSnackBar(context, 'Failed to send: \$e');
      }
    } finally {
      if (mounted) {
        setState(() => _sendingReply.remove(reportId));
      }
    }
  }

  Future<void> _updateStatus(String reportId, String status) async {
    if (_updatingStatus.contains(reportId)) return;
    setState(() {
      _optimisticStatuses[reportId] = BugReportStatus.fromString(status);
      _updatingStatus.add(reportId);
    });
    try {
      await ref
          .read(adminBugReportRepositoryProvider)
          .updateReportStatus(reportId: reportId, status: status);
      if (mounted) {
        showSuccessSnackBar(
          context,
          status == 'resolved' ? 'Report resolved.' : 'Report reopened.',
        );
      }
    } catch (e) {
      if (mounted) {
        showErrorSnackBar(context, 'Failed to update status: $e');
      }
    }
  }
}

// ---------------------------------------------------------------------------
// Search bar

// ---------------------------------------------------------------------------
// Report card
// ---------------------------------------------------------------------------

class _ReportCard extends StatelessWidget {
  const _ReportCard({
    required this.report,
    this.statusOverride,
    this.isStatusUpdating = false,
    this.isSendingReply = false,
    required this.isExpanded,
    required this.replyController,
    required this.onToggle,
    required this.onSendReply,
    required this.onResolve,
    required this.onReopen,
  });

  final AdminBugReport report;
  final BugReportStatus? statusOverride;
  final bool isStatusUpdating;
  final bool isSendingReply;
  final bool isExpanded;
  final TextEditingController replyController;
  final VoidCallback onToggle;
  final VoidCallback onSendReply;
  final VoidCallback onResolve;
  final VoidCallback onReopen;

  BugReportStatus get _effectiveStatus => statusOverride ?? report.status;

  Color _statusColor() {
    return switch (_effectiveStatus) {
      BugReportStatus.open => Colors.amber,
      BugReportStatus.userReplied => Colors.blue,
      BugReportStatus.responded => Colors.purple,
      BugReportStatus.resolved => Colors.green,
    };
  }

  String _statusLabel() {
    return switch (_effectiveStatus) {
      BugReportStatus.open => 'OPEN',
      BugReportStatus.userReplied => 'USER REPLIED',
      BugReportStatus.responded => 'RESPONDED',
      BugReportStatus.resolved => 'RESOLVED',
    };
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return DateFormat('d MMM y, HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor();
    final desc = report.description;
    final preview = desc.length > 120 ? '${desc.substring(0, 117)}...' : desc;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius12),
        border: Border.all(
          color: report.hasUnreadUserReplies
              ? Colors.pink
              : isExpanded
              ? Colors.purple
              : Colors.white.withValues(alpha: 0.08),
          width: report.hasUnreadUserReplies ? 1.5 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header (always visible)
          InkWell(
            onTap: onToggle,
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          preview,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: AppTheme.spacing6),
                        Wrap(
                          spacing: 12,
                          runSpacing: 4,
                          children: [
                            _MetaChip(
                              icon: Icons.schedule,
                              text: _formatDate(report.createdAt),
                            ),
                            if (report.deviceModel != null ||
                                report.platform != null)
                              _MetaChip(
                                icon: Icons.devices,
                                text: [
                                  report.deviceModel ?? report.platform,
                                  report.osVersion ?? report.platformVersion,
                                ].whereType<String>().join(' · '),
                              ),
                            if (report.appVersion != null)
                              _MetaChip(
                                icon: Icons.label_outline,
                                text:
                                    'v${report.appVersion}${report.buildNumber != null ? ' (${report.buildNumber})' : ''}',
                              ),
                            if (report.responses.isNotEmpty)
                              _MetaChip(
                                icon: Icons.chat_bubble_outline,
                                text: '${report.responses.length}',
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (report.unreadUserReplyCount > 0)
                            Container(
                              margin: const EdgeInsets.only(
                                right: AppTheme.spacing8,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppTheme.spacing8,
                                vertical: AppTheme.spacing2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.pink,
                                borderRadius: BorderRadius.circular(
                                  AppTheme.radius11,
                                ),
                              ),
                              child: Text(
                                '${report.unreadUserReplyCount}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spacing8,
                              vertical: AppTheme.spacing3,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(
                                AppTheme.radius8,
                              ),
                            ),
                            child: Text(
                              _statusLabel(),
                              style: TextStyle(
                                color: statusColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.spacing8),
                      AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: Icon(
                          Icons.expand_more,
                          size: 20,
                          color: context.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Expanded body
          if (isExpanded) ...[
            Divider(height: 1, color: Colors.white.withValues(alpha: 0.06)),

            // Description
            _Section(
              label: 'DESCRIPTION',
              child: SelectableText(
                desc,
                style: TextStyle(
                  fontSize: 13,
                  height: 1.6,
                  color: context.textSecondary,
                ),
              ),
            ),

            // Screenshot
            if (report.screenshotUrl != null)
              _Section(
                label: 'SCREENSHOT',
                child: GestureDetector(
                  onTap: () => _showScreenshot(context),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppTheme.radius8),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 300),
                      child: Image.network(
                        report.screenshotUrl!,
                        fit: BoxFit.contain,
                        loadingBuilder: (_, child, progress) {
                          if (progress == null) return child;
                          return const SizedBox(
                            height: 200,
                            child: Center(
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          );
                        },
                        errorBuilder: (_, _, _) => Container(
                          height: 100,
                          color: Colors.white.withValues(alpha: 0.05),
                          child: const Center(
                            child: Icon(Icons.broken_image_outlined),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            // Details grid
            _Section(
              label: 'DETAILS',
              child: Wrap(
                spacing: 16,
                runSpacing: 10,
                children: [
                  _DetailItem(label: 'Report ID', value: report.id),
                  _DetailItem(
                    label: 'User ID',
                    value: report.uid ?? 'anonymous',
                  ),
                  if (report.email != null)
                    _DetailItem(label: 'Email', value: report.email!),
                  if (report.deviceModel != null)
                    _DetailItem(label: 'Device', value: report.deviceModel!),
                  if (report.osVersion != null ||
                      report.platformVersion != null)
                    _DetailItem(
                      label: 'OS Version',
                      value: report.osVersion ?? report.platformVersion ?? '',
                    ),
                  if (report.appVersion != null)
                    _DetailItem(
                      label: 'App Version',
                      value:
                          'v${report.appVersion}${report.buildNumber != null ? ' (${report.buildNumber})' : ''}',
                    ),
                ],
              ),
            ),

            // Conversation thread
            if (report.responses.isNotEmpty)
              _Section(
                label: 'CONVERSATION',
                child: Column(
                  children: report.responses
                      .map((r) => _ThreadBubble(response: r))
                      .toList(),
                ),
              ),

            // Reply box
            if (!report.isAnonymous)
              _ReplyBox(
                controller: replyController,
                isResolved: _effectiveStatus == BugReportStatus.resolved,
                isStatusUpdating: isStatusUpdating,
                isSendingReply: isSendingReply,
                onSend: onSendReply,
                onResolve: onResolve,
                onReopen: onReopen,
              )
            else
              _AnonymousReplyBox(
                isResolved: _effectiveStatus == BugReportStatus.resolved,
                isStatusUpdating: isStatusUpdating,
                onResolve: onResolve,
                onReopen: onReopen,
              ),
          ],
        ],
      ),
    );
  }

  void _showScreenshot(BuildContext context) {
    if (report.screenshotUrl == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            FullscreenGallery(images: [report.screenshotUrl!], initialIndex: 0),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Small helper widgets
// ---------------------------------------------------------------------------

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.text});
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: context.textSecondary),
        const SizedBox(width: AppTheme.spacing3),
        Text(
          text,
          style: TextStyle(fontSize: 11, color: context.textSecondary),
        ),
      ],
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Divider(height: 1, color: Colors.white.withValues(alpha: 0.04)),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppTheme.spacing16,
            AppTheme.spacing14,
            AppTheme.spacing16,
            AppTheme.spacing10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                  color: context.textSecondary,
                ),
              ),
              const SizedBox(height: AppTheme.spacing8),
              child,
            ],
          ),
        ),
      ],
    );
  }
}

class _DetailItem extends StatelessWidget {
  const _DetailItem({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: context.textSecondary,
            ),
          ),
          const SizedBox(height: AppTheme.spacing2),
          Text(
            value,
            style: const TextStyle(fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _ThreadBubble extends StatelessWidget {
  const _ThreadBubble({required this.response});
  final BugReportResponse response;

  @override
  Widget build(BuildContext context) {
    final isFounder = response.isFromFounder;
    return Align(
      alignment: isFounder ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacing14,
          vertical: AppTheme.spacing10,
        ),
        decoration: BoxDecoration(
          color: isFounder
              ? Colors.pink.withValues(alpha: 0.15)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(AppTheme.radius12),
            topRight: const Radius.circular(AppTheme.radius12),
            bottomLeft: Radius.circular(isFounder ? 12 : 4),
            bottomRight: Radius.circular(isFounder ? 4 : 12),
          ),
        ),
        child: Column(
          crossAxisAlignment: isFounder
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              response.message,
              style: const TextStyle(fontSize: 13, height: 1.5),
            ),
            const SizedBox(height: AppTheme.spacing4),
            Text(
              '${isFounder ? "You" : "User"} · ${_formatDate(response.createdAt)}',
              style: TextStyle(fontSize: 10, color: context.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return DateFormat('d MMM, HH:mm').format(date);
  }
}

class _ReplyBox extends StatelessWidget {
  const _ReplyBox({
    required this.controller,
    required this.isResolved,
    this.isStatusUpdating = false,
    this.isSendingReply = false,
    required this.onSend,
    required this.onResolve,
    required this.onReopen,
  });

  final TextEditingController controller;
  final bool isResolved;
  final bool isStatusUpdating;
  final bool isSendingReply;
  final VoidCallback onSend;
  final VoidCallback onResolve;
  final VoidCallback onReopen;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing14),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
        ),
        color: Colors.white.withValues(alpha: 0.02),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              maxLines: 4,
              minLines: 1,
              maxLength: 2000,
              style: const TextStyle(fontSize: 13),
              decoration: InputDecoration(
                hintText: 'Write a response...',
                hintStyle: TextStyle(color: context.textSecondary),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radius12),
                  borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radius12),
                  borderSide: BorderSide(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radius12),
                  borderSide: const BorderSide(color: Colors.pink),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing14,
                  vertical: AppTheme.spacing10,
                ),
                counterText: '',
                isDense: true,
              ),
            ),
          ),
          const SizedBox(width: AppTheme.spacing10),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 42,
                height: 42,
                child: isSendingReply
                    ? const Center(
                        child: SizedBox(
                          width: AppTheme.spacing20,
                          height: AppTheme.spacing20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.pink,
                          ),
                        ),
                      )
                    : IconButton.filled(
                        onPressed: onSend,
                        icon: const Icon(Icons.send, size: 18),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.pink,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppTheme.radius12,
                            ),
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: AppTheme.spacing6),
              if (isResolved)
                _SmallActionButton(
                  label: 'Reopen',
                  color: Colors.amber,
                  isLoading: isStatusUpdating,
                  onTap: onReopen,
                )
              else
                _SmallActionButton(
                  label: 'Resolve',
                  color: Colors.green,
                  isLoading: isStatusUpdating,
                  onTap: onResolve,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AnonymousReplyBox extends StatelessWidget {
  const _AnonymousReplyBox({
    required this.isResolved,
    this.isStatusUpdating = false,
    required this.onResolve,
    required this.onReopen,
  });

  final bool isResolved;
  final bool isStatusUpdating;
  final VoidCallback onResolve;
  final VoidCallback onReopen;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing14),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
        ),
        color: Colors.white.withValues(alpha: 0.02),
      ),
      child: Row(
        children: [
          Icon(Icons.block, size: 16, color: Colors.orange.shade400),
          const SizedBox(width: AppTheme.spacing8),
          Expanded(
            child: Text(
              'Anonymous report — replies cannot be delivered.',
              style: TextStyle(fontSize: 12, color: Colors.orange.shade400),
            ),
          ),
          if (isResolved)
            _SmallActionButton(
              label: 'Reopen',
              color: Colors.amber,
              isLoading: isStatusUpdating,
              onTap: onReopen,
            )
          else
            _SmallActionButton(
              label: 'Resolve',
              color: Colors.green,
              isLoading: isStatusUpdating,
              onTap: onResolve,
            ),
        ],
      ),
    );
  }
}

class _SmallActionButton extends StatelessWidget {
  const _SmallActionButton({
    required this.label,
    required this.color,
    this.isLoading = false,
    required this.onTap,
  });

  final String label;
  final Color color;
  final bool isLoading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading
          ? null
          : () {
              HapticFeedback.selectionClick();
              onTap();
            },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isLoading ? 0.5 : 1.0,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacing10,
            vertical: AppTheme.spacing5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTheme.radius8),
            border: Border.all(color: color),
          ),
          child: isLoading
              ? SizedBox(
                  width: AppTheme.spacing12,
                  height: AppTheme.spacing12,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    color: color,
                  ),
                )
              : Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.hasReports});
  final bool hasReports;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing60),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.inbox,
              size: 48,
              color: Colors.white.withValues(alpha: 0.2),
            ),
            const SizedBox(height: AppTheme.spacing16),
            Text(
              hasReports
                  ? 'No reports match your filter.'
                  : 'No bug reports yet.',
              style: TextStyle(color: context.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
