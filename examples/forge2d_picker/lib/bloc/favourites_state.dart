// ignore_for_file: prefer_asserts_with_message

part of 'favourites_bloc.dart';

@immutable
class FavouritesState extends Equatable {
  FavouritesState(this.ranking)
      : keys = UnmodifiableSetView(ranking.keys.toSet()),
        _relativeRanking = _calculateRelativeRanking(ranking);

  FavouritesState.intial()
      : this(
          UnmodifiableMapView(<String, int>{}),
        );

  final UnmodifiableSetView<String> keys;

  /// Represents the ranking of the widgets.
  ///
  /// The key is the name of the widget and the value is the amount
  /// of times it has been liked.
  final UnmodifiableMapView<String, int> ranking;

  final UnmodifiableMapView<String, double> _relativeRanking;

  double relativeRanking(String name) {
    final value = _relativeRanking[name] ?? 0;
    assert(value != null);
    assert(value >= 0 && value <= 1);
    return value;
  }

  @override
  List<Object?> get props => [ranking];

  FavouritesState copyWith({
    UnmodifiableMapView<String, int>? ranking,
  }) {
    return FavouritesState(
      ranking ?? this.ranking,
    );
  }

  static UnmodifiableMapView<String, double> _calculateRelativeRanking(
    UnmodifiableMapView<String, int> ranking,
  ) {
    final count = max(1, ranking.values.fold(0, (a, b) => a + b));
    return UnmodifiableMapView(
      {for (final key in ranking.keys) key: ranking[key]! / count},
    );
  }
}
