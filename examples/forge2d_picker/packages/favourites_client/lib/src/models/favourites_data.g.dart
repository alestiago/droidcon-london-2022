// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourites_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavouritesData _$FavouritesDataFromJson(Map<String, dynamic> json) =>
    FavouritesData(
      name: json['name'] as String?,
      values: (json['values'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as int),
          ) ??
          const {},
    );

Map<String, dynamic> _$FavouritesDataToJson(FavouritesData instance) =>
    <String, dynamic>{
      'values': instance.values,
      'name': instance.name,
    };
