// SPDX-License-Identifier: GPL-3.0-or-later

/// Persistent identity store for SIP peers with TOFU and pinning.
///
/// Maintains a mapping from node IDs to identity claims (pubkeys),
/// supporting the identity state machine: UNVERIFIED -> VERIFIED_TOFU ->
/// PINNED / CHANGED_KEY / STALE.
library;

import 'dart:typed_data';

import '../../../core/logging.dart';
import 'sip_types.dart';

/// A stored identity record for a single SIP peer.
class SipIdentityRecord {
  /// Node ID this claim was last received from.
  final int nodeId;

  /// The 32-byte Ed25519 public key from the verified claim.
  final Uint8List pubkey;

  /// 16-byte persona_id derived from the pubkey.
  final Uint8List personaId;

  /// Display name from the claim.
  String displayName;

  /// Status string from the claim.
  String status;

  /// Device model from the claim.
  String deviceModel;

  /// Unix timestamp (seconds) when the claim was created.
  int createdAt;

  /// Claim TTL in seconds.
  int claimTtlS;

  /// Current identity verification state.
  SipIdentityState state;

  /// All node IDs that have presented this pubkey (for node migration).
  final Set<int> seenNodeIds;

  /// When this record was last updated locally.
  int lastUpdatedMs;

  SipIdentityRecord({
    required this.nodeId,
    required this.pubkey,
    required this.personaId,
    required this.displayName,
    required this.status,
    required this.deviceModel,
    required this.createdAt,
    required this.claimTtlS,
    required this.state,
    required this.seenNodeIds,
    int? lastUpdatedMs,
  }) : lastUpdatedMs = lastUpdatedMs ?? DateTime.now().millisecondsSinceEpoch;

  /// Whether this claim has expired relative to [nowS] (seconds since epoch).
  ///
  /// If [nowS] is not provided, uses `DateTime.now()`.
  bool isExpired([int? nowS]) {
    final now = nowS ?? (DateTime.now().millisecondsSinceEpoch ~/ 1000);
    return now > createdAt + claimTtlS;
  }

  /// The hex representation of the first 8 bytes of pubkey.
  String get pubkeyHint {
    if (pubkey.length < 8) return '';
    return pubkey
        .sublist(0, 8)
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join();
  }
}

/// In-memory identity store with TOFU, pinning, and CHANGED_KEY detection.
///
/// Persists records to an external callback so callers can choose their
/// own persistence layer (database, secure storage, etc.).
///
/// Two lookups:
/// - nodeId -> SipIdentityRecord (what identity does this node claim?)
/// - pubkey -> SipIdentityRecord (which nodes have used this pubkey?)
class SipIdentityStore {
  /// Creates an empty identity store with a maximum peer count.
  SipIdentityStore({this.maxPeers = 64, this.clock});

  /// Maximum number of peers to track. Oldest entries evicted when full.
  final int maxPeers;

  /// Injectable clock for testing (returns milliseconds since epoch).
  final int Function()? clock;

  /// Primary index: node_id -> identity record.
  final Map<int, SipIdentityRecord> _byNodeId = {};

  /// Secondary index: pubkey hex -> identity record.
  final Map<String, SipIdentityRecord> _byPubkeyHex = {};

  /// Rate limiter: node_id -> last claim timestamp (ms).
  final Map<int, int> _lastClaimTimeMs = {};

  int _nowMs() => clock?.call() ?? DateTime.now().millisecondsSinceEpoch;

  // ---------------------------------------------------------------------------
  // Query
  // ---------------------------------------------------------------------------

  /// Look up the identity record for a node ID.
  SipIdentityRecord? getByNodeId(int nodeId) => _byNodeId[nodeId];

  /// Look up the identity record by public key.
  SipIdentityRecord? getByPubkey(Uint8List pubkey) =>
      _byPubkeyHex[_bytesToHex(pubkey)];

  /// All stored identity records.
  Iterable<SipIdentityRecord> get allRecords => _byNodeId.values;

  /// Number of stored identities.
  int get peerCount => _byNodeId.length;

  // ---------------------------------------------------------------------------
  // Store / update
  // ---------------------------------------------------------------------------

