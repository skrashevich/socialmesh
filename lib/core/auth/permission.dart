// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)

/// The 17 gated enterprise actions.
///
/// Each action maps to one row of the RBAC permission matrix.
///
/// Spec: RBAC.md (Sprint 007/W2.2).
enum Permission {
  // Incidents
  createIncident,
  submitIncident,
  assignIncident,
  escalateIncident,
  resolveIncident, // Conditional for Operator (own assigned only)
  closeIncident,
  cancelIncident,

  // Field Reports
  createFieldReport,

  // Tasks
  createTask,
  assignTask,
  completeTask, // Conditional for Operator (own assigned only)
  // Viewing
  viewTeamIncidents,
  viewTeamTasks,

  // Reporting
  exportReports,

  // Admin
  manageUsers,
  manageDevices,
  configureOrgSettings,
}
