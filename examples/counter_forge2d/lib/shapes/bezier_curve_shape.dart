import 'dart:math' as math;
import 'package:flame_forge2d/flame_forge2d.dart';

/// {@template bezier_curve_shape}
/// Creates a bezier curve.
/// {@endtemplate}
class BezierCurveShape extends ChainShape {
  /// {@macro bezier_curve_shape}
  BezierCurveShape({
    required this.controlPoints,
  }) {
    createChain(calculateBezierCurve(controlPoints: controlPoints));
  }

  /// Specifies the control points of the curve.
  ///
  /// First and last [controlPoints] set the beginning and end of the curve,
  /// inner points between them set its final shape.
  final List<Vector2> controlPoints;
}

/// Calculates all [Vector2]s of a bezier curve.
///
/// A bezier curve of [controlPoints] that say how to create this curve.
///
/// First and last points specify the beginning and the end respectively
/// of the curve. The inner points specify the shape of the curve and
/// its turning points.
///
/// The [step] must be between zero and one (inclusive), indicating the
/// precision to calculate the curve.
///
/// For more information read: https://en.wikipedia.org/wiki/B%C3%A9zier_curve
List<Vector2> calculateBezierCurve({
  required List<Vector2> controlPoints,
  double step = 0.01,
}) {
  assert(
    0 <= step && step <= 1,
    'Step ($step) must be in range  0 <= step <= 1',
  );
  assert(
    controlPoints.length >= 2,
    'At least 2 control points needed to create a bezier curve',
  );

  var t = 0.0;
  final n = controlPoints.length - 1;
  final points = <Vector2>[];

  do {
    var x = 0.0;
    var y = 0.0;
    for (var i = 0; i <= n; i++) {
      final point = controlPoints[i];

      x += binomial(n, i) * math.pow(1 - t, n - i) * math.pow(t, i) * point.x;
      y += binomial(n, i) * math.pow(1 - t, n - i) * math.pow(t, i) * point.y;
    }
    points.add(Vector2(x, y));

    t = t + step;
  } while (t <= 1);

  return points;
}

/// Calculates the binomial coefficient of 'n' and 'k'.
///
/// For more information read: https://en.wikipedia.org/wiki/Binomial_coefficient
num binomial(num n, num k) {
  assert(0 <= k && k <= n, 'k ($k) and n ($n) must be in range 0 <= k <= n');

  if (k == 0 || n == k) {
    return 1;
  } else {
    return factorial(n) / (factorial(k) * factorial(n - k));
  }
}

/// Calculate the factorial of 'n'.
///
/// For more information read: https://en.wikipedia.org/wiki/Factorial
num factorial(num n) {
  assert(n >= 0, 'Factorial is not defined for negative number n ($n)');

  if (n == 0 || n == 1) {
    return 1;
  } else {
    return n * factorial(n - 1);
  }
}
