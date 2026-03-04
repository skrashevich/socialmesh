// SPDX-License-Identifier: GPL-3.0-or-later

import '../../l10n/app_localizations.dart';

/// Resolves a flow node port/node title to its localized version.
///
/// Node definitions use `const` constructors, so titles are hardcoded English
/// strings at compile time. Call this function at display time to map each
/// English title to its localized equivalent.
///
/// Falls back to the original English [title] when no localization exists.
String localizedFlowTitle(String title, AppLocalizations l10n) {
  return switch (title) {
    // Trigger nodes
    'Event' => l10n.flowNodeEvent,
    'Message Contains' => l10n.flowNodeMessageContains,
    'Node Silent' => l10n.flowNodeNodeSilent,
    'Scheduled' => l10n.flowNodeScheduled,
    'Signal Weak' => l10n.flowNodeSignalWeak,
    'Channel Activity' => l10n.flowNodeChannelActivity,
    'Detection Sensor' => l10n.flowNodeDetectionSensor,
    'Manual' => l10n.flowNodeManual,
    // NodeDex query nodes
    'All Nodes' => l10n.flowNodeAllNodes,
    'Nodes' => l10n.flowNodeNodes,
    'Trait Filter' => l10n.flowNodeTraitFilter,
    'Distance Filter' => l10n.flowNodeDistanceFilter,
    'Encounter Filter' => l10n.flowNodeEncounterFilter,
    'Online Filter' => l10n.flowNodeOnlineFilter,
    'Battery Filter' => l10n.flowNodeBatteryFilter,
    'Name Filter' => l10n.flowNodeNameFilter,
    'Sort' => l10n.flowNodeSort,
    'Limit' => l10n.flowNodeLimit,
    'Input' => l10n.flowNodeInput,
    'Filtered' => l10n.flowNodeFiltered,
    'Sorted' => l10n.flowNodeSorted,
    'Limited' => l10n.flowNodeLimited,
    // Action nodes
    'Execute' => l10n.flowNodeExecute,
    // Logic gate nodes
    'AND' => l10n.flowNodeAnd,
    'OR' => l10n.flowNodeOr,
    'NOT' => l10n.flowNodeNot,
    'Delay' => l10n.flowNodeDelay,
    'All Met' => l10n.flowNodeAllMet,
    'Any Met' => l10n.flowNodeAnyMet,
    'Inverted' => l10n.flowNodeInverted,
    'Delayed' => l10n.flowNodeDelayed,
    _ => title,
  };
}