  /// Process a verified identity claim. Returns the resulting state.
  ///
  /// Call this AFTER signature verification. The store handles TOFU,
  /// CHANGED_KEY detection, and node migration.
  ///
  /// Returns null if rate-limited.
  SipIdentityState? storeClaim({
    required int nodeId,
    required Uint8List pubkey,
    required Uint8List personaId,
    required String displayName,
    required String status,
    required String deviceModel,
    required int createdAt,
    required int claimTtlS,
  }) {
    // Rate limit: minimum 300s between claims from the same node.
    final nowMs = _nowMs();
    final lastMs = _lastClaimTimeMs[nodeId];
    if (lastMs != null && nowMs - lastMs < 300 * 1000) {
      AppLogging.sip(
        'SIP_ID_STORE: rate-limited claim from node=0x${nodeId.toRadixString(16)}, '
        'last=${(nowMs - lastMs) ~/ 1000}s ago',
      );
      return null;
    }

    _lastClaimTimeMs[nodeId] = nowMs;
    final pubkeyHex = _bytesToHex(pubkey);

    // Check for existing identity on this node.
    final existingByNode = _byNodeId[nodeId];
    if (existingByNode != null) {
      final existingHex = _bytesToHex(existingByNode.pubkey);
      if (existingHex == pubkeyHex) {
        // Same key: update claim fields.
        return _updateExisting(
          existingByNode,
          displayName: displayName,
          status: status,
          deviceModel: deviceModel,
          createdAt: createdAt,
          claimTtlS: claimTtlS,
          nowMs: nowMs,
        );
      } else {
        // Different key: CHANGED_KEY.
        return _handleChangedKey(
          nodeId: nodeId,
          oldRecord: existingByNode,
          pubkey: pubkey,
          personaId: personaId,
          displayName: displayName,
          status: status,
          deviceModel: deviceModel,
          createdAt: createdAt,
          claimTtlS: claimTtlS,
          nowMs: nowMs,
        );
      }
    }

    // Check if this pubkey is known from a different node (node migration).
    final existingByPubkey = _byPubkeyHex[pubkeyHex];
    if (existingByPubkey != null) {
      return _handleNodeMigration(
        existingByPubkey,
        newNodeId: nodeId,
        displayName: displayName,
        status: status,
        deviceModel: deviceModel,
        createdAt: createdAt,
        claimTtlS: claimTtlS,
        nowMs: nowMs,
      );
    }

    // New identity: TOFU.
    return _tofuAccept(
      nodeId: nodeId,
      pubkey: pubkey,
      personaId: personaId,
      displayName: displayName,
      status: status,
      deviceModel: deviceModel,
      createdAt: createdAt,
      claimTtlS: claimTtlS,
      nowMs: nowMs,
    );
  }

  // ---------------------------------------------------------------------------
  // Pinning
  // ---------------------------------------------------------------------------

  /// Pin the identity for a node ID. Only valid if VERIFIED_TOFU.
  bool pinIdentity(int nodeId) {
    final record = _byNodeId[nodeId];
    if (record == null) return false;
    if (record.state != SipIdentityState.verifiedTofu &&
        record.state != SipIdentityState.pinned) {
      return false;
    }
    record.state = SipIdentityState.pinned;
    record.lastUpdatedMs = _nowMs();
    AppLogging.sip(
      'SIP_ID_STORE: PINNED node=0x${nodeId.toRadixString(16)}, '
      'pubkey=${record.pubkeyHint}',
    );
    return true;
  }

  /// Unpin an identity, reverting to VERIFIED_TOFU.
  bool unpinIdentity(int nodeId) {
    final record = _byNodeId[nodeId];
    if (record == null || record.state != SipIdentityState.pinned) {
      return false;
    }
    record.state = SipIdentityState.verifiedTofu;
    record.lastUpdatedMs = _nowMs();
    AppLogging.sip('SIP_ID_STORE: UNPINNED node=0x${nodeId.toRadixString(16)}');
    return true;
  }

  // ---------------------------------------------------------------------------
  // Accept a changed key (user decision)
  // ---------------------------------------------------------------------------

  /// Accept a CHANGED_KEY identity (user confirms the new key is valid).
  ///
  /// Transitions from CHANGED_KEY to VERIFIED_TOFU.
  bool acceptChangedKey(int nodeId) {
    final record = _byNodeId[nodeId];
    if (record == null || record.state != SipIdentityState.changedKey) {
      return false;
    }
    record.state = SipIdentityState.verifiedTofu;
    record.lastUpdatedMs = _nowMs();
    AppLogging.sip(
      'SIP_ID_STORE: CHANGED_KEY accepted for node=0x${nodeId.toRadixString(16)}, '
      'new state=VERIFIED_TOFU',
    );
    return true;
  }

  // ---------------------------------------------------------------------------
  // Expiry / cleanup
  // ---------------------------------------------------------------------------

