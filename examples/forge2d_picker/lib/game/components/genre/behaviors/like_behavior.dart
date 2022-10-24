import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:forge2d_picker/bloc/favourites_bloc.dart';
import 'package:forge2d_picker/game/game.dart';

class LikingBehaviour extends Component
    with
        FlameBlocReader<FavouritesBloc, FavouritesState>,
        Tappable,
        ParentIsA<GenreComponent> {
  @override
  bool onTapDown(TapDownInfo info) {
    bloc.add(FavouritesLiked(parent.name));
    return super.onTapDown(info);
  }
}
