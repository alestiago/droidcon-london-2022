import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/painting.dart';
import 'package:forge2d_picker/game/components/genre/behaviors/behaviors.dart';

class GenreComponent extends BodyComponent {
  GenreComponent({
    required this.name,
    required this.color,
    required this.initialPosition,
  }) : super(
          children: [
            GravitatingBehavior(),
            CircleComponent(
              anchor: Anchor.center,
              radius: 50,
              paint: Paint()..color = color,
            ),
          ],
        );

  final String name;

  final Color color;

  final Vector2 initialPosition;

  @override
  Body createBody() {
    final shape = CircleShape()..radius = 50;
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
