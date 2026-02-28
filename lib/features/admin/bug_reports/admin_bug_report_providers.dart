// SPDX-License-Identifier: GPL-3.0-or-later

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/logging.dart';
import '../../../features/feedback/bug_report_repository.dart';

/// Admin-scoped bug report with extra fields visible to admins.
class AdminBugReport {
  final String id;
  final String description;
  final String? screenshotUrl;
  final String? uid;
  final String? email;
  final String? appVersion;
  final String? buildNumber;
  final String? platform;
  final String? platformVersion;
  final String? deviceModel;
  final String? osVersion;
  final BugReportStatus status;
  final DateTime createdAt;
  final DateTime? lastResponseAt;
  final List<BugReportResponse> responses;
  final bool hasUnreadUserReplies;
  final int unreadUserReplyCount;

  const AdminBugReport({
    required this.id,
    required this.description,
    this.screenshotUrl,
    this.uid,
    this.email,
    this.appVersion,
    this.buildNumber,
    this.platform,
    this.platformVersion,
    this.deviceModel,
    this.osVersion,
    this.status = BugReportStatus.open,
    required this.createdAt,
    this.lastResponseAt,
    this.responses = const [],
    this.hasUnreadUserReplies = false,
    this.unreadUserReplyCount = 0,
  });

  bool get isAnonymous => uid == null || uid!.isEmpty;

  factory AdminBugReport.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc, {
    List<BugReportResponse> responses = const [],
    List<bool> readByAdminFlags = const [],
  }) {
    final data = doc.data()!;

    // Count unread user replies
    int unreadCount = 0;
    for (int i = 0; i < responses.length; i++) {
      if (responses[i].isFromUser) {
        final isRead = i < readByAdminFlags.length ? readByAdminFlags[i] : true;
        if (!isRead) unreadCount++;
      }
    }

    return AdminBugReport(
      id: doc.id,
      description: data['description'] as String? ?? '',
      screenshotUrl: data['screenshotUrl'] as String?,
      uid: data['uid'] as String?,
      email: data['email'] as String?,
      appVersion: data['appVersion'] as String?,
      buildNumber: data['buildNumber'] as String?,
      platform: data['platform'] as String?,
      platformVersion: data['platformVersion'] as String?,
      deviceModel: data['deviceModel'] as String?,
      osVersion: data['osVersion'] as String?,
      status: BugReportStatus.fromString(data['status'] as String?),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      lastResponseAt: (data['lastResponseAt'] as Timestamp?)?.toDate(),
      responses: responses,
      hasUnreadUserReplies: unreadCount > 0,
      unreadUserReplyCount: unreadCount,
    );
  }
}

/// Repository for admin-scoped bug report operations.
class AdminBugReportRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Stream all bug reports (admin view) ordered by most recent.
  Stream<List<AdminBugReport>> watchAllReports() {
    return _firestore
        .collection('bugReports')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
          final reports = <AdminBugReport>[];

          for (final doc in snapshot.docs) {
            final responsesSnapshot = await doc.reference
                .collection('responses')
                .orderBy('createdAt', descending: false)
                .get();

            final responses = responsesSnapshot.docs
                .map(BugReportResponse.fromFirestore)
                .toList();

            final readByAdminFlags = responsesSnapshot.docs.map((d) {
              return d.data()['readByAdmin'] as bool? ?? false;
            }).toList();

            reports.add(
              AdminBugReport.fromFirestore(
                doc,
                responses: responses,
                readByAdminFlags: readByAdminFlags,
              ),
            );
          }

          AppLogging.bugReport('Admin: streamed ${reports.length} bug reports');
          return reports;
        })
        .handleError((Object e) {
          AppLogging.bugReport('Admin bug reports stream error: $e');
        });
  }

  /// Send an admin response to a bug report via Cloud Function.
  Future<void> respondToReport({
    required String reportId,
    required String message,
  }) async {
    final callable = FirebaseFunctions.instance.httpsCallable(
      'respondToBugReport',
    );
    await callable.call<dynamic>({'reportId': reportId, 'message': message});
    AppLogging.bugReport('Admin: responded to report $reportId');
  }

  /// Update a report's status directly.
  Future<void> updateReportStatus({
    required String reportId,
    required String status,
  }) async {
    await _firestore.collection('bugReports').doc(reportId).update({
      'status': status,
      'lastResponseAt': FieldValue.serverTimestamp(),
    });
    AppLogging.bugReport('Admin: updated report $reportId status to $status');
  }

  /// Mark all user responses on a report as read by admin.
  Future<void> markUserResponsesAsRead(String reportId) async {
    final responsesSnapshot = await _firestore
        .collection('bugReports')
        .doc(reportId)
        .collection('responses')
        .where('from', isEqualTo: 'user')
        .where('readByAdmin', isEqualTo: false)
        .get();

    if (responsesSnapshot.docs.isEmpty) return;

    final batch = _firestore.batch();
    for (final doc in responsesSnapshot.docs) {
      batch.update(doc.reference, {'readByAdmin': true});
    }
    await batch.commit();

    AppLogging.bugReport(
      'Admin: marked ${responsesSnapshot.docs.length} responses as read '
      'on report $reportId',
    );
  }
}

/// Provider for the admin bug report repository.
final adminBugReportRepositoryProvider = Provider<AdminBugReportRepository>((
  ref,
) {
  return AdminBugReportRepository();
});

/// Provider streaming all bug reports for admin view.
final adminBugReportsProvider = StreamProvider<List<AdminBugReport>>((ref) {
  final repository = ref.watch(adminBugReportRepositoryProvider);
  return repository.watchAllReports();
});

/// Provider for open bug report count (for badge on admin screen).
final adminOpenBugReportCountProvider = Provider<int>((ref) {
  final reports = ref.watch(adminBugReportsProvider);
  return reports.when(
    data: (list) => list.where((r) => r.status == BugReportStatus.open).length,
    loading: () => 0,
    error: (_, _) => 0,
  );
});
