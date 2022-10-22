import 'dart:math' as math;

import 'package:counter_forge2d/shapes/ellipse_shape.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

/// {@template number_body_component}
/// A physics body that displays a number.
/// {@endtemplate}
class NumberBodyComponent extends BodyComponent {
  /// {@macro number_body_component}
  NumberBodyComponent._({
    required this.textStyle,
    required List<FixtureDef> fixtureDefs,
    super.children,
  }) : _fixtureDefs = fixtureDefs {
    paint.color = Colors.red;
    paint.strokeWidth = 0.1;
  }

  NumberBodyComponent.zero({
    required TextStyle textStyle,
  }) : this._(
          textStyle: textStyle,
          fixtureDefs: [
            FixtureDef(
              EllipseShape(
                center: Vector2(-0.2, -0.2),
                majorRadius: textStyle.fontSize! * .35,
                minorRadius: textStyle.fontSize! * .23,
              ),
            ),
          ],
          children: [
            TextComponent(
              anchor: Anchor.center,
              position: Vector2.zero(),
              text: '0',
              textRenderer: TextPaint(style: textStyle),
            ),
          ],
        );

  NumberBodyComponent.one({
    required TextStyle textStyle,
  }) : this._(
          textStyle: textStyle,
          fixtureDefs: [
            FixtureDef(
              PolygonShape()
                ..setAsBox(
                  0.45,
                  1.7,
                  Vector2(-.7, -3.2),
                  0.97,
                ),
            ),
            FixtureDef(
              PolygonShape()
                ..setAsBox(
                  0.53,
                  4.2,
                  Vector2(.55, -.2),
                  0,
                ),
            ),
          ],
          children: [
            TextComponent(
              anchor: Anchor.center,
              position: Vector2.zero(),
              text: '1',
              textRenderer: TextPaint(style: textStyle),
            ),
          ],
        );

  final TextStyle textStyle;

  final List<FixtureDef> _fixtureDefs;

  @override
  Body createBody() {
    final center = gameRef.size / 2;
    final bodyDef = BodyDef(
      type: BodyType.dynamic,
      position: center
        ..setValues(center.x, center.y - (textStyle.fontSize!) / 2),
    );
    final body = world.createBody(bodyDef);
    _fixtureDefs.forEach(body.createFixture);
    return body;
  }
}
