import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'favourites_data.g.dart';

@JsonSerializable()
class FavouritesData extends Equatable {

  factory FavouritesData.fromJson(Map<String, dynamic> json) =>
      _$FavouritesDataFromJson(json);
  const FavouritesData({this.name, this.values = const {}});

  final Map<String, int> values;

  final String? name;

  @override
  List<Object?> get props => [values];

  Map<String, dynamic> toJson() => _$FavouritesDataToJson(this);
}
