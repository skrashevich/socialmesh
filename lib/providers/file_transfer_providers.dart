// SPDX-License-Identifier: GPL-3.0-or-later

import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../core/logging.dart';
import '../services/file_transfer/file_transfer_database.dart';
import '../services/file_transfer/file_transfer_engine.dart';
import '../services/protocol/socialmesh/sm_codec.dart';
import '../services/protocol/socialmesh/sm_constants.dart';
import '../services/protocol/socialmesh/sm_file_transfer.dart';
import 'app_providers.dart';

// ---------------------------------------------------------------------------
// Database provider
// ---------------------------------------------------------------------------

final fileTransferDatabaseProvider = Provider<FileTransferDatabase>((ref) {
  AppLogging.fileTransfer('Provider: creating FileTransferDatabase');
  final db = FileTransferDatabase();
  ref.onDispose(() {
    AppLogging.fileTransfer('Provider: disposing FileTransferDatabase');
    db.close();
  });
  return db;
});

// ---------------------------------------------------------------------------
// Engine provider
// ---------------------------------------------------------------------------

final fileTransferEngineProvider = Provider<FileTransferEngine>((ref) {
  final protocol = ref.watch(protocolServiceProvider);
  late final FileTransferEngine engine;

  AppLogging.fileTransfer('Provider: creating FileTransferEngine');

  engine = FileTransferEngine(
    sendPacket: (payload, portnum, {destinationNode, hopLimit = 3}) async {
      return protocol.sendSmFileTransferPacket(
        payload,
        destinationNode: destinationNode,
        hopLimit: hopLimit,
      );
    },
    onStateChanged: (state) {
      // Persist state changes to database.
      final db = ref.read(fileTransferDatabaseProvider);
      db.saveTransfer(state);

      // Notify the state notifier.
      ref.read(fileTransferStateProvider.notifier).updateTransfer(state);
    },
  );

  // Wire incoming file transfer packets from ProtocolService to the engine.
  protocol.onSmFileTransferPacket =
      ({required type, required packet, required senderNodeNum}) {
        AppLogging.fileTransfer(
          'Provider: routing ${type.name} from '
          '${senderNodeNum.toRadixString(16)} to engine',
        );
        switch (type) {
          case SmPacketType.fileOffer:
            final settingsAsync = ref.read(settingsServiceProvider);
            final autoAccept = settingsAsync.maybeWhen(
              data: (s) => s.fileTransferAutoAccept,
              orElse: () => true,
            );
            engine.handleIncomingOffer(
              packet as SmFileOffer,
              sourceNodeNum: senderNodeNum,
              autoAccept: autoAccept,
            );
          case SmPacketType.fileChunk:
            engine.handleIncomingChunk(
              packet as SmFileChunk,
              sourceNodeNum: senderNodeNum,
            );
          case SmPacketType.fileNack:
            engine.handleIncomingNack(packet as SmFileNack);
          case SmPacketType.fileAck:
            engine.handleIncomingAck(packet as SmFileAck);
          default:
            break;
        }
      };

  ref.onDispose(() {
    AppLogging.fileTransfer('Provider: disposing FileTransferEngine');
    protocol.onSmFileTransferPacket = null;
    engine.dispose();
  });

  return engine;
});

// ---------------------------------------------------------------------------
// Transfer state notifier
// ---------------------------------------------------------------------------

/// Immutable state of all file transfers.
class FileTransferListState {
  final Map<String, FileTransferState> transfers;
  final bool isLoading;

  const FileTransferListState({
    this.transfers = const {},
    this.isLoading = false,
  });

  List<FileTransferState> get sortedTransfers {
    final list = transfers.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list;
  }

  List<FileTransferState> get activeTransfers =>
      sortedTransfers.where((t) => t.isActive).toList();

  List<FileTransferState> get completedTransfers =>
      sortedTransfers.where((t) => t.state == TransferState.complete).toList();

