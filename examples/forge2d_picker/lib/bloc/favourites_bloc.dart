import 'dart:collection';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc()
      : super(
          FavouritesState(
            UnmodifiableMapView(
              <String, int>{
                'SizedBox': 0,
                'ColoredBox': 0,
                'Stack': 0,
                'Row': 0,
                'MaterialApp': 0,
              },
            ),
          ),
        ) {
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
    final ranking = state.ranking;
    final newRanking = Map<String, int>.from(state.ranking);
    final randomKey = (ranking.keys.toList()..shuffle()).first;
    newRanking[randomKey] = (ranking[randomKey] ?? 0) + 1;
    add(
      FavouritesLiked(randomKey),
    );

    if (!isClosed) {
      Future.delayed(const Duration(seconds: 1), _randomLiker);
    }
  }
}
