// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme.dart';
import '../../../core/widgets/animations.dart';
import '../../../providers/app_providers.dart';
import '../../../services/file_transfer/file_transfer_engine.dart';
import '../../nodes/node_display_name_resolver.dart';

/// A card widget for displaying a file transfer (sending or receiving).
///
/// Used in both the Signals feed and NodeDex detail screen.
/// Follows the same card pattern as [SignalCard].
class FileTransferCard extends ConsumerWidget {
  const FileTransferCard({
    super.key,
    required this.transfer,
    this.onTap,
    this.onCancel,
    this.onRetry,
    this.onShare,
    this.onAccept,
    this.onReject,
    this.onDelete,
    this.compact = false,
  });

  final FileTransferState transfer;
  final VoidCallback? onTap;
  final VoidCallback? onCancel;
  final VoidCallback? onRetry;
  final VoidCallback? onShare;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final VoidCallback? onDelete;
  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BouncyTap(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: context.card,
          borderRadius: BorderRadius.circular(AppTheme.radius12),
          border: Border.all(color: context.border.withValues(alpha: 0.5)),
        ),
        child: compact
            ? Padding(
                padding: const EdgeInsets.all(AppTheme.spacing10),
                child: _buildCompact(context),
              )
            : _buildFullCard(context, ref),
      ),
    );
  }

  Widget _buildFullCard(BuildContext context, WidgetRef ref) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Colored accent stripe
          Container(
            width: 3,
            decoration: BoxDecoration(
              color: _statusColor(context),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppTheme.radius12),
                bottomLeft: Radius.circular(AppTheme.radius12),
              ),
            ),
          ),
          // Card content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.spacing12),
              child: _buildFull(context, ref),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompact(BuildContext context) {
    return Row(
      children: [
        _FileTypeIcon(mimeType: transfer.mimeType, size: 28),
        const SizedBox(width: AppTheme.spacing8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transfer.filename,
                style: TextStyle(
                  color: context.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppTheme.spacing2),
              Text(
                _statusText,
                style: TextStyle(color: _statusColor(context), fontSize: 11),
              ),
            ],
          ),
        ),
        if (transfer.isActive)
          SizedBox(
            width: 32,
            height: 32,
            child: _ProgressRing(progress: transfer.progress),
          ),
      ],
    );
  }

  Widget _buildFull(BuildContext context, WidgetRef ref) {
    // Resolve node display name
    final nodes = ref.watch(nodesProvider);
    String? nodeName;
    if (transfer.direction == TransferDirection.outbound &&
        transfer.targetNodeNum != null) {
      final node = nodes[transfer.targetNodeNum!];
      nodeName = NodeDisplayNameResolver.resolve(
        nodeNum: transfer.targetNodeNum!,
        longName: node?.longName,
        shortName: node?.shortName,
      );
    } else if (transfer.direction == TransferDirection.inbound &&
        transfer.sourceNodeNum != null) {
      final node = nodes[transfer.sourceNodeNum!];
      nodeName = NodeDisplayNameResolver.resolve(
        nodeNum: transfer.sourceNodeNum!,
        longName: node?.longName,
        shortName: node?.shortName,
      );
    }

    final metaText = _buildMetadataText(nodeName);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row: icon + filename + direction badge
        Row(
          children: [
            _FileTypeIcon(mimeType: transfer.mimeType, size: 36),
            const SizedBox(width: AppTheme.spacing10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transfer.filename,
                    style: TextStyle(
                      color: context.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppTheme.spacing2),
                  Text(
                    metaText,
                    style: TextStyle(color: context.textTertiary, fontSize: 12),
                  ),
                  const SizedBox(height: AppTheme.spacing4),
                  Wrap(
                    spacing: AppTheme.spacing4,
                    runSpacing: AppTheme.spacing4,
                    children: [
                      _InfoChip(label: transfer.mimeType),
                      _InfoChip(label: _technicalInfoText),
                    ],
                  ),
                ],
              ),
            ),
            _DirectionBadge(direction: transfer.direction),
          ],
        ),

        const SizedBox(height: AppTheme.spacing10),

        // Progress bar
        if (transfer.isActive) ...[
          _TransferProgressBar(
            progress: transfer.progress,
            color: _statusColor(context),
          ),
          const SizedBox(height: AppTheme.spacing6),
        ],

        // Status row
        Row(
          children: [
            Icon(_statusIcon, size: 14, color: _statusColor(context)),
            const SizedBox(width: AppTheme.spacing4),
            Expanded(
              child: Text(
                _statusText,
                style: TextStyle(
                  color: _statusColor(context),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // Chunk progress text for active, timestamp for terminal
            if (transfer.isActive)
              Text(
                '${transfer.completedChunks.length}/${transfer.chunkCount} chunks',
                style: TextStyle(color: context.textTertiary, fontSize: 11),
              )
            else
              Text(
                _relativeTime(transfer.completedAt ?? transfer.createdAt),
                style: TextStyle(color: context.textTertiary, fontSize: 11),
              ),
          ],
        ),

        // Action buttons
        if (_showActions) ...[
          const SizedBox(height: AppTheme.spacing10),
          _ActionRow(
            transfer: transfer,
            onCancel: onCancel,
            onRetry: onRetry,
            onShare: onShare,
            onAccept: onAccept,
            onReject: onReject,
            onDelete: onDelete,
          ),
        ],
      ],
    );
  }

  bool get _showActions =>
      onCancel != null ||
      onRetry != null ||
      onShare != null ||
      onAccept != null ||
      onReject != null ||
      onDelete != null;

  String get _statusText {
    switch (transfer.state) {
      case TransferState.created:
        return 'Preparing...';
      case TransferState.offerSent:
        return 'Offer sent, waiting...';
      case TransferState.offerPending:
        return 'Incoming file — tap to review';
      case TransferState.chunking:
        final pct = (transfer.progress * 100).toStringAsFixed(0);
        return transfer.direction == TransferDirection.outbound
            ? 'Sending $pct%'
            : 'Receiving $pct%';
      case TransferState.waitingMissing:
        return 'Recovering missing chunks...';
      case TransferState.complete:
        return 'Complete';
      case TransferState.failed:
        return _failReasonText;
      case TransferState.cancelled:
        return 'Cancelled';
    }
  }

  String get _failReasonText {
    switch (transfer.failReason) {
      case TransferFailReason.oversized:
        return 'File too large for mesh transfer';
      case TransferFailReason.timeout:
        return 'Transfer timed out';
      case TransferFailReason.invalid:
        return 'Invalid data received';
      case TransferFailReason.userCancelled:
        return 'Cancelled';
      case TransferFailReason.rateLimited:
        return 'Rate limited — try again later';
      case TransferFailReason.hashMismatch:
        return 'File verification failed';
      case TransferFailReason.maxRetries:
        return 'Max retries exceeded';
      case TransferFailReason.expired:
        return 'Transfer expired';
      case null:
        return 'Failed';
    }
  }

  IconData get _statusIcon {
    switch (transfer.state) {
      case TransferState.created:
      case TransferState.offerSent:
        return Icons.schedule;
      case TransferState.offerPending:
        return Icons.inbox;
      case TransferState.chunking:
        return transfer.direction == TransferDirection.outbound
            ? Icons.upload
            : Icons.download;
      case TransferState.waitingMissing:
        return Icons.sync_problem;
      case TransferState.complete:
        return Icons.check_circle;
      case TransferState.failed:
        return Icons.error_outline;
      case TransferState.cancelled:
        return Icons.cancel_outlined;
    }
  }

  Color _statusColor(BuildContext context) {
    switch (transfer.state) {
      case TransferState.created:
      case TransferState.offerSent:
        return context.textTertiary;
      case TransferState.offerPending:
        return SemanticColors.warning;
      case TransferState.chunking:
        return context.accentColor;
      case TransferState.waitingMissing:
        return SemanticColors.warning;
      case TransferState.complete:
        return SemanticColors.success;
      case TransferState.failed:
        return SemanticColors.error;
      case TransferState.cancelled:
        return context.textTertiary;
    }
  }

  String get _fileSizeText {
    if (transfer.totalBytes < 1024) {
      return '${transfer.totalBytes} B';
    }
    final kb = transfer.totalBytes / 1024.0;
    return '${kb.toStringAsFixed(1)} KB';
  }

  String _relativeTime(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${dt.month}/${dt.day}';
  }

  String _buildMetadataText(String? nodeName) {
    final parts = <String>[_fileSizeText];
    if (transfer.direction == TransferDirection.outbound) {
      if (nodeName != null) {
        parts.add('to $nodeName');
      } else if (transfer.targetNodeNum != null) {
        parts.add('to !${transfer.targetNodeNum!.toRadixString(16)}');
      }
    } else {
      if (nodeName != null) {
        parts.add('from $nodeName');
      } else if (transfer.sourceNodeNum != null) {
        parts.add('from !${transfer.sourceNodeNum!.toRadixString(16)}');
      }
    }
    return parts.join(' · ');
  }

  String get _technicalInfoText {
    final ext = transfer.filename.contains('.')
        ? transfer.filename.split('.').last.toUpperCase()
        : null;
    final typeLabel = _fileTypeLabel;
    final chunkInfo = '${transfer.chunkCount} chunks';
    final chunkSize = _formatBytes(transfer.chunkSize);
    final parts = <String>[
      if (ext != null) ext,
      typeLabel,
      '$chunkInfo · $chunkSize ea.',
    ];
    return parts.join(' · ');
  }

  String get _fileTypeLabel {
    final mime = transfer.mimeType.toLowerCase();
    if (mime.startsWith('image/')) return 'Image';
    if (mime == 'text/csv') return 'Spreadsheet';
    if (mime == 'text/html') return 'HTML';
    if (mime == 'text/markdown') return 'Markdown';
    if (mime.startsWith('text/')) return 'Text';
    if (mime.contains('gpx')) return 'GPS Track';
    if (mime.contains('kml') || mime.contains('kmz')) return 'Map';
    if (mime.contains('json')) return 'JSON';
    if (mime.contains('xml')) return 'XML';
    if (mime.contains('yaml') || mime.contains('yml')) return 'YAML';
    if (mime.contains('protobuf')) return 'Protobuf';
    if (mime.contains('pdf')) return 'PDF';
    if (mime.contains('zip') ||
        mime.contains('gzip') ||
        mime.contains('tar') ||
        mime.contains('7z') ||
        mime.contains('rar')) {
      return 'Archive';
    }
    if (mime.startsWith('audio/')) return 'Audio';
    if (mime.startsWith('video/')) return 'Video';
    if (mime.contains('firmware') || mime.contains('octet-stream')) {
      return 'Binary';
    }
    return 'File';
  }

  static String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    final kb = bytes / 1024.0;
    return '${kb.toStringAsFixed(1)} KB';
  }
}

