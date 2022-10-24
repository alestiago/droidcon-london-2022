import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/painting.dart';
import 'package:forge2d_picker/game/components/genre/behaviors/sizing_behavior.dart';
import 'package:forge2d_picker/game/game.dart';
import 'package:forge2d_picker/propagators/tappable_propagator.dart';

import 'behaviors/like_behavior.dart';

export 'package:forge2d_picker/game/components/genre/behaviors/behaviors.dart';

class GenreComponent extends BodyComponent with Tappable, TappablePropagator {
  GenreComponent({
    required this.name,
    required this.color,
    required this.initialPosition,
  }) : super(
          children: [
            CircleComponent(
              anchor: Anchor.center,
              radius: 50,
              paint: Paint()..color = color,
            ),
            TextComponent(
              anchor: Anchor.center,
              text: name,
              textRenderer: TextPaint(
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFFFFFFFF),
                ),
              ),
            ),
            GravitatingBehavior(),
            SizingBehaviour(),
            LikingBehaviour(),
          ],
        ) {
    paint = Paint()..color = Color(0x00000000);
  }

  final String name;

  final Color color;

  final Vector2 initialPosition;

  double radius = 50;

  final borderWidth = 1;

  @override
  Body createBody() {
    final shape = CircleShape()..radius = radius + borderWidth;
    final fixtureDef = FixtureDef(shape)
      ..density = 1.0
      ..restitution = 0.5;
    final bodyDef = BodyDef(
      type: BodyType.dynamic,
      position: initialPosition,
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

// 1) Without BodyComponent
// class GenreComponent extends PositionComponent {
//   GenreComponent({
//     required this.name,
//     required this.color,
//     required super.position,
//   }) : super(
//           children: [
//             CircleComponent(
//               radius: 50,
//               paint: Paint()..color = color,
//             ),
//           ],
//         );

//   final String name;

//   final Color color;
// }
