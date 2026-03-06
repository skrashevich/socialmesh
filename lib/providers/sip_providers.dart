// SPDX-License-Identifier: GPL-3.0-or-later

/// Riverpod providers for SIP UI state.
///
/// Exposes SIP discovery, handshake, identity, and DM state to the
/// widget layer. All providers are gated behind [SmFeatureFlag.sipEnabled].
library;

import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants.dart';
import '../services/protocol/sip/sip_counters.dart';
import '../services/protocol/sip/sip_discovery.dart';
import '../services/protocol/sip/sip_dm.dart';
import '../services/protocol/sip/sip_handshake.dart';
import '../services/protocol/sip/sip_identity.dart';
import '../services/protocol/sip/sip_identity_store.dart';
import '../services/protocol/sip/sip_keypair.dart';
import '../services/protocol/sip/sip_rate_limiter.dart';
import '../services/protocol/sip/sip_replay_cache.dart';
import '../services/protocol/sip/sip_types.dart';
import 'app_providers.dart';
import 'sip_nodedex_bridge.dart';

/// Whether SIP is enabled (sourced from SmFeatureFlag).
///
/// Override this in tests or from the protocol service's feature flag.
/// Default: false.
final sipEnabledProvider = NotifierProvider<SipEnabledNotifier, bool>(
  SipEnabledNotifier.new,
);

/// Notifier controlling SIP enabled state.
class SipEnabledNotifier extends Notifier<bool> {
  @override
  bool build() => AppFeatureFlags.isSipEnabled;

  /// Set the SIP enabled state.
  void setEnabled(bool value) => state = value;
}

/// Shared SIP rate limiter instance.
final sipRateLimiterProvider = Provider<SipRateLimiter>((ref) {
  return SipRateLimiter();
});

/// Shared SIP replay cache instance.
final sipReplayCacheProvider = Provider<SipReplayCache>((ref) {
  return SipReplayCache();
});

/// SIP counters (in-memory, reset on restart).
final sipCountersProvider = Provider<SipCounters>((ref) {
  return SipCounters();
});

/// SIP identity store (in-memory TOFU/pin/CHANGED_KEY).
final sipIdentityStoreProvider = Provider<SipIdentityStore>((ref) {
  return SipIdentityStore();
});

/// SIP keypair — async initialization.
///
/// The keypair is loaded (or generated) on first access, then cached.
/// This provider is [FutureProvider] because keypair init hits secure storage.
final sipKeypairProvider = FutureProvider<SipKeypair?>((ref) async {
  final enabled = ref.watch(sipEnabledProvider);
  if (!enabled) return null;

  final keypair = SipKeypair();
  await keypair.ensureInitialized();
  return keypair;
});

/// Bumped whenever the SIP peer cache changes so downstream providers
/// (peer list, peer count) rebuild. This breaks the top-level cycle that
/// would otherwise occur if sipDiscoveryProvider directly invalidated
/// sipDiscoveredPeersProvider.
final sipPeerCacheEpochProvider = NotifierProvider<_SipPeerCacheEpoch, int>(
  _SipPeerCacheEpoch.new,
);

class _SipPeerCacheEpoch extends Notifier<int> {
  @override
  int build() => 0;

  void bump() => state++;
}

/// Bumped whenever DM session state changes (new session, new message, etc.)
final sipDmEpochProvider = NotifierProvider<_SipDmEpoch, int>(_SipDmEpoch.new);

class _SipDmEpoch extends Notifier<int> {
  @override
  int build() => 0;

  void bump() => state++;
}

/// SIP discovery engine.
///
/// Uses the connected device's node number so we can ignore our own
/// broadcasts. Attaches to [ProtocolService] so inbound SIP packets
/// are routed to the discovery engine.
final sipDiscoveryProvider = Provider<SipDiscovery?>((ref) {
  final enabled = ref.watch(sipEnabledProvider);
  if (!enabled) return null;

  final nodeNum = ref.watch(myNodeNumProvider) ?? 0;
  final limiter = ref.watch(sipRateLimiterProvider);

  final discovery = SipDiscovery(
    rateLimiter: limiter,
    localNodeId: nodeNum,
    counters: ref.read(sipCountersProvider),
  );

  // Invalidate peer/count providers when the cache changes so the UI rebuilds.
  discovery.onPeersChanged = () {
    ref.read(sipPeerCacheEpochProvider.notifier).bump();
  };

  // Bridge discovered peers into NodeDex as SIP-capable.
  discovery.onPeerDiscovered = (nodeId) {
    sipBridgeMarkCapableFromRef(ref, nodeId);
  };

  // Attach to the protocol service so inbound SIP frames are dispatched.
  final protocol = ref.read(protocolServiceProvider);
  protocol.attachSipDiscovery(discovery);

  // Also attach counters to the protocol service.
  final counters = ref.read(sipCountersProvider);
  protocol.attachSipCounters(counters);

  // Detach when this provider is disposed (SIP disabled or page torn down).
  ref.onDispose(() {
    discovery.onPeersChanged = null;
    discovery.onPeerDiscovered = null;
    protocol.attachSipDiscovery(null);
    protocol.attachSipCounters(null);
  });

  return discovery;
});

