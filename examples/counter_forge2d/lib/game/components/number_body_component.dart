import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

/// {@template number_body_component}
/// A physics body that displays a number.
/// {@endtemplate}
class NumberBodyComponent extends BodyComponent {
  /// {@macro number_body_component}
  NumberBodyComponent() {
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
    return world.createBody(bodyDef)..createFixture(fixtureDef);
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