  /// Mark expired claims as STALE. Returns the number of records marked.
  int markStaleRecords() {
    final nowS = _nowMs() ~/ 1000;
    var count = 0;
    for (final record in _byNodeId.values) {
      if (record.isExpired(nowS) && record.state != SipIdentityState.stale) {
        record.state = SipIdentityState.stale;
        record.lastUpdatedMs = _nowMs();
        count++;
      }
    }
    if (count > 0) {
      AppLogging.sip('SIP_ID_STORE: marked $count record(s) as STALE');
    }
    return count;
  }

  /// Remove a specific record.
  void removeByNodeId(int nodeId) {
    final record = _byNodeId.remove(nodeId);
    if (record != null) {
      final hex = _bytesToHex(record.pubkey);
      // Only remove secondary index if no other node references this pubkey.
      final otherRefs = _byNodeId.values.where(
        (r) => _bytesToHex(r.pubkey) == hex,
      );
      if (otherRefs.isEmpty) {
        _byPubkeyHex.remove(hex);
      }
      _lastClaimTimeMs.remove(nodeId);
    }
  }

  /// Remove all records.
  void clear() {
    _byNodeId.clear();
    _byPubkeyHex.clear();
    _lastClaimTimeMs.clear();
  }

  // ---------------------------------------------------------------------------
  // Serialization for persistence
  // ---------------------------------------------------------------------------

  /// Export all records as a list of maps (for database persistence).
  List<Map<String, dynamic>> exportRecords() {
    return _byNodeId.values.map((r) {
      return {
        'node_id': r.nodeId,
        'pubkey': _bytesToHex(r.pubkey),
        'persona_id': _bytesToHex(r.personaId),
        'display_name': r.displayName,
        'status': r.status,
        'device_model': r.deviceModel,
        'created_at': r.createdAt,
        'claim_ttl_s': r.claimTtlS,
        'state': r.state.name,
        'seen_node_ids': r.seenNodeIds.toList(),
        'last_updated_ms': r.lastUpdatedMs,
      };
    }).toList();
  }

  /// Import records from a list of maps (from database persistence).
  void importRecords(List<Map<String, dynamic>> records) {
    for (final map in records) {
      final nodeId = map['node_id'] as int;
      final pubkey = _hexToBytes(map['pubkey'] as String);
      final personaId = _hexToBytes(map['persona_id'] as String);
      final state = SipIdentityState.values.firstWhere(
        (s) => s.name == map['state'],
        orElse: () => SipIdentityState.unverified,
      );
      final seenIds = (map['seen_node_ids'] as List)
          .map((e) => e as int)
          .toSet();

      final record = SipIdentityRecord(
        nodeId: nodeId,
        pubkey: pubkey,
        personaId: personaId,
        displayName: map['display_name'] as String? ?? '',
        status: map['status'] as String? ?? '',
        deviceModel: map['device_model'] as String? ?? '',
        createdAt: map['created_at'] as int,
        claimTtlS: map['claim_ttl_s'] as int,
        state: state,
        seenNodeIds: seenIds,
        lastUpdatedMs: map['last_updated_ms'] as int?,
      );

      _byNodeId[nodeId] = record;
      _byPubkeyHex[_bytesToHex(pubkey)] = record;
    }
  }

  // ---------------------------------------------------------------------------
  // Internal
  // ---------------------------------------------------------------------------

  SipIdentityState _tofuAccept({
    required int nodeId,
    required Uint8List pubkey,
    required Uint8List personaId,
    required String displayName,
    required String status,
    required String deviceModel,
    required int createdAt,
    required int claimTtlS,
    required int nowMs,
  }) {
    _evictIfFull();

    final record = SipIdentityRecord(
      nodeId: nodeId,
      pubkey: Uint8List.fromList(pubkey),
      personaId: Uint8List.fromList(personaId),
      displayName: displayName,
      status: status,
      deviceModel: deviceModel,
      createdAt: createdAt,
      claimTtlS: claimTtlS,
      state: SipIdentityState.verifiedTofu,
      seenNodeIds: {nodeId},
      lastUpdatedMs: nowMs,
    );

    _byNodeId[nodeId] = record;
    _byPubkeyHex[_bytesToHex(pubkey)] = record;

    AppLogging.sip(
      'SIP_ID_STORE: TOFU accepted: node=0x${nodeId.toRadixString(16)} '
      '-> pubkey=${record.pubkeyHint}',
    );
    AppLogging.sip('SIP_ID_STORE: identity_state=VERIFIED_TOFU');

    return SipIdentityState.verifiedTofu;
  }

