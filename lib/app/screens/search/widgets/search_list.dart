import 'package:anime_dart/app/core/search/domain/entities/anime.dart';
import 'package:anime_dart/app/screens/anime_details/anime_details_screen.dart';
import 'package:anime_dart/app/setup.dart';
import 'package:anime_dart/app/store/central_store.dart';
import 'package:anime_dart/app/store/search_store.dart';
import 'package:anime_dart/app/widgets/resource_tile/resource_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SearchList extends StatefulWidget {
  final String storeListenerKey;
  SearchList({Key key, this.storeListenerKey}) : super(key: key);

  @override
  _SearchListState createState() =>
      _SearchListState(storeListenerKey: storeListenerKey);
}

class _SearchListState extends State<SearchList> {
  String storeListenerKey;
  SearchStore localStore;
  final centralStore = getIt<CentralStore>();

  _SearchListState({@required this.storeListenerKey});

  @override
  void initState() {
    super.initState();

    localStore = centralStore.getSearchListener(storeListenerKey);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).colorScheme.onSecondary,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      onRefresh: localStore.loadResults,
      child: Observer(
        builder: (_) {
          return ListView.separated(
            separatorBuilder: (_, __) =>
                Divider(color: Colors.transparent, height: 10),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            itemCount: localStore.results.length,
            itemBuilder: (BuildContext context, int index) {
              final anime = localStore.results[index];

              final heroTag = '${anime.imageUrl}${anime.id}$index';

              void onTap() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AnimeDetailsScreen(
                      animeId: anime.id,
                      imageUrl: anime.imageUrl,
                      heroTag: heroTag,
                    ),
                  ),
                );
              }

              void onTapFavorite() {
                centralStore.setEpisodeFavorite(
                  Anime(
                    id: anime.id,
                    imageHttpHeaders: anime.imageHttpHeaders,
                    imageUrl: anime.imageUrl,
                    isFavorite: anime.isFavorite,
                    title: anime.title,
                  ),
                  !anime.isFavorite,
                );
              }

              return ResourceTile(
                title: anime.title,
                cardLabel: "RESULTADOS",
                onTap: onTap,
                onTopRightIconTap: onTapFavorite,
                topRightIcon:
                    ResourceTile.favoriteIcon(context, anime.isFavorite),
                imageUrl: anime.imageUrl,
                heroTag: heroTag,
              );
            },
          );
        },
      ),
    );
  }
}
