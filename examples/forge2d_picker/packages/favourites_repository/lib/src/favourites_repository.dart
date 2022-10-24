// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:favourites_client/favourites_client.dart';

/// {@template favourites_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class FavouritesRepository {
  /// {@macro favourites_repository}
  const FavouritesRepository(this._client);

  final FavouritesClient _client;

  Stream<FavouritesData> favourites() {
    return _client.favourites();
  }

  Future<void> updateFavourites(FavouritesData data) async {
    return _client.updateFavourites(data);
  }
}