  FileTransferListState copyWith({
    Map<String, FileTransferState>? transfers,
    bool? isLoading,
  }) {
    return FileTransferListState(
      transfers: transfers ?? this.transfers,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class FileTransferStateNotifier extends Notifier<FileTransferListState> {
  @override
  FileTransferListState build() {
    _loadFromDatabase();
    return const FileTransferListState(isLoading: true);
  }

  Future<void> _loadFromDatabase() async {
    AppLogging.fileTransfer('Notifier: loading transfers from database');
    final db = ref.read(fileTransferDatabaseProvider);
    await db.init();
    final transfers = await db.loadAllTransfers();
    final map = {for (final t in transfers) t.fileIdHex: t};
    AppLogging.fileTransfer(
      'Notifier: loaded ${transfers.length} transfers from database',
    );
    state = state.copyWith(transfers: map, isLoading: false);
  }

  /// Update a single transfer state (called by engine callback).
  void updateTransfer(FileTransferState transfer) {
    final updated = Map<String, FileTransferState>.from(state.transfers)
      ..[transfer.fileIdHex] = transfer;
    state = state.copyWith(transfers: updated);
  }

  /// Initiate a new outbound file transfer.
  Future<FileTransferState?> sendFile({
    required String filename,
    required String mimeType,
    required Uint8List fileBytes,
    int? targetNodeNum,
    FileTransportMode transportMode = FileTransportMode.auto,
  }) async {
    // Validate size.
    if (fileBytes.length > SmFileTransferLimits.maxFileSize) {
      AppLogging.fileTransfer(
        'sendFile REJECTED: size ${fileBytes.length} exceeds max '
        '${SmFileTransferLimits.maxFileSize}',
      );
      return null;
    }
    if (fileBytes.isEmpty) {
      AppLogging.fileTransfer('sendFile REJECTED: empty file');
      return null;
    }

    final engine = ref.read(fileTransferEngineProvider);
    final transfer = engine.initiateTransfer(
      filename: filename,
      mimeType: mimeType,
      fileBytes: fileBytes,
      targetNodeNum: targetNodeNum,
      transportMode: transportMode,
    );

    if (transfer == null) return null;

    AppLogging.protocol(
      'File transfer initiated: ${transfer.fileIdHex} '
      '(${transfer.filename}, ${transfer.totalBytes} bytes, '
      '${transfer.chunkCount} chunks)',
    );

    // Start sending.
    await engine.startTransfer(transfer.fileIdHex);
    return transfer;
  }

  /// Pick a file and initiate transfer.
  Future<FileTransferState?> pickAndSendFile({
    int? targetNodeNum,
    FileTransportMode transportMode = FileTransportMode.auto,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      withData: true,
    );

    if (result == null || result.files.isEmpty) return null;
    final file = result.files.first;
    if (file.bytes == null) {
      // Read from path if bytes not available.
      if (file.path == null) return null;
      final bytes = await File(file.path!).readAsBytes();
      return sendFile(
        filename: file.name,
        mimeType: _guessMimeType(file.name),
        fileBytes: bytes,
        targetNodeNum: targetNodeNum,
        transportMode: transportMode,
      );
    }

    return sendFile(
      filename: file.name,
      mimeType: _guessMimeType(file.name),
      fileBytes: Uint8List.fromList(file.bytes!),
      targetNodeNum: targetNodeNum,
      transportMode: transportMode,
    );
  }

  /// Cancel an active transfer.
  void cancelTransfer(String fileIdHex) {
    AppLogging.fileTransfer('cancelTransfer: $fileIdHex');
    final engine = ref.read(fileTransferEngineProvider);
    engine.cancelTransfer(fileIdHex);
  }

  /// Accept a pending inbound transfer.
  void acceptTransfer(String fileIdHex) {
    AppLogging.fileTransfer('Notifier: acceptTransfer $fileIdHex');
    final engine = ref.read(fileTransferEngineProvider);
    engine.acceptTransfer(fileIdHex);
  }

  /// Reject a pending inbound transfer.
  void rejectTransfer(String fileIdHex) {
    AppLogging.fileTransfer('Notifier: rejectTransfer $fileIdHex');
    final engine = ref.read(fileTransferEngineProvider);
    engine.rejectTransfer(fileIdHex);
  }

  /// Request retransmission of missing chunks.
  Future<void> requestMissing(String fileIdHex) async {
    AppLogging.fileTransfer('requestMissing: $fileIdHex');
    final engine = ref.read(fileTransferEngineProvider);
    await engine.requestMissingChunks(fileIdHex);
  }

  /// Save a completed inbound file to the documents directory.
  Future<String?> saveReceivedFile(String fileIdHex) async {
    final transfer = state.transfers[fileIdHex];
    if (transfer == null) {
      AppLogging.fileTransfer('saveReceivedFile: $fileIdHex not found');
      return null;
    }
    if (transfer.state != TransferState.complete) {
      AppLogging.fileTransfer(
        'saveReceivedFile: $fileIdHex not complete '
        '(${transfer.state.name})',
      );
      return null;
    }
    if (transfer.fileBytes == null) {
      AppLogging.fileTransfer('saveReceivedFile: $fileIdHex no file bytes');
      return null;
    }

    final dir = await getApplicationDocumentsDirectory();
    final transferDir = Directory(p.join(dir.path, 'file_transfers'));
    if (!transferDir.existsSync()) {
      await transferDir.create(recursive: true);
    }

    final filePath = p.join(transferDir.path, transfer.filename);
    final file = File(filePath);
    await file.writeAsBytes(transfer.fileBytes!);

    AppLogging.protocol('File saved: ${transfer.filename} → $filePath');

    return filePath;
  }

  /// Purge expired transfers.
  Future<void> purgeExpired() async {
    AppLogging.fileTransfer('purgeExpired: starting');
    final engine = ref.read(fileTransferEngineProvider);
    engine.purgeExpired();

    final db = ref.read(fileTransferDatabaseProvider);
    final count = await db.purgeExpired();
    AppLogging.fileTransfer('purgeExpired: removed $count from database');
  }

  String _guessMimeType(String filename) {
    final ext = p.extension(filename).toLowerCase();
    return switch (ext) {
      '.txt' => 'text/plain',
      '.json' => 'application/json',
      '.csv' => 'text/csv',
      '.gpx' => 'application/gpx+xml',
      '.kml' => 'application/vnd.google-earth.kml+xml',
      '.jpg' || '.jpeg' => 'image/jpeg',
      '.png' => 'image/png',
      '.gif' => 'image/gif',
      '.webp' => 'image/webp',
      '.pdf' => 'application/pdf',
      '.zip' => 'application/zip',
      '.gz' => 'application/gzip',
      _ => 'application/octet-stream',
    };
  }
}

final fileTransferStateProvider =
    NotifierProvider<FileTransferStateNotifier, FileTransferListState>(
      FileTransferStateNotifier.new,
    );

// ---------------------------------------------------------------------------
// Convenience providers
// ---------------------------------------------------------------------------

/// Active transfers count.
final activeTransferCountProvider = Provider<int>((ref) {
  final state = ref.watch(fileTransferStateProvider);
  return state.activeTransfers.length;
});

/// Pending inbound offers awaiting user acceptance.
final pendingTransferCountProvider = Provider<int>((ref) {
  final state = ref.watch(fileTransferStateProvider);
  return state.sortedTransfers
      .where((t) => t.state == TransferState.offerPending)
      .length;
});

/// Transfers for a specific node.
final nodeTransfersProvider = Provider.family<List<FileTransferState>, int>((
  ref,
  nodeNum,
) {
  final state = ref.watch(fileTransferStateProvider);
  return state.sortedTransfers
      .where((t) => t.targetNodeNum == nodeNum || t.sourceNodeNum == nodeNum)
      .toList();
});

/// Whether the user has enabled file transfer.
final fileTransferEnabledProvider = Provider<bool>((ref) {
  final settingsAsync = ref.watch(settingsServiceProvider);
  return settingsAsync.maybeWhen(
    data: (settings) => settings.fileTransferEnabled,
    orElse: () => true,
  );
});