// ---------------------------------------------------------------------------
// Sub-widgets
// ---------------------------------------------------------------------------

class _FileTypeIcon extends StatelessWidget {
  const _FileTypeIcon({required this.mimeType, this.size = 36});

  final String mimeType;
  final double size;

  @override
  Widget build(BuildContext context) {
    return FileTypeIcon(mimeType: mimeType, size: size);
  }
}

/// Icon widget that displays a visual indicator for a file's MIME type.
///
/// Shows an appropriate icon and color based on the file type category.
/// Used in file transfer cards, attachment previews, and file lists.
class FileTypeIcon extends StatelessWidget {
  const FileTypeIcon({super.key, required this.mimeType, this.size = 36});

  final String mimeType;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: iconColor(context).withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppTheme.radius8),
      ),
      child: Icon(icon, size: size * 0.55, color: iconColor(context)),
    );
  }

  /// The icon to display for this MIME type.
  IconData get icon {
    final mime = mimeType.toLowerCase();

    // Images
    if (mime.startsWith('image/')) return Icons.image;

    // Text types
    if (mime == 'text/csv') return Icons.table_chart;
    if (mime == 'text/html') return Icons.code;
    if (mime == 'text/markdown') return Icons.article;
    if (mime.startsWith('text/')) return Icons.description;

    // Geospatial
    if (mime.contains('gpx')) return Icons.route;
    if (mime.contains('kml') || mime.contains('kmz')) return Icons.map;

    // Data formats
    if (mime.contains('json')) return Icons.data_object;
    if (mime.contains('xml')) return Icons.code;
    if (mime.contains('yaml') || mime.contains('yml')) return Icons.settings;
    if (mime.contains('protobuf')) return Icons.memory;

    // Documents
    if (mime.contains('pdf')) return Icons.picture_as_pdf;

    // Archives
    if (mime.contains('zip') ||
        mime.contains('gzip') ||
        mime.contains('tar') ||
        mime.contains('7z') ||
        mime.contains('rar')) {
      return Icons.folder_zip;
    }

    // Audio
    if (mime.startsWith('audio/')) return Icons.audiotrack;

    // Video
    if (mime.startsWith('video/')) return Icons.videocam;

    // Firmware / binary
    if (mime.contains('firmware') || mime.contains('octet-stream')) {
      return Icons.memory;
    }

    return Icons.insert_drive_file;
  }

  /// The accent color for this MIME type.
  Color iconColor(BuildContext context) {
    final mime = mimeType.toLowerCase();

    if (mime.startsWith('image/')) return AppTheme.primaryMagenta;
    if (mime == 'text/csv') return AccentColors.orange;
    if (mime == 'text/html') return AccentColors.red;
    if (mime.startsWith('text/')) return AppTheme.primaryBlue;
    if (mime.contains('json')) return AppTheme.primaryPurple;
    if (mime.contains('xml') || mime.contains('yaml')) {
      return AppTheme.primaryPurple;
    }
    if (mime.contains('gpx') || mime.contains('kml') || mime.contains('kmz')) {
      return SemanticColors.success;
    }
    if (mime.contains('pdf')) return AccentColors.red;
    if (mime.contains('zip') || mime.contains('gzip') || mime.contains('tar')) {
      return AccentColors.orange;
    }
    if (mime.startsWith('audio/')) return AccentColors.cyan;
    if (mime.startsWith('video/')) return AppTheme.primaryMagenta;

    return context.accentColor;
  }
}

