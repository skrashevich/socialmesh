// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/l10n/l10n_extension.dart';
import '../../../core/theme.dart';
import '../../../services/haptic_service.dart';
import '../models/incident.dart';
import '../providers/incident_providers.dart';

/// Horizontal filter bar for incident list.
///
/// Renders FilterChip groups for state and priority, plus an
/// "Assigned to me" toggle. Emits updates via [IncidentFilterNotifier].
///
/// Spec: Sprint 008/W3.3.
class IncidentFilterBar extends ConsumerWidget {
  const IncidentFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(incidentFilterProvider);
    final notifier = ref.read(incidentFilterProvider.notifier);
    final l10n = context.l10n;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // -- State filter chips --
          ...IncidentState.values.map((state) {
            final isSelected = filter.states.contains(state);
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(state.displayLabel(l10n)),
                selected: isSelected,
                onSelected: (selected) {
                  ref.haptics.toggle();
                  final updated = Set<IncidentState>.from(filter.states);
                  if (selected) {
                    updated.add(state);
                  } else {
                    updated.remove(state);
                  }
                  notifier.setStates(updated);
                },
                labelStyle: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : context.textSecondary,
                ),
                selectedColor: _stateColor(state),
                backgroundColor: context.card,
                side: BorderSide(color: context.border),
                showCheckmark: false,
                visualDensity: VisualDensity.compact,
              ),
            );
          }),

          Container(
            width: 1,
            height: 24,
            color: context.border,
            margin: const EdgeInsets.symmetric(horizontal: 4),
          ),

          // -- Priority filter chips --
          ...IncidentPriority.values.map((priority) {
            final isSelected = filter.priorities.contains(priority);
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(priority.displayLabel(l10n)),
                selected: isSelected,
                onSelected: (selected) {
                  ref.haptics.toggle();
                  final updated = Set<IncidentPriority>.from(filter.priorities);
                  if (selected) {
                    updated.add(priority);
                  } else {
                    updated.remove(priority);
                  }
                  notifier.setPriorities(updated);
                },
                labelStyle: TextStyle(
                  fontSize: 12,
                  color: isSelected ? Colors.white : context.textSecondary,
                ),
                selectedColor: _priorityColor(priority),
                backgroundColor: context.card,
                side: BorderSide(color: context.border),
                showCheckmark: false,
                visualDensity: VisualDensity.compact,
              ),
            );
          }),

          Container(
            width: 1,
            height: 24,
            color: context.border,
            margin: const EdgeInsets.symmetric(horizontal: 4),
          ),

          // -- Assigned to me toggle --
          FilterChip(
            label: Text(l10n.incidentFilterAssignedToMe),
            selected: filter.assignedToMe,
            onSelected: (_) {
              ref.haptics.toggle();
              notifier.toggleAssignedToMe();
            },
            labelStyle: TextStyle(
              fontSize: 12,
              color: filter.assignedToMe ? Colors.white : context.textSecondary,
            ),
            selectedColor: Theme.of(context).colorScheme.primary,
            backgroundColor: context.card,
            side: BorderSide(color: context.border),
            showCheckmark: false,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }

  static Color _stateColor(IncidentState state) {
    return switch (state) {
      IncidentState.draft => SemanticColors.disabled,
      IncidentState.open => AccentColors.blue,
      IncidentState.assigned => AccentColors.orange,
      IncidentState.escalated => AppTheme.errorRed,
      IncidentState.resolved => AppTheme.successGreen,
      IncidentState.closed => AccentColors.slate,
      IncidentState.cancelled => AccentColors.slate,
    };
  }

  static Color _priorityColor(IncidentPriority priority) {
    return switch (priority) {
      IncidentPriority.routine => AccentColors.teal,
      IncidentPriority.priority => AppTheme.warningYellow,
      IncidentPriority.immediate => AccentColors.coral,
      IncidentPriority.flash => AppTheme.errorRed,
    };
  }
}
