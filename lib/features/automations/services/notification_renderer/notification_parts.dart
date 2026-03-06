// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)

/// Structured representation of a notification before it is sent.
///
/// Instead of building a monolithic string, the renderer produces
/// [NotificationParts] so that per-field policies can be applied
/// independently and the deep-link / data payload survives any text
/// reduction.
class NotificationParts {
  /// Primary headline (1-2 lines on both platforms).
  final String title;

  /// Main content text.
  final String body;

  /// Optional secondary line (iOS subtitle, Android sub-text).
  final String? subtitle;

  /// Optional deep-link or in-app route path.
  final String? deepLink;

  /// Arbitrary key-value metadata attached to the notification payload.
  final Map<String, String> data;

  const NotificationParts({
    required this.title,
    required this.body,
    this.subtitle,
    this.deepLink,
    this.data = const {},
  });

  NotificationParts copyWith({
    String? title,
    String? body,
    String? subtitle,
    String? deepLink,
    Map<String, String>? data,
  }) {
    return NotificationParts(
      title: title ?? this.title,
      body: body ?? this.body,
      subtitle: subtitle ?? this.subtitle,
      deepLink: deepLink ?? this.deepLink,
      data: data ?? this.data,
    );
  }

  @override
  String toString() =>
      'NotificationParts(title: "$title", body: "$body", '
      'subtitle: ${subtitle != null ? '"$subtitle"' : 'null'}, ' // lint-allow: hardcoded-string
      'deepLink: ${deepLink != null ? '"$deepLink"' : 'null'}, ' // lint-allow: hardcoded-string
      'data: $data)'; // lint-allow: hardcoded-string

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationParts &&
          title == other.title &&
          body == other.body &&
          subtitle == other.subtitle &&
          deepLink == other.deepLink &&
          _mapsEqual(data, other.data);

  @override
  int get hashCode => Object.hash(title, body, subtitle, deepLink, data.length);

  static bool _mapsEqual(Map<String, String> a, Map<String, String> b) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (a[key] != b[key]) return false;
    }
    return true;
  }
}