class _DirectionBadge extends StatelessWidget {
  const _DirectionBadge({required this.direction});

  final TransferDirection direction;

  @override
  Widget build(BuildContext context) {
    final isOutbound = direction == TransferDirection.outbound;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: (isOutbound ? AppTheme.primaryBlue : AppTheme.primaryPurple)
            .withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppTheme.radius6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isOutbound ? Icons.arrow_upward : Icons.arrow_downward,
            size: 10,
            color: isOutbound ? AppTheme.primaryBlue : AppTheme.primaryPurple,
          ),
          const SizedBox(width: AppTheme.spacing4),
          Text(
            isOutbound ? 'Sent' : 'Received',
            style: TextStyle(
              color: isOutbound ? AppTheme.primaryBlue : AppTheme.primaryPurple,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _TransferProgressBar extends StatelessWidget {
  const _TransferProgressBar({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppTheme.radius4),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: 4,
        backgroundColor: context.border.withValues(alpha: 0.3),
        valueColor: AlwaysStoppedAnimation(color),
      ),
    );
  }
}

class _ProgressRing extends StatelessWidget {
  const _ProgressRing({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircularProgressIndicator(
          value: progress,
          strokeWidth: 2.5,
          backgroundColor: context.border.withValues(alpha: 0.3),
          valueColor: AlwaysStoppedAnimation(context.accentColor),
        ),
        Text(
          '${(progress * 100).toStringAsFixed(0)}%',
          style: TextStyle(
            color: context.textSecondary,
            fontSize: 9,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _ActionRow extends StatelessWidget {
  const _ActionRow({
    required this.transfer,
    this.onCancel,
    this.onRetry,
    this.onShare,
    this.onAccept,
    this.onReject,
    this.onDelete,
  });

  final FileTransferState transfer;
  final VoidCallback? onCancel;
  final VoidCallback? onRetry;
  final VoidCallback? onShare;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Pending offer: accept / reject
        if (transfer.state == TransferState.offerPending) ...[
          if (onReject != null)
            _ActionButton(
              label: 'Reject',
              icon: Icons.close,
              color: SemanticColors.error,
              onTap: onReject!,
            ),
          if (onAccept != null) ...[
            const SizedBox(width: AppTheme.spacing8),
            _ActionButton(
              label: 'Accept',
              icon: Icons.check,
              color: SemanticColors.success,
              onTap: onAccept!,
            ),
          ],
        ],
        // Active transfer: cancel
        if (transfer.isActive &&
            transfer.state != TransferState.offerPending &&
            onCancel != null)
          _ActionButton(
            label: 'Cancel',
            icon: Icons.close,
            color: SemanticColors.error,
            onTap: onCancel!,
          ),
        if (transfer.state == TransferState.failed && onRetry != null) ...[
          const SizedBox(width: AppTheme.spacing8),
          _ActionButton(
            label: 'Retry',
            icon: Icons.refresh,
            color: context.accentColor,
            onTap: onRetry!,
          ),
        ],
        if (transfer.state == TransferState.complete) ...[
          if (onShare != null) ...[
            const SizedBox(width: AppTheme.spacing8),
            _ActionButton(
              label: 'Share',
              icon: Icons.share,
              color: context.accentColor,
              onTap: onShare!,
            ),
          ],
        ],
        // Delete button for terminal transfers
        if (!transfer.isActive && onDelete != null) ...[
          const SizedBox(width: AppTheme.spacing8),
          _ActionButton(
            label: 'Delete',
            icon: Icons.delete_outline,
            color: SemanticColors.error,
            onTap: onDelete!,
          ),
        ],
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: context.border.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(AppTheme.radius6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: context.textTertiary,
          fontSize: 10,
          fontWeight: FontWeight.w500,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radius8),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacing8,
            vertical: AppTheme.spacing4,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: AppTheme.spacing4),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Attachment preview card shown in the composer before sending.
class FileAttachmentPreview extends StatelessWidget {
  const FileAttachmentPreview({
    super.key,
    required this.filename,
    required this.mimeType,
    required this.fileSize,
    required this.chunkCount,
    this.onRemove,
  });

  final String filename;
  final String mimeType;
  final int fileSize;
  final int chunkCount;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing10),
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(AppTheme.radius10),
        border: Border.all(color: context.accentColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          _FileTypeIcon(mimeType: mimeType, size: 32),
          const SizedBox(width: AppTheme.spacing8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  filename,
                  style: TextStyle(
                    color: context.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppTheme.spacing2),
                Text(
                  '${_formatSize(fileSize)} · $chunkCount chunks over mesh',
                  style: TextStyle(color: context.textTertiary, fontSize: 11),
                ),
              ],
            ),
          ),
          if (onRemove != null)
            IconButton(
              onPressed: onRemove,
              icon: Icon(Icons.close, size: 16, color: context.textTertiary),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
        ],
      ),
    );
  }

  String _formatSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    final kb = bytes / 1024.0;
    return '${kb.toStringAsFixed(1)} KB';
  }
}
