import 'dart:math' as math;

import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

/// {@template ellipse_shape}
/// Creates an ellipse.
/// {@endtemplate}
class EllipseShape extends ChainShape {
  /// {@macro ellipse_shape}
  EllipseShape({
    required this.center,
    required this.majorRadius,
    required this.minorRadius,
  }) {
    createChain(
      calculateEllipse(
        center: center,
        majorRadius: majorRadius,
        minorRadius: minorRadius,
      ),
    );
  }

  /// The top left corner of the ellipse.
  ///
  /// Where the initial painting begins.
  final Vector2 center;

  /// Major radius is specified by [majorRadius].
  final double majorRadius;

  /// Minor radius is specified by [minorRadius].
  final double minorRadius;

  /// Rotates the ellipse by a given [angle] in radians.
  void rotate(double angle) {
    for (final vector in vertices) {
      vector.rotate(angle);
    }
  }
}

/// Calculates all [Vector2]s of an ellipse.
///
/// An ellipse can be achieved by specifying a [center], a [majorRadius] and a
/// [minorRadius].
///
/// The higher the [precision], the more [Vector2]s will be calculated;
/// achieving a more rounded ellipse.
///
/// For more information read: https://en.wikipedia.org/wiki/Ellipse.
List<Vector2> calculateEllipse({
  required Vector2 center,
  required double majorRadius,
  required double minorRadius,
  int precision = 100,
}) {
  assert(
    0 < minorRadius && minorRadius <= majorRadius,
    'smallRadius ($minorRadius) and bigRadius ($majorRadius) must be in '
    'range 0 < smallRadius <= bigRadius',
  );

  final stepAngle = 2 * math.pi / (precision - 1);

  final points = <Vector2>[];
  for (var i = 0; i < precision; i++) {
    final x = center.x + minorRadius * math.cos(stepAngle * i);
    final y = center.y - majorRadius * math.sin(stepAngle * i);

    final point = Vector2(x, y);
    points.add(point);
  }

  return points;
}
