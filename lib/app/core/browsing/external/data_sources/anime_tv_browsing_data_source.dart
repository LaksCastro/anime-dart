import 'package:anime_dart/app/core/search/domain/entities/anime.dart';
import 'package:anime_dart/app/core/watched/domain/repository/watched_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:anime_dart/app/constants/utils.dart';
import 'package:anime_dart/app/core/browsing/domain/errors/exceptions.dart';
import 'package:anime_dart/app/core/browsing/infra/data_sources/browsing_data_source.dart';
import 'package:anime_dart/app/core/browsing/infra/models/episode_model.dart';
import 'package:anime_dart/app/core/favorites/domain/repositories/favorite_repository.dart';
import 'package:anime_dart/app/core/search/infra/models/anime_model.dart';

class AnimeTvBrowsingDataSource implements BrowsingDataSource {
  final _baseUrl = 'https://appanimeplus.tk/meuanimetv-40.php';
  final _imageBaseUrl = 'https://cdn.appanimeplus.tk/img/';

  final dio = Utils.dio;

  final _watchedListKey = 'anime__dart__application__watched__episodes';

  final _minAnimeId = 3;
  final _maxAnimeId = 2715;

  final FavoritesRepository favorites;
  final WatchedRepository watched;

  AnimeTvBrowsingDataSource({
    this.favorites,
    this.watched,
  });

  Future<EpisodeModel> _getEpisodeFromId(String id) async {
    try {
      final response = await dio.get(_baseUrl + '?episodios=$id');

      final data = response.data[0];

      final anime = await _getAnimeFromId(data['category_id']);

      double stats = 0;

      try {
        final res = await watched.getEpisodeWatchedStats(id);
        res.fold((l) => throw l, (r) => stats = r);
      } catch (e) {}

      Map<String, dynamic> source = {
        'id': data['id'],
        'animeId': anime.id,
        'label': data['title'],
        'imageUrl': anime.imageUrl,
        'imageHttpHeaders': anime.imageHttpHeaders,
        'stats': stats
      };

      final result = EpisodeModel.fromMap(source);

      return result;
    } catch (e) {
      throw e;
    }
  }

  String _getCompleteImageUrl(String imageId) {
    return _imageBaseUrl + imageId;
  }

  String _getRandomAnimeId() {
    return Utils.randomInt(_minAnimeId, _maxAnimeId).toString();
  }

  Future<AnimeModel> _getAnimeFromId(String id) async {
    try {
      final response = await dio.get(
        _baseUrl + '?info=$id',
      );

      final data = response.data[0];

      bool isFavorite = false;

      try {
        final result = await favorites.isFavorite(id);

        result.fold((l) => throw l, (r) => isFavorite = r);
      } catch (e) {}

      Map<String, dynamic> source = {
        'id': data['id'],
        'title': data['category_name'],
        'imageUrl': _getCompleteImageUrl(data['category_image']),
        'imageHttpHeaders': Utils.simpleHttpHeaders,
        'isFavorite': isFavorite
      };

      final result = AnimeModel.fromMap(source);

      return result;
    } catch (e) {
      throw e;
    }
  }

  Future<AnimeModel> _getRandomAnime() async {
    try {
      String id = _getRandomAnimeId();

      final result = await _getAnimeFromId(id);

      return result;
    } catch (e) {
      final result = await _getRandomAnime();

      return result;
    }
  }

  @override
  Future<List<Anime>> getFavoriteAnimes() async {
    try {
      final results = await favorites.getFavorites();

      var right;

      results.fold((l) => throw Exception(), (r) => right = r);

      return right;
    } catch (e) {
      throw UnableToFetchDataException('A internal server error');
    }
  }

  @override
  Future<List<EpisodeModel>> getLatestEpisodes() async {
    try {
      final response = await dio.get(_baseUrl + '?latest');

      final data = response.data;

      final results = <EpisodeModel>[];

      for (final result in data) {
        double stats = 0;

        try {
          final res = await watched.getEpisodeWatchedStats(result['video_id']);
          res.fold((l) => throw l, (r) => stats = r);
        } catch (e) {}

        Map<String, dynamic> source = {
          'id': result['video_id'],
          'animeId': result['category_id'],
          'label': result['title'],
          'imageUrl': _getCompleteImageUrl(result['category_image']),
          'imageHttpHeaders': Utils.simpleHttpHeaders,
          'stats': stats
        };

        results.add(EpisodeModel.fromMap(source));
      }

      return results;
    } catch (e) {
      throw UnableToFetchDataException('A internal server error');
    }
  }

  @override
  Future<List<AnimeModel>> getRandomAnimes() async {
    return await Future.wait(List.generate(20, (_) => _getRandomAnime()));
  }

  @override
  Future<List<AnimeModel>> getTrendingAnimes() async {
    try {
      final response = await dio.get(_baseUrl + '?populares');

      final data = response.data;

      final results = <AnimeModel>[];

      for (final result in data) {
        bool isFavorite = false;

        try {
          final req = await favorites.isFavorite(result['id']);

          req.fold((l) => throw l, (r) => isFavorite = r);
        } catch (e) {}

        Map<String, dynamic> source = {
          'id': result['id'],
          'title': result['category_name'],
          'imageUrl': _getCompleteImageUrl(result['category_image']),
          'imageHttpHeaders': Utils.simpleHttpHeaders,
          'isFavorite': isFavorite
        };

        results.add(AnimeModel.fromMap(source));
      }

      return results;
    } catch (e) {
      throw UnableToFetchDataException('A internal server error');
    }
  }

  @override
  Future<List<EpisodeModel>> getWatchedEpisodes() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final watchedIds = prefs.getStringList(_watchedListKey) ?? <String>[];

      final watched = <EpisodeModel>[];

      for (final watchedId in watchedIds) {
        try {
          final episode = await _getEpisodeFromId(watchedId);

          watched.add(episode);
        } catch (e) {}
      }

      return watched;
    } catch (e) {
      throw UnableToFetchDataException('A internal server error');
    }
  }

  @override
  Future<List<Anime>> getByCategory(String category) async {
    try {
      final endpoint = '$_baseUrl?categoria=$category';

      final response = await dio.get(endpoint);

      final data = response.data;

      final animes = <Anime>[];

      for (final item in data) {
        bool isFavorite = false;

        try {
          final req = await favorites.isFavorite(item['id']);

          req.fold((l) => throw l, (r) => isFavorite = r);
        } catch (e) {}

        animes.add(Anime(
            id: item['id'],
            title: item['category_name'],
            imageUrl: _getCompleteImageUrl(item['category_image']),
            imageHttpHeaders: Utils.simpleHttpHeaders,
            isFavorite: isFavorite));
      }

      return animes;
    } catch (e) {
      throw UnableToFetchDataException('A internal server error');
    }
  }
}
