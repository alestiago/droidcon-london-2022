import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:forge2d_picker/bloc/favourites_bloc.dart';
import 'package:forge2d_picker/game/components/genre/behaviors/ticker_provider_component_mixin.dart';
import 'package:forge2d_picker/game/game.dart';

import 'package:forge2d_picker/propagators/implicit_animated_value.dart';


class SizingBehaviour extends Component
    with
        FlameBlocListenable<FavouritesBloc, FavouritesState>,
        ParentIsA<GenreComponent>,
        TickerProviderComponentMixin {
  
  late final _animatedProgress = ImplicitAnimatedValue<double>(vsync: this);
  final _fontSizeRange = Tween<double>(begin: 13, end: 60);
  final _radiusRange = Tween<double>(begin: 50, end: 200);


  late CircleComponent _circleComponent;
  late TextComponent _textComponent;
  late Shape _shape;


  double relativeRanking = 0;

  @override
  bool listenWhen(FavouritesState previousState, FavouritesState newState) {
    final name = parent.name;
    return previousState.relativeRanking(name) !=
        newState.relativeRanking(name);
  }


  @override
  void onNewState(FavouritesState state) {
    super.onNewState(state);
    relativeRanking = state.relativeRanking(parent.name);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _circleComponent = parent.children.whereType<CircleComponent>().first;
    _textComponent = parent.children.whereType<TextComponent>().first;
    _shape = parent.body.fixtures.first.shape;
  }

  @override
  void onMount() {
    
    super.onMount();
     Future.microtask(() =>  relativeRanking = bloc.state.relativeRanking(parent.name));
  }

  @override
  void update(double dt) {
    super.update(dt);
    final progress = _animatedProgress.forTarget(relativeRanking);
    _circleComponent.radius = _radiusRange.transform(progress);
    _shape.radius = _circleComponent.radius + parent.borderWidth;

    final renderer = _textComponent.textRenderer as TextPaint;
    _textComponent.textRenderer = TextPaint(
      style: renderer.style.copyWith(
        fontSize: _fontSizeRange.transform(progress),
      ),
    );
  }

  @override
  void onRemove() {
    _animatedProgress.dispose();
    super.onRemove();
  }
}
