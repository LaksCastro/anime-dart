import 'package:anime_dart/app/core/search/domain/entities/anime.dart';
import 'package:anime_dart/app/screens/anime_details/anime_details_screen.dart';
import 'package:anime_dart/app/setup.dart';
import 'package:anime_dart/app/store/category_store.dart';
import 'package:anime_dart/app/store/central_store.dart';
import 'package:anime_dart/app/widgets/resource_tile/resource_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CategoryList extends StatefulWidget {
  final String query;
  final String label;

  CategoryList({
    Key key,
    this.query,
    this.label,
  }) : super(key: key);

  @override
  _CategoryListState createState() =>
      _CategoryListState(label: label, query: query);
}

class _CategoryListState extends State<CategoryList> {
  final String label;
  final String query;
  String storeListenerKey;

  final centralStore = getIt<CentralStore>();
  final localStore = CategoryStore();

  _CategoryListState({this.label, this.query});

  @override
  void initState() {
    super.initState();

    storeListenerKey = centralStore.addCategoryListener(localStore);
    localStore.loadResults(query);
  }

  @override
  void dispose() {
    centralStore.removeCategoryListener(storeListenerKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(label),
      ),
      body: RefreshIndicator(
        color: Theme.of(context).colorScheme.onSecondary,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onRefresh: () => localStore.loadResults(query),
        child: Observer(
          builder: (_) {
            if (localStore.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (localStore.error != null) {
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        localStore.error,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 1.5,
                        ),
                      ),
                    ),
                    FlatButton(
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed: () => localStore.loadResults(query),
                      child: Text("Tentar novamente"),
                    )
                  ],
                ),
              );
            }
            return ListView.separated(
              separatorBuilder: (_, __) => Divider(
                color: Colors.transparent,
                height: 10,
              ),
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
                  imageHttpHeaders: anime.imageHttpHeaders,
                  imageUrl: anime.imageUrl,
                  onTopRightIconTap: onTapFavorite,
                  title: anime.title,
                  cardLabel: label,
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
      ),
    );
  }
}
