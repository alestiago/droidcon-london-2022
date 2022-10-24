import 'dart:collection';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:favourites_client/favourites_client.dart';
import 'package:favourites_repository/favourites_repository.dart';
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
  FavouritesBloc(this._repository) : super(FavouritesState.intial()) {
    on<FavouritesInitialized>(_onFavouritesInitialized);
    on<FavouritesLiked>(_onFavouritesLiked);
  }

  FavouritesRepository _repository;

  Future<void> _onFavouritesInitialized(
      FavouritesInitialized event, Emitter<FavouritesState> emit) async {
    await emit.forEach(
      _repository.favourites(),
      onData: (FavouritesData data) {
        final newState = state.copyWith(
          ranking: UnmodifiableMapView(data.values),
        );
        print(data);
        return newState;
      },
    );
  }

  Future<void> _onFavouritesLiked(
    FavouritesLiked event,
    Emitter<FavouritesState> emit,
  ) async {
    final ranking = state.ranking;
    final newRanking = Map<String, int>.from(state.ranking);
    newRanking[event.name] = (ranking[event.name] ?? 0) + 1;
    final newState = state.copyWith(
      ranking: UnmodifiableMapView(newRanking),
    );

    await _repository.updateFavourites(
      FavouritesData(values: newState.ranking),
    );
  }
}
