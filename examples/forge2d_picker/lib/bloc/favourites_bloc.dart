import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

final _widgets = [
  'SizedBox',
  'Container',
  'Text',
  'Row',
  'Column',
  'ListView',
  'Stack',
  'Align',
  'Padding',
];

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc() : super(FavouritesState.intial()) {
    on<FavouritesLiked>(_onFavouritesLiked);

    // TODO(jamesblasco): Remove random liker in favour of Firebase.
    _randomLiker();
  }

  void _onFavouritesLiked(FavouritesLiked event, Emitter emit) {
    print(state.ranking);
    final ranking = state.ranking;
    final newRanking = Map<String, int>.from(state.ranking);
    newRanking[event.name] = (ranking[event.name] ?? 0) + 1;
    emit(
      state.copyWith(
        ranking: UnmodifiableMapView(newRanking),
      ),
    );
  }

  Future<void> _randomLiker() async {
    _widgets.shuffle();
    add(FavouritesLiked(_widgets.first));

    if (!isClosed) {
      Future.delayed(const Duration(seconds: 1), _randomLiker);
    }
  }
}
