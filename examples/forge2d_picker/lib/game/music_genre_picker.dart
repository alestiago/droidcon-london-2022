import 'dart:math' as math;
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/painting.dart';
import 'package:forge2d_picker/bloc/favourites_bloc.dart';
import 'package:forge2d_picker/game/game.dart';

class MusicGenrePicker extends Forge2DGame with HasTappables {
  MusicGenrePicker({
    required this.favouritesBloc,
  }) : super(
          gravity: Vector2.zero(),
          zoom: 1,
        );

  final FavouritesBloc favouritesBloc;

  final _random = math.Random();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final genres = [
      'Rock',
      'Pop',
      'Hip Hop',
      'Rap',
      'Country',
    ];
    final children = <Component>[];
    for (final genre in genres) {
      final randomPosition = Vector2(
        _random.nextDouble() * size.x,
        _random.nextDouble() * size.y,
      );
      children.add(
        GenreComponent(
          name: genre,
          color: const Color(0xFF0000FF),
          initialPosition: randomPosition,
        ),
      );
    }

    await add(
      FlameBlocProvider<FavouritesBloc, FavouritesState>.value(
        value: favouritesBloc,
        children: children,
      ),
    );
  }
}
