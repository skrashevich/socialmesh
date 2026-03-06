// SPDX-License-Identifier: GPL-3.0-or-later

/// Riverpod providers for SIP UI state.
///
/// Exposes SIP discovery, handshake, identity, and DM state to the
/// widget layer. All providers are gated behind [SmFeatureFlag.sipEnabled].
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/constants.dart';
import '../services/protocol/sip/sip_counters.dart';
import '../services/protocol/sip/sip_discovery.dart';
import '../services/protocol/sip/sip_dm.dart';
import '../services/protocol/sip/sip_handshake.dart';
import '../services/protocol/sip/sip_rate_limiter.dart';
import '../services/protocol/sip/sip_replay_cache.dart';
import 'app_providers.dart';

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

  final discovery = SipDiscovery(rateLimiter: limiter, localNodeId: nodeNum);

  // Invalidate peer/count providers when the cache changes so the UI rebuilds.
  discovery.onPeersChanged = () {
    ref.read(sipPeerCacheEpochProvider.notifier).bump();
  };

  // Attach to the protocol service so inbound SIP frames are dispatched.
  final protocol = ref.read(protocolServiceProvider);
  protocol.attachSipDiscovery(discovery);

  // Detach when this provider is disposed (SIP disabled or page torn down).
  ref.onDispose(() {
    discovery.onPeersChanged = null;
    protocol.attachSipDiscovery(null);
  });

  return discovery;
});

/// SIP handshake manager.
final sipHandshakeProvider = Provider<SipHandshakeManager?>((ref) {
  final enabled = ref.watch(sipEnabledProvider);
  if (!enabled) return null;

  final replayCache = ref.watch(sipReplayCacheProvider);
  return SipHandshakeManager(replayCache: replayCache);
});

/// SIP DM manager.
final sipDmManagerProvider = Provider<SipDmManager?>((ref) {
  final enabled = ref.watch(sipEnabledProvider);
  if (!enabled) return null;

  final limiter = ref.watch(sipRateLimiterProvider);
  return SipDmManager(rateLimiter: limiter);
});

/// SIP counters.
final sipCountersProvider = Provider<SipCounters>((ref) {
  return SipCounters();
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
