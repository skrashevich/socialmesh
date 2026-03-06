// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/logging.dart';
import '../../../services/notifications/notification_service.dart';
import '../../device_shop/providers/admin_shop_providers.dart';

/// Watches the Firestore `bugReports` collection for new documents and fires
/// a local notification for each new bug report. Only active for admin users.
///
/// This provider is designed to be watched from the main shell so it stays
/// alive while the app is in the foreground. Non-admins get an inert stream
/// that never emits.
final adminBugReportWatcherProvider = StreamProvider<void>((ref) {
  final isAdmin = ref.watch(isShopAdminProvider);

  return isAdmin.when(
    data: (admin) {
      if (!admin) return const Stream<void>.empty();
      return _watchNewBugReports();
    },
    loading: () => const Stream<void>.empty(),
    error: (_, _) => const Stream<void>.empty(),
  );
});

/// Internal stream that listens to bugReports ordered by createdAt and
/// fires a notification for any report created after the listener started.
Stream<void> _watchNewBugReports() async* {
  final firestore = FirebaseFirestore.instance;
  final startTime = DateTime.now();
  final knownIds = <String>{};
  var isFirstSnapshot = true;

  AppLogging.bugReport('Admin bug report watcher started');

  await for (final snapshot
      in firestore
          .collection('bugReports')
          .orderBy('createdAt', descending: true)
          .limit(50)
          .snapshots()) {
    if (isFirstSnapshot) {
      // Seed known IDs from the initial snapshot to avoid notifying for
      // existing reports on app launch.
      for (final doc in snapshot.docs) {
        knownIds.add(doc.id);
      }
      isFirstSnapshot = false;
      AppLogging.bugReport(
        'Admin bug report watcher seeded ${knownIds.length} existing reports',
      );
      continue;
    }

    for (final change in snapshot.docChanges) {
      if (change.type != DocumentChangeType.added) continue;

      final doc = change.doc;
      if (knownIds.contains(doc.id)) continue;
      knownIds.add(doc.id);

      final data = doc.data();
      if (data == null) continue;

      // Only notify for reports created after the watcher started
      final createdAt = (data['createdAt'] as Timestamp?)?.toDate();
      if (createdAt == null || createdAt.isBefore(startTime)) continue;

      final description = data['description'] as String? ?? '';
      final email = data['email'] as String?;

      AppLogging.bugReport('Admin bug report watcher: new report ${doc.id}');

      await NotificationService().showNewBugReportNotification(
        reportId: doc.id,
        description: description,
        email: email,
      );
    }

    yield null;
  }
}
