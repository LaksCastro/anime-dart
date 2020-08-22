import 'package:anime_dart/app/constants/utils.dart';
import 'package:anime_dart/app/core/favorites/domain/repositories/favorite_repository.dart';

import 'package:anime_dart/app/core/search/domain/errors/exceptions.dart';
import 'package:anime_dart/app/core/search/infra/data_sources/search_data_source.dart';
import 'package:anime_dart/app/core/search/infra/models/anime_model.dart';

class AnimeTvSearchDataSource implements SearchDataSource {
  final _baseUrl = "https://appanimeplus.tk/api-animesbr-10.php";
  final _imageBaseUrl = "https://cdn.appanimeplus.tk/img/";
  final _httpHeaders = {
    "User-Agent":
        "Mozilla/5.0 (Linux; Android 5.1.1; SM-G928X Build/LMY47X) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.83 Mobile Safari/537.36"
  };
  final FavoritesRepository favorites;

  final dio = Utils.dio;

  AnimeTvSearchDataSource({
    this.favorites,
  });

  String _getCompleteImageUrl(String imageId) {
    return _imageBaseUrl + imageId;
  }

  @override
  Future<List<AnimeModel>> searchByText(String searchText) async {
    try {
      final response = await dio.get(_baseUrl + "?search=$searchText");

      final data = response.data;

      final results = <AnimeModel>[];

      for (final result in data) {
        bool isFavorite = false;

        try {
          final response = await favorites.isFavorite(result["id"]);

          response.fold((l) => throw l, (r) => isFavorite = r);
        } catch (e) {}

        Map<String, dynamic> source = {
          "id": result["id"],
          "title": result["category_name"],
          "imageUrl": _getCompleteImageUrl(result["category_image"]),
          "imageHttpHeaders": _httpHeaders,
          "isFavorite": isFavorite
        };

        results.add(AnimeModel.fromMap(source));
      }

      return results;
    } catch (e) {
      throw NotFoundResultsException("No results found for this search query");
    }
  }

  @override
  Future<List<AnimeModel>> searchByLetter(String searchLetter) async {
    try {
      final response = await dio.get(_baseUrl + "?letra=$searchLetter");

      final data = response.data;

      final results = <AnimeModel>[];

      for (final result in data) {
        bool isFavorite = false;

        try {
          final result = await favorites.isFavorite(data["id"]);

          result.fold((l) => throw l, (r) => isFavorite = r);
        } catch (e) {}

        Map<String, dynamic> source = {
          "id": result["id"],
          "title": result["category_name"],
          "imageUrl": _getCompleteImageUrl(result["category_image"]),
          "imageHttpHeaders": _httpHeaders,
          "isFavorite": isFavorite
        };

        results.add(AnimeModel.fromMap(source));
      }

      return results;
    } catch (e) {
      throw NotFoundResultsException("No results found for this search query");
    }
  }
}
