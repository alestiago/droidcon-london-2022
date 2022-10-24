import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favourites_client/favourites_client.dart';
import 'package:favourites_repository/favourites_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forge2d_picker/bloc/favourites_bloc.dart';
import 'package:forge2d_picker/firebase_options.dart';
import 'package:forge2d_picker/game/game.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final client = FavouritesClient(FirebaseFirestore.instance);
  runApp(
    RepositoryProvider(
      create: (context) => FavouritesRepository(client),
      child: BlocProvider<FavouritesBloc>(
        create: (context) => FavouritesBloc(
          context.read<FavouritesRepository>(),
        )..add(const FavouritesInitialized()),
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
    ),
  );
}
