import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

/// {@template screen_boundary_component}
/// A physics body that represents the screen boundary.
///
/// In other words, adds "walls" to the screen so that objects don't fall
/// out of it.
/// {@endtemplate}
class ScreenBoundaryComponent extends BodyComponent {
  /// {@macro screen_boundary_component}
  ScreenBoundaryComponent() {
    paint.color = Colors.blue;
  }

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBoxXY(gameRef.size.x, 0.1);
    final fixtureDef = FixtureDef(shape);
    final bodyDef = BodyDef(
      position: Vector2(0, gameRef.size.y + 0.1),
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}
