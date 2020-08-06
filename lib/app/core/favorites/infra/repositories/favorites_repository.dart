import 'package:dartz/dartz.dart';

import 'package:anime_dart/app/core/favorites/domain/errors/exceptions.dart';
import 'package:anime_dart/app/core/favorites/domain/repositories/favorite_repository.dart';
import 'package:anime_dart/app/core/favorites/infra/data_sources/favorites_data_source.dart';

class FavoritesRepositoryImplementation implements FavoritesRepository {
  final FavoritesDataSource dataSource;

  FavoritesRepositoryImplementation({
    this.dataSource,
  });

  @override
  Future<Either<FavoritesException, bool>> isFavorite(String id) async {
    try {
      final result = await dataSource.isFavorite(id);

      return Right(result);
    } catch (e) {
      return Left(RequestFavoriteFailed("Unable to read favorite stats"));
    }
  }

  @override
  Future<Either<FavoritesException, void>> setFavorite(
      String id, bool isFavorite) async {
    try {
      await dataSource.setFavorite(id, isFavorite);

      return Right(null);
    } catch (e) {
      return Left(RequestFavoriteFailed("Unable to set favorite stats"));
    }
  }
}
