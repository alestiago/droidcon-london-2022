import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/text.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class CounterGame extends Forge2DGame {
  CounterGame() : super(gravity: Vector2(0, 10));

  @override
  Color backgroundColor() => Colors.white;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await addAll(
      [
        _NumberBodyComponent()
          ..paint
          ..setColor(Colors.red),
        _WallBodyComoponent()
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

class _WallBodyComoponent extends BodyComponent with ContactCallbacks {
  _WallBodyComoponent() {
    paint.color = Colors.blue;
  }

  @override
  void beginContact(Object other, Contact contact) {
    super.beginContact(other, contact);
    print('contact');
  }

  @override
  Body createBody() {
    final shape = PolygonShape()..setAsBoxXY(gameRef.size.x, 0.1);
    final fixtureDef = FixtureDef(shape);
    final bodyDef = BodyDef(
      position: Vector2(0, gameRef.size.y + 0.1),
      type: BodyType.static,
      userData: this,
    );
    final body = world.createBody(bodyDef);
    body.createFixture(fixtureDef);
    return body;
  }
}
