import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: _BookGenrePicker()));
}

class _BookGenrePicker extends FlameGame {}
