import 'package:anime_dart/app/core/browsing/domain/repositories/browsing_repository.dart';
import 'package:anime_dart/app/core/details/domain/entities/anime_details.dart';
import 'package:anime_dart/app/core/details/domain/entities/episode_details.dart';
import 'package:anime_dart/app/core/details/domain/repository/details_repository.dart';
import 'package:anime_dart/app/core/favorites/domain/repositories/favorite_repository.dart';
import 'package:anime_dart/app/core/search/domain/entities/anime.dart';
import 'package:anime_dart/app/core/watched/domain/repository/watched_repository.dart';
import 'package:anime_dart/app/setup.dart';
import 'package:mobx/mobx.dart';
part 'anime_details_store.g.dart';

class AnimeDetailsStore = _AnimeDetailsStoreBase with _$AnimeDetailsStore;

abstract class _AnimeDetailsStoreBase with Store {
  final repository = getIt<BrowsingRepository>();
  final detailsRepository = getIt<DetailsRepository>();
  final favoritesRepository = getIt<FavoritesRepository>();
  final watchedRepository = getIt<WatchedRepository>();

  // ==========================
  //   ANIME DETAILS SCREEN STATE
  // ==========================
  @observable
  AnimeDetails animeDetails;

  @observable
  ObservableList<EpisodeDetails> episodesOfAnimeDetails;

  @observable
  String error;

  @observable
  String internalSearch = "";

  @observable
  var filteredEpisodes = ObservableList<EpisodeDetails>.of([]);

  @observable
  bool showSearch = false;

  @observable
  String animeId;

  @computed
  bool get searchMode => internalSearch != "";

  @computed
  bool get notFoundInternalSearch => searchMode && filteredEpisodes.length == 0;

  @computed
  bool get loading =>
      episodesOfAnimeDetails == null && animeDetails == null && error == null;

  @action
  Future<void> loadAnimeDetails(String animeId) async {
    final result = await detailsRepository.getAnimeDetails(animeId);
    final resultEps = await detailsRepository.getEpisodesOf(animeId);

    runInAction(() {
      result.fold((l) {
        error = "Não foi possível carregar os dados do anime, tente novamente";
        animeDetails = null;
        episodesOfAnimeDetails = null;
      }, (rAnime) {
        resultEps.fold((l) {
          error =
              "Não foi possível carregar os dados do anime, tente novamente";
          animeDetails = null;
          episodesOfAnimeDetails = null;
        }, (rEpisodes) {
          animeDetails = rAnime;
          episodesOfAnimeDetails = ObservableList<EpisodeDetails>.of(rEpisodes);
          error = null;
        });
      });
    });
  }

  @action
  showSearchField(bool yesOrNo) {
    showSearch = yesOrNo;
  }

  @action
  setInternalSearch(String keyword) {
    internalSearch = keyword;
  }

  @action
  closeSearchMode() {
    showSearchField(false);
    setInternalSearch("");
    filteredEpisodes = ObservableList<EpisodeDetails>.of([]);
  }

  @action
  filterEpisodes() {
    int length = episodesOfAnimeDetails.length;

    filteredEpisodes = ObservableList<EpisodeDetails>.of([]);

    for (int i = length - 1; i >= 0; i--) {
      final episode = episodesOfAnimeDetails[i];

      if (episode.label.contains(internalSearch)) {
        filteredEpisodes.add(episode);
      }
    }
  }

  @action
  Future<void> toggleFavorite() async {
    bool newValue = !animeDetails.isFavorite;

    final aux = animeDetails;

    final result = await favoritesRepository.setFavorite(
        Anime(
            id: aux.id,
            imageHttpHeaders: aux.imageHttpHeaders,
            imageUrl: aux.imageUrl,
            isFavorite: aux.isFavorite,
            title: aux.title),
        newValue);

    runInAction(() {
      result.fold((l) {
        return;
      }, (r) {
        animeDetails = AnimeDetails(
            isFavorite: newValue,
            genres: animeDetails.genres,
            id: animeDetails.id,
            imageHttpHeaders: animeDetails.imageHttpHeaders,
            imageUrl: animeDetails.imageUrl,
            synopsis: animeDetails.synopsis,
            title: animeDetails.title,
            year: animeDetails.year);
      });
    });
  }

  @action
  void renderUpdatedEpisode(String id, double newStats) {
    if (episodesOfAnimeDetails == null) {
      throw Exception("The id must be a valid String");
    }

    int index =
        episodesOfAnimeDetails.indexWhere((element) => element.id == id);

    int filteredIndex =
        filteredEpisodes.indexWhere((element) => element.id == id);

    if (index == -1) {
      return;
    }

    final aux = episodesOfAnimeDetails[index];

    episodesOfAnimeDetails[index] = EpisodeDetails(
      animeId: aux.animeId,
      id: aux.id,
      imageHttpHeaders: aux.imageHttpHeaders,
      imageUrl: aux.imageUrl,
      label: aux.label,
      stats: newStats,
      url: aux.url,
      urlHd: aux.urlHd,
      urlFullHd: aux.urlFullHd,
    );

    if (filteredIndex != null && filteredIndex != -1) {
      filteredEpisodes[filteredIndex] = episodesOfAnimeDetails[index];
    }
  }

  @action
  void renderUpdatedFavorite(Anime anime, bool newValue) {
    if (animeDetails.id != anime.id) {
      return;
    }

    if (episodesOfAnimeDetails == null) {
      throw Exception("The anime must be rendered to continue");
    }

    final aux = animeDetails;

    animeDetails = AnimeDetails(
      id: aux.id,
      imageHttpHeaders: aux.imageHttpHeaders,
      imageUrl: aux.imageUrl,
      title: aux.title,
      genres: aux.genres,
      isFavorite: newValue,
      synopsis: aux.synopsis,
      year: aux.year,
    );
  }
}
