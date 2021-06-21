import 'package:anime_dart/app/core/search/domain/entities/anime.dart';
import 'package:anime_dart/app/screens/anime_details/anime_details_screen.dart';
import 'package:anime_dart/app/setup.dart';
import 'package:anime_dart/app/store/central_store.dart';
import 'package:anime_dart/app/store/home_store.dart';
import 'package:anime_dart/app/widgets/resource_tile/resource_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FavoritesList extends StatefulWidget {
  FavoritesList({Key key}) : super(key: key);

  @override
  _FavoritesListState createState() => _FavoritesListState();
}

class _FavoritesListState extends State<FavoritesList> {
  final homeStore = getIt<HomeStore>();
  final centralStore = getIt<CentralStore>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).colorScheme.onSecondary,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      onRefresh: homeStore.loadFavorites,
      child: Observer(
        builder: (_) {
          return ListView.separated(
            separatorBuilder: (_, __) =>
                Divider(color: Colors.transparent, height: 10),
            padding: EdgeInsets.only(top: 20, bottom: 85),
            itemCount: homeStore.favorites.length,
            itemBuilder: (BuildContext context, int index) {
              final anime = homeStore.favorites[index];

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
                imageHttpHeaders: anime.imageHttpHeaders,
                imageUrl: anime.imageUrl,
                onTopRightIconTap: onTapFavorite,
                title: anime.title,
                cardLabel: "FAVORITOS",
                topRightIcon: ResourceTile.favoriteIcon(
                  context,
                  anime.isFavorite,
                ),
                onTap: onTap,
                heroTag: heroTag,
              );
            },
          );
        },
      ),
    );
  }
}
