// SPDX-License-Identifier: GPL-3.0-or-later
// lint-allow: scaffold — immersive fullscreen black gallery overlay

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme.dart';
import '../../../services/file_transfer/file_transfer_engine.dart';

/// A fullscreen gallery view for file transfer images.
///
/// Supports two image sources:
/// - In-memory [Uint8List] bytes (from [FileTransferState.fileBytes])
/// - On-disk file path (from [FileTransferState.savedFilePath])
///
/// Follows the same immersive gallery pattern as [LocalImageGallery] and
/// [FullscreenGallery]: black background, pinch-to-zoom via
/// [InteractiveViewer], overlay top bar with close button and filename,
/// tap-to-dismiss, and fade transition on entry.
class FileTransferImageGallery extends StatefulWidget {
  const FileTransferImageGallery._({
    required this.filename,
    this.imageBytes,
    this.imagePath,
  });

  /// The filename to display in the top bar.
  final String filename;

  /// In-memory image bytes (mutually exclusive with [imagePath] in practice,
  /// but bytes take priority when both are available).
  final Uint8List? imageBytes;

  /// On-disk file path for the image.
  final String? imagePath;

  /// Returns `true` if the given transfer is a completed image that can be
  /// displayed in the gallery.
  static bool canShow(FileTransferState transfer) {
    if (transfer.state != TransferState.complete) return false;
    if (!transfer.mimeType.toLowerCase().startsWith('image/')) return false;
    final hasBytes =
        transfer.fileBytes != null && transfer.fileBytes!.isNotEmpty;
    final hasPath = transfer.savedFilePath != null;
    return hasBytes || hasPath;
  }

  /// Shows a fullscreen image gallery for the given [transfer].
  ///
  /// The transfer must be a completed image transfer. Call [canShow] first
  /// to verify eligibility. Returns immediately if the transfer cannot be
  /// shown.
  static void show(
    BuildContext context, {
    required FileTransferState transfer,
  }) {
    if (!canShow(transfer)) return;

    Navigator.of(context).push(
      PageRouteBuilder<void>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            FileTransferImageGallery._(
              filename: transfer.filename,
              imageBytes: transfer.fileBytes,
              imagePath: transfer.savedFilePath,
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
        transitionDuration: const Duration(milliseconds: 200),
        opaque: false,
        barrierColor: Colors.black87,
      ),
    );
  }

  @override
  State<FileTransferImageGallery> createState() =>
      _FileTransferImageGalleryState();
}

class _FileTransferImageGalleryState extends State<FileTransferImageGallery> {
  bool _overlayVisible = true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  void _toggleOverlay() {
    HapticFeedback.lightImpact();
    setState(() => _overlayVisible = !_overlayVisible);
  }

  Widget _buildImage() {
    final bytes = widget.imageBytes;
    if (bytes != null && bytes.isNotEmpty) {
      return Image.memory(
        bytes,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
      );
    }

    final path = widget.imagePath;
    if (path != null) {
      return Image.file(
        File(path),
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
      );
    }

    return _buildErrorWidget();
  }

  Widget _buildErrorWidget() {
    return const Icon(
      Icons.broken_image_outlined,
      size: 64,
      color: Colors.white38,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Full-screen image with pinch-to-zoom
          GestureDetector(
            onTap: _toggleOverlay,
            child: InteractiveViewer(
              minScale: 0.5,
              maxScale: 4.0,
              child: Center(child: _buildImage()),
            ),
          ),

          // Top bar overlay with filename and close button
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: IgnorePointer(
              ignoring: !_overlayVisible,
              child: AnimatedOpacity(
                opacity: _overlayVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 200),
                child: SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.7),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: AppTheme.spacing8),
                        // Filename pill
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(
                                AppTheme.radius16,
                              ),
                            ),
                            child: Text(
                              widget.filename,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppTheme.spacing8),
                        // Close button
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
