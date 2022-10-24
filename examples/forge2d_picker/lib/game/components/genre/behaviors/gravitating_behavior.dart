import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flutter/material.dart';
import 'package:forge2d_picker/bloc/favourites_bloc.dart';
import 'package:forge2d_picker/game/game.dart';

class GravitatingBehavior extends Component
    with
        ParentIsA<GenreComponent>,
        FlameBlocListenable<FavouritesBloc, FavouritesState> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    parent.body.gravityOverride = Vector2.zero();
    parent.body.linearDamping = 5;
  }

  @override
  bool listenWhen(FavouritesState previousState, FavouritesState newState) {
    final name = parent.name;
    return previousState.relativeRanking(name) !=
        newState.relativeRanking(name);
  }

  double gravity = 1;
  
  @override
  void update(double dt) {
    super.update(dt);
    final center = parent.gameRef.size / 2;
    parent.body.gravityOverride = (center - parent.body.position) * gravity;
  }

  @override
  void onNewState(FavouritesState state) {
    super.onNewState(state);
    final relativeValue = state.relativeRanking(parent.name);
    gravity = gravityRange.transform(relativeValue);
  }

  final gravityRange = Tween<double>(begin: 2, end: 10);
}
