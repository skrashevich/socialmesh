// SPDX-License-Identifier: GPL-3.0-or-later
// SPDX-FileCopyrightText: 2025-2026 gotnull (developer@socialmesh.app)
import 'package:flutter_test/flutter_test.dart';
import 'package:socialmesh/core/los_analysis.dart';

void main() {
  group('evaluateLos', () {
    test('returns unknown when altA is null', () {
      final result = evaluateLos(altA: null, altB: 100, distanceMeters: 1000);
      expect(result.verdict, LosVerdict.unknown);
      expect(result.explanation, contains('Altitude data unavailable'));
    });

    test('returns unknown when altB is null', () {
      final result = evaluateLos(altA: 100, altB: null, distanceMeters: 1000);
      expect(result.verdict, LosVerdict.unknown);
    });

    test('returns unknown when both altitudes are null', () {
      final result = evaluateLos(altA: null, altB: null, distanceMeters: 1000);
      expect(result.verdict, LosVerdict.unknown);
    });

    test('short distance at high altitude is clear', () {
      // Two nodes at 500m altitude, 1km apart — trivially clear
      final result = evaluateLos(altA: 500, altB: 500, distanceMeters: 1000);
      expect(result.verdict, LosVerdict.clear);
      expect(result.earthBulgeMeters, greaterThan(0));
      expect(result.fresnelRadiusMeters, greaterThan(0));
      expect(result.actualClearanceMeters, greaterThan(0));
      expect(result.explanation, contains('Clear line of sight'));
    });

    test('very long distance at sea level is obstructed', () {
      // Two nodes at 2m altitude, 200km apart — earth curvature blocks
      final result = evaluateLos(altA: 2, altB: 2, distanceMeters: 200000);
      expect(result.verdict, LosVerdict.obstructed);
      expect(result.actualClearanceMeters, lessThan(0));
      expect(result.explanation, contains('obstructs'));
    });

    test('earth bulge formula is correct for known distance', () {
      // Earth bulge at midpoint for 10km path with 4/3 radius model:
      // h = d² / (8 × R_eff) = 10000² / (8 × 6371000 × 4/3)
      // = 1e8 / 67,957,333 ≈ 1.47m
      final result = evaluateLos(altA: 1000, altB: 1000, distanceMeters: 10000);
      expect(result.earthBulgeMeters, closeTo(1.47, 0.05));
    });

    test('fresnel radius is reasonable for 10km at 906MHz', () {
      // λ = 299792458 / 906e6 ≈ 0.331m
      // F1 = sqrt(λ × d/2 × d/2 / d) = sqrt(λ × d / 4)
      // = sqrt(0.331 × 10000 / 4) ≈ sqrt(827.5) ≈ 28.8m
      final result = evaluateLos(altA: 1000, altB: 1000, distanceMeters: 10000);
      expect(result.fresnelRadiusMeters, closeTo(28.8, 1.0));
    });

    test('required clearance is 60% of Fresnel radius', () {
      final result = evaluateLos(altA: 1000, altB: 1000, distanceMeters: 10000);
      expect(
        result.requiredClearanceMeters,
        closeTo(result.fresnelRadiusMeters * 0.6, 0.01),
      );
    });

    test('distanceMeters is preserved in result', () {
      final result = evaluateLos(altA: 100, altB: 200, distanceMeters: 5000);
      expect(result.distanceMeters, 5000);
    });

    test('asymmetric altitudes uses midline height correctly', () {
      // Node A at 0m, Node B at 1000m, 50km apart
      // Midline = 500m. Earth bulge at midpoint for 50km:
      // h = 50000² / (8 × 8494667) ≈ 36.8m
      // 500 - 36.8 = 463.2 clearance → should be clear
      final result = evaluateLos(altA: 0, altB: 1000, distanceMeters: 50000);
      expect(result.verdict, isNot(LosVerdict.obstructed));
      expect(result.actualClearanceMeters, greaterThan(0));
    });
  });

  group('calculateBearing', () {
    test('north bearing is approximately 0', () {
      // Point A to point B directly north
      final bearing = calculateBearing(0, 0, 1, 0);
      expect(bearing, closeTo(0, 0.1));
    });

    test('east bearing is approximately 90', () {
      final bearing = calculateBearing(0, 0, 0, 1);
      expect(bearing, closeTo(90, 0.1));
    });

    test('south bearing is approximately 180', () {
      final bearing = calculateBearing(1, 0, 0, 0);
      expect(bearing, closeTo(180, 0.1));
    });

    test('west bearing is approximately 270', () {
      final bearing = calculateBearing(0, 1, 0, 0);
      expect(bearing, closeTo(270, 0.1));
    });

    test('northeast bearing is approximately 45', () {
      // Small distances to avoid great-circle distortion
      final bearing = calculateBearing(0, 0, 0.01, 0.01);
      expect(bearing, closeTo(45, 1.0));
    });

    test('bearing is always in [0, 360)', () {
      final bearing = calculateBearing(10, 20, -10, -20);
      expect(bearing, greaterThanOrEqualTo(0));
      expect(bearing, lessThan(360));
    });

    test('same point returns 0', () {
      final bearing = calculateBearing(45.0, 13.0, 45.0, 13.0);
      expect(bearing, closeTo(0, 0.01));
    });
  });

  group('formatBearingCardinal', () {
    test('0 degrees is N', () {
      expect(formatBearingCardinal(0), 'N');
    });

    test('90 degrees is E', () {
      expect(formatBearingCardinal(90), 'E');
    });

    test('180 degrees is S', () {
      expect(formatBearingCardinal(180), 'S');
    });

    test('270 degrees is W', () {
      expect(formatBearingCardinal(270), 'W');
    });

    test('45 degrees is NE', () {
      expect(formatBearingCardinal(45), 'NE');
    });

    test('135 degrees is SE', () {
      expect(formatBearingCardinal(135), 'SE');
    });

    test('225 degrees is SW', () {
      expect(formatBearingCardinal(225), 'SW');
    });

    test('315 degrees is NW', () {
      expect(formatBearingCardinal(315), 'NW');
    });

    test('359 degrees is N', () {
      expect(formatBearingCardinal(359), 'N');
    });

    test('22 degrees is NNE', () {
      expect(formatBearingCardinal(22), 'NNE');
    });
  });

  group('LosVerdict.label', () {
    test('clear label', () {
      expect(LosVerdict.clear.label, 'Clear');
    });

    test('marginal label', () {
      expect(LosVerdict.marginal.label, 'Marginal');
    });

    test('obstructed label', () {
      expect(LosVerdict.obstructed.label, 'Obstructed');
    });

    test('unknown label', () {
      expect(LosVerdict.unknown.label, 'Unknown');
    });
  });
}
