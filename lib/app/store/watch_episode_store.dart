import 'package:anime_dart/app/core/browsing/domain/repositories/browsing_repository.dart';
import 'package:anime_dart/app/core/details/domain/entities/episode_details.dart';
import 'package:anime_dart/app/core/details/domain/repository/details_repository.dart';
import 'package:anime_dart/app/core/search/domain/entities/anime.dart';
import 'package:anime_dart/app/setup.dart';
import 'package:anime_dart/app/store/central_store.dart';
import 'package:mobx/mobx.dart';
part 'watch_episode_store.g.dart';

class WatchEpisodeStore = _WatchEpisodeStoreBase with _$WatchEpisodeStore;

abstract class _WatchEpisodeStoreBase with Store {
  final detailsRepository = getIt<DetailsRepository>();
  final browsingRepository = getIt<BrowsingRepository>();
  final centralStore = getIt<CentralStore>();

  // ==================
  // WATCH EPISODES STORE
  // ==================
  @observable
  EpisodeDetails episodeDetails;

  @observable
  bool loadingWatchEpisode = true;

  @observable
  bool loadingOtherEpisode = false;

  @observable
  String errorMsg;

  @observable
  String episodeId;

  @observable
  String watchEpisodeId;

  @observable
  var recommendations = ObservableList<Anime>.of([]);

  @observable
  bool loadingRecommendations = true;

  @observable
  bool loadingMoreRecommendations = false;

  @observable
  String recommendationsError;

  @action
  Future<void> loadEpisode() async {
    final episodeId = watchEpisodeId;

    if (episodeDetails != null && episodeDetails.id == episodeId) {
      return;
    } else {
      episodeDetails = null;
      loadingWatchEpisode = true;
      loadingOtherEpisode = false;
      errorMsg = null;
    }

    final result = await detailsRepository.getEpisodeDetails(episodeId);

    runInAction(() {
      result.fold((l) {
        errorMsg =
            "Não foi possível carregar os detalhes desse episódio, tente novamente";
      }, (r) {
        errorMsg = null;
        episodeDetails = r;
      });

      loadingWatchEpisode = false;
    });
  }

  @action
  Future<void> loadNextEpisode() async {
    loadingOtherEpisode = true;

    final result =
        await detailsRepository.getNextEpisodeDetails(episodeDetails.id);

    runInAction(() {
      result.fold((l) {}, (r) {
        episodeDetails = r;
      });
      loadingOtherEpisode = false;
    });
  }

  @action
  Future<void> loadPrevEpisode() async {
    loadingOtherEpisode = true;

    final result =
        await detailsRepository.getPreviousEpisodeDetails(episodeDetails.id);

    runInAction(() {
      result.fold((l) {}, (r) {
        episodeDetails = r;
      });

      loadingOtherEpisode = false;
    });
  }

  @action
  void setWatchEpisodeId(String newEpisodeId) {
    watchEpisodeId = newEpisodeId;
  }

  @action
  void renderUpdatedEpisode(String id, double newStats) {
    if (episodeDetails.id == id) {
      episodeDetails = EpisodeDetails(
        animeId: episodeDetails.animeId,
        id: episodeDetails.id,
        imageHttpHeaders: episodeDetails.imageHttpHeaders,
        imageUrl: episodeDetails.imageUrl,
        label: episodeDetails.label,
        stats: newStats,
        url: episodeDetails.url,
        urlHd: episodeDetails.urlHd,
        urlFullHd: episodeDetails.urlFullHd,
      );
    }
  }

  @action
  void renderUpdatedFavorite(Anime anime, bool newValue) {
    if (recommendations != null && recommendations.length > 0) {
      int index =
          recommendations.indexWhere((element) => element.id == anime.id);

      if (index != -1) {
        final aux = recommendations[index];

        recommendations[index] = Anime(
            id: aux.id,
            imageHttpHeaders: aux.imageHttpHeaders,
            imageUrl: aux.imageUrl,
            title: aux.title,
            isFavorite: newValue);
      }
    }
  }

  @action
  Future<void> loadRecommendations() async {
    loadingRecommendations = true;
    loadingMoreRecommendations = false;

    final results = await browsingRepository.getRandomAnimes();

    results.fold(
        (l) => recommendationsError =
            "Não foi possível carregar as recomendações", (r) {
      recommendations.addAll(ObservableList<Anime>.of(r));
      loadingRecommendations = false;
      loadingMoreRecommendations = false;
    });
  }

  @action
  Future<void> loadMoreRecommendations() async {
    if (loadingMoreRecommendations) {
      return;
    }

    loadingMoreRecommendations = true;
    loadingRecommendations = false;

    final results = await browsingRepository.getRandomAnimes();

    results.fold((l) => {}, (r) {
      recommendations.addAll(ObservableList<Anime>.of(r));
      loadingRecommendations = false;
      loadingMoreRecommendations = false;
    });
  }
}
