part of 'favourites_bloc.dart';

@immutable
abstract class FavouritesEvent extends Equatable {
  const FavouritesEvent();
}

class FavouritesInitialized extends FavouritesEvent {
  const FavouritesInitialized();

  @override
  List<Object?> get props => [];
}

class FavouritesLiked extends FavouritesEvent {
  const FavouritesLiked(this.name);

  final String name;

  @override
  List<Object?> get props => [name];
}
