import 'package:flame_forge2d/flame_forge2d.dart';

/// {@template screen_boundary_component}
/// A physics body that represents the screen boundary.
///
/// In other words, adds "walls" to the screen so that objects don't fall
/// out of it.
/// {@endtemplate}
class ScreenBoundaryComponent extends BodyComponent {
  /// {@macro screen_boundary_component}
  ScreenBoundaryComponent();

  @override
  Body createBody() {
    const strokeWidth = 0.0;
    final shapes = [
      PolygonShape()..setAsBoxXY(gameRef.size.x, strokeWidth),
      PolygonShape()..setAsBoxXY(strokeWidth, gameRef.size.y),
      PolygonShape()
        ..setAsBox(
          strokeWidth,
          gameRef.size.y,
          Vector2(gameRef.size.x, 0),
          0,
        ),
      PolygonShape()
        ..setAsBox(
          gameRef.size.x,
          strokeWidth,
          Vector2(0, gameRef.size.y),
          0,
        ),
    ];

    final bodyDef = BodyDef(
      position: Vector2(0, gameRef.size.y),
    );
    final body = world.createBody(bodyDef);
    shapes.forEach(body.createFixtureFromShape);
    return body;
  }
}
