part of 'favourites_bloc.dart';

@immutable
class FavouritesState extends Equatable {
  const FavouritesState(this.ranking);

  FavouritesState.intial()
      : this(
          UnmodifiableMapView(<String, int>{}),
        );

  /// Represents the ranking of the widgets.
  ///
  /// The key is the name of the widget and the value is the amount
  /// of times it has been liked.
  final UnmodifiableMapView<String, int> ranking;

  FavouritesState copyWith({
    UnmodifiableMapView<String, int>? ranking,
  }) {
    return FavouritesState(
      ranking ?? this.ranking,
    );
  }

  @override
  List<Object?> get props => [ranking];
}
