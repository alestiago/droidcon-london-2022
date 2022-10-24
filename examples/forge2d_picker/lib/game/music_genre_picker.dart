import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/painting.dart';
import 'package:forge2d_picker/bloc/favourites_bloc.dart';
import 'package:forge2d_picker/game/behaviors/spawning_behavior.dart';
import 'package:forge2d_picker/game/game.dart';

class MusicGenrePicker extends Forge2DGame with HasTappables {
  MusicGenrePicker({
    required this.favouritesBloc,
  }) : super(
          gravity: Vector2.zero(),
          zoom: 1,
        );

  final FavouritesBloc favouritesBloc;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await add(
      FlameBlocProvider<FavouritesBloc, FavouritesState>.value(
        value: favouritesBloc,
        children: [
          SpawningBehavior(),
        ],
      ),
    );
  }
}
