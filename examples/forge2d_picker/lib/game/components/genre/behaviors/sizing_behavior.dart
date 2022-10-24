import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:forge2d_picker/bloc/favourites_bloc.dart';
import 'package:forge2d_picker/game/game.dart';

class SizingBehaviour extends Component
    with
        FlameBlocListenable<FavouritesBloc, FavouritesState>,
        ParentIsA<GenreComponent> {
  @override
  bool listenWhen(FavouritesState previousState, FavouritesState newState) {
    final name = parent.name;
    return previousState.ranking[name] != newState.ranking[name];
  }

  @override
  void onNewState(FavouritesState state) {
    super.onNewState(state);

    final circleComponent = parent.children.whereType<CircleComponent>().first;
    final shape = parent.body.fixtures.first.shape;
    // TODO(jamesblasco): Modify the logic on how big the new size should appear
    // on screen.
    circleComponent.radius *= (state.ranking[parent.name] ?? 1) / 0.8;
    shape.radius = circleComponent.radius + parent.borderWidth;
  }
}
