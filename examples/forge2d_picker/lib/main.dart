import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge2d_picker/bloc/favourites_bloc.dart';
import 'package:forge2d_picker/game/game.dart';

void main() {
  runApp(
    BlocProvider<FavouritesBloc>(
      create: (context) => FavouritesBloc(),
      child: Builder(
        builder: (context) {
          return GameWidget(
            game: MusicGenrePicker(
              favouritesBloc: context.read<FavouritesBloc>(),
            ),
          );
        },
      ),
    ),
  );
}
