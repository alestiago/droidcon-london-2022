import 'dart:math' as math;

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:forge2d_picker/bloc/favourites_bloc.dart';
import 'package:forge2d_picker/game/game.dart';

final _random = math.Random();

class SpawningBehavior extends Component
    with FlameBlocListenable<FavouritesBloc, FavouritesState>, HasGameRef {
  @override
  bool listenWhen(FavouritesState previousState, FavouritesState newState) {
    print('listn');
    return newState.keys.difference(previousState.keys).isNotEmpty ||
        newState.keys.length == previousState.keys.length;
  }

  final Map<String, Component> components = {};

  @override
  void onMount() {
    super.onMount();
   Future.microtask(() =>  updateState(bloc.state));
  }

  void updateState(FavouritesState state) {
    final newKeys = state.keys;
    final previousKeys = components.keys.toSet();
    final addedItems = newKeys.difference(previousKeys);
    final removedItems = previousKeys.difference(newKeys);

    for (final item in addedItems) {
      assert(
        !components.containsKey(item),
        'components should not have $item item before is added',
      );
      final randomPosition = Vector2(
        _random.nextDouble() * gameRef.size.x,
        _random.nextDouble() * gameRef.size.y,
      );
      final component = GenreComponent(
        name: item,
        color: const Color(0xFF0000FF),
        initialPosition: randomPosition,
      );
      components[item] = component;
      parent!.add(component);
    }

    for (final item in removedItems) {
      assert(
        components.containsKey(item),
        'components need to have $item item before is removed',
      );
      final component = components.remove(item)!;
      parent!.remove(component);
    }
  }

  @override
  void onNewState(FavouritesState state) {
    super.onNewState(state);
    updateState(state);
  }
}