/// SIP handshake manager — attached to protocol service for dispatch.
final sipHandshakeProvider = Provider<SipHandshakeManager?>((ref) {
  final enabled = ref.watch(sipEnabledProvider);
  if (!enabled) return null;

  final replayCache = ref.watch(sipReplayCacheProvider);
  final counters = ref.watch(sipCountersProvider);
  final nodeNum = ref.watch(myNodeNumProvider) ?? 0;
  final manager = SipHandshakeManager(
    replayCache: replayCache,
    localNodeId: nodeNum,
    counters: counters,
  );

  final protocol = ref.read(protocolServiceProvider);
  protocol.attachSipHandshake(manager);

  ref.onDispose(() {
    protocol.attachSipHandshake(null);
  });

  return manager;
});

/// SIP identity handler — attached to protocol service for dispatch.
final sipIdentityHandlerProvider = Provider<SipIdentityHandler?>((ref) {
  final enabled = ref.watch(sipEnabledProvider);
  if (!enabled) return null;

  final keypairAsync = ref.watch(sipKeypairProvider);
  final keypair = keypairAsync.asData?.value;
  if (keypair == null) return null;

  final store = ref.watch(sipIdentityStoreProvider);
  final nodeNum = ref.watch(myNodeNumProvider) ?? 0;

  final handler = SipIdentityHandler(
    keypair: keypair,
    store: store,
    localNodeId: nodeNum,
  );

  final protocol = ref.read(protocolServiceProvider);
  protocol.attachSipIdentity(handler);

  // Bridge verified identity claims into NodeDex.
  protocol.onSipIdentityVerified =
      ({
        required int nodeId,
        required Uint8List pubkey,
        required Uint8List personaId,
        required SipIdentityState identityState,
        String? displayName,
      }) {
        sipBridgeApplyIdentity(
          ref: ref,
          nodeId: nodeId,
          pubkey: pubkey,
          personaId: personaId,
          identityState: identityState,
          displayName: displayName,
        );
      };

  ref.onDispose(() {
    protocol.onSipIdentityVerified = null;
    protocol.attachSipIdentity(null);
  });

  return handler;
});

/// SIP DM manager — attached to protocol service for dispatch.
final sipDmManagerProvider = Provider<SipDmManager?>((ref) {
  final enabled = ref.watch(sipEnabledProvider);
  if (!enabled) return null;

  final limiter = ref.watch(sipRateLimiterProvider);
  final counters = ref.watch(sipCountersProvider);
  final manager = SipDmManager(rateLimiter: limiter, counters: counters);

  final protocol = ref.read(protocolServiceProvider);
  protocol.attachSipDm(manager);

  ref.onDispose(() {
    protocol.attachSipDm(null);
  });

  return manager;
});

/// Number of discovered SIP peers (for UI badge).
final sipPeerCountProvider = Provider<int>((ref) {
  ref.watch(sipPeerCacheEpochProvider); // rebuild on cache changes
  final discovery = ref.watch(sipDiscoveryProvider);
  return discovery?.peerCount ?? 0;
});

/// All discovered SIP peers.
final sipDiscoveredPeersProvider = Provider<List<SipPeerCapability>>((ref) {
  ref.watch(sipPeerCacheEpochProvider); // rebuild on cache changes
  final discovery = ref.watch(sipDiscoveryProvider);
  if (discovery == null) return [];
  return discovery.discoveredPeers.toList();
});

/// Active DM sessions.
final sipActiveSessionsProvider = Provider<List<SipDmSession>>((ref) {
  ref.watch(sipDmEpochProvider); // rebuild on DM state changes
  final dm = ref.watch(sipDmManagerProvider);
  return dm?.activeSessions ?? [];
});

/// Handshake state for a specific peer (by node ID).
final sipHandshakeStateProvider = Provider.family<SipHandshakeState, int>((
  ref,
  nodeId,
) {
  final hs = ref.watch(sipHandshakeProvider);
  return hs?.getState(nodeId) ?? SipHandshakeState.idle;
});