  SipIdentityState _handleChangedKey({
    required int nodeId,
    required SipIdentityRecord oldRecord,
    required Uint8List pubkey,
    required Uint8List personaId,
    required String displayName,
    required String status,
    required String deviceModel,
    required int createdAt,
    required int claimTtlS,
    required int nowMs,
  }) {
    // Remove old pubkey secondary index.
    final oldHex = _bytesToHex(oldRecord.pubkey);
    final otherRefs = _byNodeId.values.where(
      (r) => r.nodeId != nodeId && _bytesToHex(r.pubkey) == oldHex,
    );
    if (otherRefs.isEmpty) {
      _byPubkeyHex.remove(oldHex);
    }

    // Create new record with CHANGED_KEY state.
    final record = SipIdentityRecord(
      nodeId: nodeId,
      pubkey: Uint8List.fromList(pubkey),
      personaId: Uint8List.fromList(personaId),
      displayName: displayName,
      status: status,
      deviceModel: deviceModel,
      createdAt: createdAt,
      claimTtlS: claimTtlS,
      state: SipIdentityState.changedKey,
      seenNodeIds: {...oldRecord.seenNodeIds, nodeId},
      lastUpdatedMs: nowMs,
    );

    _byNodeId[nodeId] = record;
    _byPubkeyHex[_bytesToHex(pubkey)] = record;

    AppLogging.sip(
      'SIP_ID_STORE: CHANGED_KEY: node=0x${nodeId.toRadixString(16)} '
      'old_pubkey=${oldRecord.pubkeyHint} -> new_pubkey=${record.pubkeyHint}',
    );

    return SipIdentityState.changedKey;
  }

  SipIdentityState _handleNodeMigration(
    SipIdentityRecord existing, {
    required int newNodeId,
    required String displayName,
    required String status,
    required String deviceModel,
    required int createdAt,
    required int claimTtlS,
    required int nowMs,
  }) {
    // Same pubkey, different node.
    existing.seenNodeIds.add(newNodeId);
    _byNodeId[newNodeId] = existing;

    _updateExisting(
      existing,
      displayName: displayName,
      status: status,
      deviceModel: deviceModel,
      createdAt: createdAt,
      claimTtlS: claimTtlS,
      nowMs: nowMs,
    );

    AppLogging.sip(
      'SIP_ID_STORE: node migration: pubkey=${existing.pubkeyHint} '
      'now also on node=0x${newNodeId.toRadixString(16)} '
      '(${existing.seenNodeIds.length} node(s) total)',
    );

    return existing.state;
  }

  SipIdentityState _updateExisting(
    SipIdentityRecord record, {
    required String displayName,
    required String status,
    required String deviceModel,
    required int createdAt,
    required int claimTtlS,
    required int nowMs,
  }) {
    record
      ..displayName = displayName
      ..status = status
      ..deviceModel = deviceModel
      ..createdAt = createdAt
      ..claimTtlS = claimTtlS
      ..lastUpdatedMs = nowMs;

    // If it was STALE and a fresh claim comes in, re-verify as TOFU.
    if (record.state == SipIdentityState.stale) {
      record.state = SipIdentityState.verifiedTofu;
      AppLogging.sip(
        'SIP_ID_STORE: STALE -> VERIFIED_TOFU for node=0x${record.nodeId.toRadixString(16)}',
      );
    }

    return record.state;
  }

  void _evictIfFull() {
    if (_byNodeId.length < maxPeers) return;

    // Evict oldest non-pinned record.
    SipIdentityRecord? oldest;
    for (final record in _byNodeId.values) {
      if (record.state == SipIdentityState.pinned) continue;
      if (oldest == null || record.lastUpdatedMs < oldest.lastUpdatedMs) {
        oldest = record;
      }
    }
    if (oldest != null) {
      AppLogging.sip(
        'SIP_ID_STORE: evicting node=0x${oldest.nodeId.toRadixString(16)} '
        '(oldest non-pinned)',
      );
      removeByNodeId(oldest.nodeId);
    }
  }

  static String _bytesToHex(Uint8List bytes) {
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }

  static Uint8List _hexToBytes(String hex) {
    final result = Uint8List(hex.length ~/ 2);
    for (var i = 0; i < result.length; i++) {
      result[i] = int.parse(hex.substring(i * 2, i * 2 + 2), radix: 16);
    }
    return result;
  }
}
