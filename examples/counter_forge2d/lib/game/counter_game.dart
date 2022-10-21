import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

/// {@template counter_game}
/// A simple phsyics game that counts how many times the screen is tapped.
/// {@endtemplate}
class CounterGame extends Forge2DGame {
  /// {@macro counter_game}
  CounterGame({
    required Color backgroundColor,
  })  : _backgroundColor = backgroundColor,
        super(gravity: Vector2(0, 10));

  final Color _backgroundColor;

  @override
  Color backgroundColor() => _backgroundColor;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await addAll(
      [
        _NumberBodyComponent()
          ..paint
          ..setColor(Colors.red),
        _WallBodyComponent()
      ],
    );
  }
}

class _NumberBodyComponent extends BodyComponent {
  _NumberBodyComponent() {
    paint.color = Colors.red;
  }

  @override
  Body createBody() {
    final shape = CircleShape()..radius = 10;
    final fixtureDef = FixtureDef(
      shape,
      density: 10,
      restitution: 0.2,
    );
    final bodyDef = BodyDef(
      position: Vector2(10, 0),
      type: BodyType.dynamic,
      userData: this,
    );
    final body = world.createBody(bodyDef);
    body.createFixture(fixtureDef);
    return body;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await add(
      TextComponent(
        anchor: Anchor.topCenter,
        position: Vector2(0, -10),
        text: '1',
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

class _WallBodyComponent extends BodyComponent {
  _WallBodyComponent() {
    paint.color = Colors.blue;
  }

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBoxXY(gameRef.size.x, 0.1);
    final fixtureDef = FixtureDef(shape);
    final bodyDef = BodyDef(
      position: Vector2(0, gameRef.size.y + 0.1),
    );
    final body = world.createBody(bodyDef);
    body.createFixture(fixtureDef);
    return body;
  }
}
