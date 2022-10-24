import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:forge2d_picker/bloc/favourites_bloc.dart';
import 'package:forge2d_picker/game/game.dart';

final _random = math.Random();

class SpawningBehavior extends Component
    with FlameBlocListenable<FavouritesBloc, FavouritesState>, HasGameRef {
  late String name;

  @override
  bool listenWhen(FavouritesState previousState, FavouritesState newState) {
    // TODO(jamesblasco): Improve or simplify this logic as needed.
    print('previous: ${previousState.ranking}');
    print('newState: ${newState.ranking}');

    final difference = newState.ranking.entries
        .where((entry) => previousState.ranking[entry.key] != entry.value)
        .toList();
    if (difference.length == 1) {
      name = difference.first.key;
      return true;
    }
    return false;
  }

  @override
  void onNewState(FavouritesState state) {
    super.onNewState(state);

    final randomPosition = Vector2(
      _random.nextDouble() * gameRef.size.x,
      _random.nextDouble() * gameRef.size.y,
    );
    parent!.add(
      GenreComponent(
        name: name,
        color: const Color(0xFF0000FF),
        initialPosition: randomPosition,
      ),
    );
  }
}
