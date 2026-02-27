// SPDX-License-Identifier: GPL-3.0-or-later
import 'dart:math' as math;

/// Result of a Line-of-Sight analysis between two geographic points.
///
/// Uses earth curvature + Fresnel zone clearance to estimate whether
/// a direct RF path exists. This is a geometric approximation that does
/// NOT account for terrain, buildings, or vegetation obstructions.
/// It only checks whether the earth's curvature itself would block the
/// signal path and whether the first Fresnel zone has adequate clearance.
///
/// Accuracy: Good for flat/ocean paths. Optimistic for hilly or urban
/// terrain because ground obstacles are not modelled. A "Clear" result
/// means the geometry is favorable but does NOT guarantee actual RF
/// connectivity.
class LosResult {
  /// Overall verdict.
  final LosVerdict verdict;

  /// Earth curvature obstruction height at the midpoint of the path (meters).
  /// Positive means the earth bulges into the path.
  final double earthBulgeMeters;

  /// First Fresnel zone radius at the midpoint (meters) for 906 MHz.
  final double fresnelRadiusMeters;

  /// Required clearance (0.6 × F1) at midpoint (meters).
  final double requiredClearanceMeters;

  /// Actual clearance above earth bulge at midpoint (meters).
  /// Negative means the path is obstructed by earth curvature.
  final double actualClearanceMeters;

  /// Great-circle distance between the two points (meters).
  final double distanceMeters;

  /// A short human-readable explanation of the result.
  final String explanation;

  const LosResult({
    required this.verdict,
    required this.earthBulgeMeters,
    required this.fresnelRadiusMeters,
    required this.requiredClearanceMeters,
    required this.actualClearanceMeters,
    required this.distanceMeters,
    required this.explanation,
  });
}

/// LOS analysis verdict.
enum LosVerdict {
  /// Clearance exceeds 60% of the first Fresnel zone — strong path.
  clear,

  /// Some clearance exists but less than 60% Fresnel — marginal path.
  marginal,

  /// Earth curvature alone obstructs the direct path.
  obstructed,

  /// Cannot compute (missing altitude data).
  unknown;

  String get label {
    switch (this) {
      case LosVerdict.clear:
        return 'Clear';
      case LosVerdict.marginal:
        return 'Marginal';
      case LosVerdict.obstructed:
        return 'Obstructed';
      case LosVerdict.unknown:
        return 'Unknown';
    }
  }
}

/// Evaluate line-of-sight between two geographic points.
///
/// Parameters:
///   [altA] / [altB] — altitude in meters above mean sea level.
///   [distanceMeters] — great-circle distance between the two points.
///   [frequencyMhz] — operating frequency (default 906 MHz for LoRa US).
///
/// Uses the standard 4/3 earth radius model for atmospheric refraction.
///
/// Returns [LosResult] with [LosVerdict.unknown] if either altitude is null.
LosResult evaluateLos({
  required int? altA,
  required int? altB,
  required double distanceMeters,
  double frequencyMhz = 906.0,
}) {
  if (altA == null || altB == null) {
    return const LosResult(
      verdict: LosVerdict.unknown,
      earthBulgeMeters: 0,
      fresnelRadiusMeters: 0,
      requiredClearanceMeters: 0,
      actualClearanceMeters: 0,
      distanceMeters: 0,
      explanation: 'Altitude data unavailable for one or both points.',
    );
  }

  // Effective earth radius with 4/3 refraction model
  const double earthRadius = 6371000.0; // meters
  const double kFactor = 4.0 / 3.0;
  final double effectiveRadius = earthRadius * kFactor;

  final double d = distanceMeters;

  // Earth bulge at midpoint: h = d² / (8 × R_eff)
  // where d is the total path distance
  final double earthBulge = (d * d) / (8.0 * effectiveRadius);

  // First Fresnel zone radius at midpoint:
  // F1 = sqrt(λ × d1 × d2 / d) where d1 = d2 = d/2 at midpoint
  // λ = c / f
  final double wavelength = 299792458.0 / (frequencyMhz * 1e6);
  final double d1 = d / 2.0;
  final double d2 = d / 2.0;
  final double fresnelRadius = math.sqrt(wavelength * d1 * d2 / d);

  // Required clearance: 60% of first Fresnel zone
  final double requiredClearance = 0.6 * fresnelRadius;

  // Line-of-sight height at midpoint (interpolated between altA and altB)
  final double midLineHeight = (altA + altB) / 2.0;

  // Actual clearance = midline height - earth bulge
  final double actualClearance = midLineHeight - earthBulge;

  // Determine verdict
  LosVerdict verdict;
  String explanation;

  if (actualClearance < 0) {
    verdict = LosVerdict.obstructed;
    explanation =
        'Earth curvature obstructs the path by '
        '${(-actualClearance).toStringAsFixed(0)}m at midpoint. '
        'Terrain/obstacles not considered.';
  } else if (actualClearance >= requiredClearance + earthBulge) {
    verdict = LosVerdict.clear;
    explanation =
        'Clear line of sight with ${actualClearance.toStringAsFixed(0)}m '
        'clearance above earth bulge. '
        'Terrain/obstacles not considered.';
  } else {
    verdict = LosVerdict.marginal;
    explanation =
        'Marginal clearance (${actualClearance.toStringAsFixed(0)}m) — '
        'below the recommended '
        '${requiredClearance.toStringAsFixed(0)}m Fresnel clearance. '
        'Terrain/obstacles not considered.';
  }

  return LosResult(
    verdict: verdict,
    earthBulgeMeters: earthBulge,
    fresnelRadiusMeters: fresnelRadius,
    requiredClearanceMeters: requiredClearance,
    actualClearanceMeters: actualClearance,
    distanceMeters: d,
    explanation: explanation,
  );
}

/// Calculate bearing (initial heading) from point A to point B in degrees.
///
/// Returns a value in the range [0, 360).
double calculateBearing(
  double lat1Deg,
  double lon1Deg,
  double lat2Deg,
  double lon2Deg,
) {
  final lat1 = lat1Deg * math.pi / 180;
  final lat2 = lat2Deg * math.pi / 180;
  final dLon = (lon2Deg - lon1Deg) * math.pi / 180;

  final y = math.sin(dLon) * math.cos(lat2);
  final x =
      math.cos(lat1) * math.sin(lat2) -
      math.sin(lat1) * math.cos(lat2) * math.cos(dLon);

  final bearing = math.atan2(y, x) * 180 / math.pi;
  return (bearing + 360) % 360;
}

/// Format a bearing in degrees to a cardinal direction string.
///
/// E.g. 0° → "N", 45° → "NE", 180° → "S", 270° → "W".
String formatBearingCardinal(double degrees) {
  const directions = [
    'N',
    'NNE',
    'NE',
    'ENE',
    'E',
    'ESE',
    'SE',
    'SSE',
    'S',
    'SSW',
    'SW',
    'WSW',
    'W',
    'WNW',
    'NW',
    'NNW',
  ];
  final index = ((degrees + 11.25) / 22.5).floor() % 16;
  return directions[index];
}
