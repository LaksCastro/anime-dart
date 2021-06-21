import 'package:anime_dart/app/constants/utils.dart';

import 'package:anime_dart/app/core/details/infra/data_source/details_data_source.dart';
import 'package:anime_dart/app/core/details/infra/models/anime_details_model.dart';
import 'package:anime_dart/app/core/details/infra/models/episode_details_model.dart';
import 'package:anime_dart/app/core/favorites/domain/repositories/favorite_repository.dart';
import 'package:anime_dart/app/core/watched/domain/repository/watched_repository.dart';

class AnimeTvDetailsDataSource implements DetailsDataSource {
  final _baseUrl = "https://appanimeplus.tk/meuanimetv-40.php";
  final _imageBaseUrl = "https://cdn.appanimeplus.tk/img/";

  final FavoritesRepository favorites;
  final WatchedRepository watched;

  final dio = Utils.dio;

  AnimeTvDetailsDataSource({
    this.favorites,
    this.watched,
  });

  String _getCompleteImageUrl(String imageId) {
    return _imageBaseUrl + imageId;
  }

  @override
  Future<AnimeDetailsModel> getAnimeDetails(String id) async {
    try {
      final response = await dio.get(_baseUrl + "?info=$id");

      final data = response.data[0];

      bool isFavorite = false;

      try {
        final result = await favorites.isFavorite(id);

        result.fold((l) => throw l, (r) => isFavorite = r);
      } catch (e) {}

      Map<String, dynamic> source = {
        "id": data["id"],
        "title": data["category_name"],
        "synopsis": data["category_name"],
        "imageUrl": _getCompleteImageUrl(data["category_image"]),
        "imageHttpHeaders": Utils.simpleHttpHeaders,
        "year": data["ano"],
        "genres": data["category_genres"].replaceAll(" ", "").split(","),
        "isFavorite": isFavorite
      };

      final result = AnimeDetailsModel.fromMap(source);

      return result;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<EpisodeDetailsModel> getEpisodeDetails(String id) async {
    try {
      final response = await dio.get(_baseUrl + "?episodios=$id");

      final data = response.data[0];

      final ownerAnime = await getAnimeDetails(data["category_id"]);

      double stats = 0;

      try {
        final res = await watched.getEpisodeWatchedStats(id);
        res.fold((l) => throw l, (r) => stats = r);
      } catch (e) {}

      Map<String, dynamic> source = {
        "id": data["video_id"],
        "animeId": data["category_id"],
        "label": data["title"],
        "url": data["location"],
        "urlHd": data["locationsd"],
        "urlFullHd": data["locationhd"],
        "imageUrl": ownerAnime.imageUrl,
        "imageHttpHeaders": ownerAnime.imageHttpHeaders,
        "stats": stats
      };

      final result = EpisodeDetailsModel(
        animeId: source["animeId"],
        id: source["id"],
        imageHttpHeaders: source["imageHttpHeaders"],
        imageUrl: source["imageUrl"],
        label: source["label"],
        stats: source["stats"],
        url: source["url"],
        urlHd: source["urlHd"],
        urlFullHd: source["urlFullHd"],
      );

      return result;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<EpisodeDetailsModel> getNextEpisodeDetails(String id) async {
    try {
      final currentEpisode = await getEpisodeDetails(id);

      final ownerAnime = await getAnimeDetails(currentEpisode.animeId);

      final response = await dio.get(
        _baseUrl +
            "?episodios=${currentEpisode.id}&catid=${ownerAnime.id}&next",
      );

      final data = response.data[0];

      double stats = 0;

      try {
        final res = await watched.getEpisodeWatchedStats(data["video_id"]);
        res.fold((l) => throw l, (r) => stats = r);
      } catch (e) {}

      Map<String, dynamic> source = {
        "id": data["video_id"],
        "animeId": data["category_id"],
        "label": data["title"],
        "url": data["location"],
        "urlHd": data["locationsd"],
        "imageUrl": ownerAnime.imageUrl,
        "imageHttpHeaders": ownerAnime.imageHttpHeaders,
        "stats": stats
      };

      final nextEpisode = EpisodeDetailsModel.fromMap(source);

      return nextEpisode;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<EpisodeDetailsModel> getPreviousEpisodeDetails(String id) async {
    try {
      final currentEpisode = await getEpisodeDetails(id);

      final ownerAnime = await getAnimeDetails(currentEpisode.animeId);

      final endpoint = _baseUrl +
          "?episodios=${currentEpisode.id}&catid=${ownerAnime.id}&previous";

      final response = await dio.get(endpoint);

      final data = response.data[0];

      double stats = 0;

      try {
        final res = await watched.getEpisodeWatchedStats(data["video_id"]);
        res.fold((l) => throw l, (r) => stats = r);
      } catch (e) {}

      Map<String, dynamic> source = {
        "id": data["video_id"],
        "animeId": data["category_id"],
        "label": data["title"],
        "url": data["location"],
        "urlHd": data["locationsd"],
        "imageUrl": ownerAnime.imageUrl,
        "imageHttpHeaders": ownerAnime.imageHttpHeaders,
        "stats": stats
      };

      final previousEpisode = EpisodeDetailsModel.fromMap(source);

      return previousEpisode;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<EpisodeDetailsModel>> getEpisodesOf(String id) async {
    try {
      final targetAnime = await getAnimeDetails(id);

      final response = await dio.get(_baseUrl + "?cat_id=${targetAnime.id}");

      final data = response.data;

      final episodes = <EpisodeDetailsModel>[];

      for (final episode in data) {
        double stats = 0;

        try {
          final res = await watched.getEpisodeWatchedStats(episode["video_id"]);
          res.fold((l) => throw l, (r) => stats = r);
        } catch (e) {}

        Map<String, dynamic> source = {
          "id": episode["video_id"],
          "animeId": episode["category_id"],
          "label": episode["title"],
          "url": episode["location"],
          "urlHd": episode["locationsd"],
          "imageUrl": targetAnime.imageUrl,
          "imageHttpHeaders": targetAnime.imageHttpHeaders,
          "stats": stats
        };

        episodes.add(EpisodeDetailsModel.fromMap(source));
      }

      return List.from(episodes.reversed);
    } catch (e) {
      throw e;
    }
  }
}
