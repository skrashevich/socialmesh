// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:socialmesh/l10n/app_localizations.dart';

/// Incident lifecycle states.
///
/// 7 states forming the incident state machine.
/// [closed] and [cancelled] are terminal -- no further transitions allowed.
///
/// Spec: INCIDENT_LIFECYCLE.md (Sprint 007).
enum IncidentState {
  draft,
  open,
  assigned,
  escalated,
  resolved,
  closed,
  cancelled;

  /// Whether this state is terminal (no further transitions allowed).
  bool get isTerminal => this == closed || this == cancelled;

  /// Localised display label for this state.
  String displayLabel(AppLocalizations l10n) {
    return switch (this) {
      IncidentState.draft => l10n.incidentFilterStateDraft,
      IncidentState.open => l10n.incidentFilterStateOpen,
      IncidentState.assigned => l10n.incidentFilterStateAssigned,
      IncidentState.escalated => l10n.incidentFilterStateEscalated,
      IncidentState.resolved => l10n.incidentFilterStateResolved,
      IncidentState.closed => l10n.incidentFilterStateClosed,
      IncidentState.cancelled => l10n.incidentFilterStateCancelled,
    };
  }
}

/// Incident priority levels.
///
/// Ordered by urgency: routine (lowest) to flash (highest).
enum IncidentPriority {
  routine,
  priority,
  immediate,
  flash;

  /// Localised display label for this priority.
  String displayLabel(AppLocalizations l10n) {
    return switch (this) {
      IncidentPriority.routine => l10n.incidentPriorityRoutine,
      IncidentPriority.priority => l10n.incidentPriorityPriority,
      IncidentPriority.immediate => l10n.incidentPriorityImmediate,
      IncidentPriority.flash => l10n.incidentPriorityFlash,
    };
  }
}

/// Incident classification types.
enum IncidentClassification {
  safety,
  security,
  environmental,
  operational,
  logistics,
  medical,
  comms;

  /// Localised display label for this classification.
  String displayLabel(AppLocalizations l10n) {
    return switch (this) {
      IncidentClassification.safety => l10n.incidentClassificationSafety,
      IncidentClassification.security => l10n.incidentClassificationSecurity,
      IncidentClassification.environmental =>
        l10n.incidentClassificationEnvironmental,
      IncidentClassification.operational =>
        l10n.incidentClassificationOperational,
      IncidentClassification.logistics => l10n.incidentClassificationLogistics,
      IncidentClassification.medical => l10n.incidentClassificationMedical,
      IncidentClassification.comms => l10n.incidentClassificationComms,
    };
  }
}

/// An incident tracked by the incident lifecycle engine.
///
/// The [state] field is a projection derived from replaying
/// [IncidentTransition] records. It is stored for query convenience
/// but the transition log is the source of truth.
///
/// Spec: INCIDENT_LIFECYCLE.md (Sprint 007).
class Incident {
  final String id;
  final String orgId;
  final String title;
  final String? description;
  final IncidentState state;
  final IncidentPriority priority;
  final IncidentClassification classification;
  final String ownerId;
  final String? assigneeId;
  final double? locationLat;
  final double? locationLon;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? syncedAt;

  const Incident({
    required this.id,
    required this.orgId,
    required this.title,
    this.description,
    required this.state,
    required this.priority,
    required this.classification,
    required this.ownerId,
    this.assigneeId,
    this.locationLat,
    this.locationLon,
    required this.createdAt,
    required this.updatedAt,
    this.syncedAt,
  });

  /// Creates a copy with the given fields replaced.
  Incident copyWith({
    String? id,
    String? orgId,
    String? title,
    String? description,
    IncidentState? state,
    IncidentPriority? priority,
    IncidentClassification? classification,
    String? ownerId,
    String? assigneeId,
    double? locationLat,
    double? locationLon,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? syncedAt,
  }) {
    return Incident(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      title: title ?? this.title,
      description: description ?? this.description,
      state: state ?? this.state,
      priority: priority ?? this.priority,
      classification: classification ?? this.classification,
      ownerId: ownerId ?? this.ownerId,
      assigneeId: assigneeId ?? this.assigneeId,
      locationLat: locationLat ?? this.locationLat,
      locationLon: locationLon ?? this.locationLon,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncedAt: syncedAt ?? this.syncedAt,
    );
  }

  /// Deserialise from a SQLite row map.
  factory Incident.fromMap(Map<String, dynamic> map) {
    return Incident(
      id: map['id'] as String,
      orgId: map['orgId'] as String,
      title: map['title'] as String,
      description: map['description'] as String?,
      state: IncidentState.values.byName(map['state'] as String),
      priority: IncidentPriority.values.byName(map['priority'] as String),
      classification: IncidentClassification.values.byName(
        map['classification'] as String,
      ),
      ownerId: map['ownerId'] as String,
      assigneeId: map['assigneeId'] as String?,
      locationLat: map['locationLat'] as double?,
      locationLon: map['locationLon'] as double?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int),
      syncedAt: map['syncedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['syncedAt'] as int)
          : null,
    );
  }

  /// Serialise to a SQLite row map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orgId': orgId,
      'title': title,
      'description': description,
      'state': state.name,
      'priority': priority.name,
      'classification': classification.name,
      'ownerId': ownerId,
      'assigneeId': assigneeId,
      'locationLat': locationLat,
      'locationLon': locationLon,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
      'syncedAt': syncedAt?.millisecondsSinceEpoch,
    };
  }

  @override
  String toString() =>
      'Incident(id=$id, state=${state.name}, priority=${priority.name})';
}
