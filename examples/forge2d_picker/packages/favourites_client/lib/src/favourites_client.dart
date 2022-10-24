// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:favourites_client/favourites_client.dart';

/// {@template favourites_client}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class FavouritesClient {
  /// {@macro favourites_client}
  const FavouritesClient(this._firestore);

  final FirebaseFirestore _firestore;

  Stream<FavouritesData> favourites() {
    return _firestore
        .collection('sessions')
        .doc('widgets')
        .withConverter<FavouritesData>(
          fromFirestore: (snapshot, _) => FavouritesData.fromJson(
            snapshot.data() ?? {},
          ),
          toFirestore: (model, _) => model.toJson(),
        )
        .snapshots()
        .map((event) => event.data()!);
  }

  Future<void> updateFavourites(FavouritesData data) async {
    try {
      await _firestore
          .collection('sessions')
          .doc('widgets')
          .update(data.toJson());
    } catch (e) {
      log('Error', error: e);
      rethrow;
    }
  }
}
