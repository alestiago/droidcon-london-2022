import 'package:counter_forge2d/game/game.dart';
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
        NumberBodyComponent()
          ..paint
          ..setColor(Colors.red),
        ScreenBoundaryComponent()
      ],
    );
  }
}
