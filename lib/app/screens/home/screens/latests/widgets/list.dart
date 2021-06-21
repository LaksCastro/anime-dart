import 'package:anime_dart/app/screens/anime_details/anime_details_screen.dart';
import 'package:anime_dart/app/screens/watch_modal/watch_modal_screen.dart';
import 'package:anime_dart/app/setup.dart';
import 'package:anime_dart/app/store/central_store.dart';
import 'package:anime_dart/app/store/home_store.dart';
import 'package:anime_dart/app/widgets/resource_tile/resource_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LatestEpisodes extends StatefulWidget {
  const LatestEpisodes({Key key}) : super(key: key);

  @override
  _LatestEpisodesState createState() => _LatestEpisodesState();
}

class _LatestEpisodesState extends State<LatestEpisodes> {
  final homeStore = getIt<HomeStore>();
  final centralStore = getIt<CentralStore>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).colorScheme.onSecondary,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      onRefresh: homeStore.loadLatests,
      child: Observer(
        builder: (_) {
          return ListView.separated(
            separatorBuilder: (_, __) =>
                Divider(color: Colors.transparent, height: 10),
            padding: EdgeInsets.only(top: 20, bottom: 85),
            itemCount: homeStore.latests.length,
            itemBuilder: (BuildContext context, int index) {
              final episode = homeStore.latests[index];

              final heroTag = '${episode.imageUrl}${episode.animeId}$index';

              void onTap() {
                showDialog(
                  context: context,
                  builder: (_) => WatchModalScreen(
                    id: episode.id,
                    allEpisodes: [],
                    title: episode.label,
                  ),
                );
              }

              void onTapBookMark() {
                centralStore.setEpisodeStats(
                  episode.id,
                  episode.stats < 10 ? 100 : 0,
                );
              }

              void onLongPress() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AnimeDetailsScreen(
                      animeId: episode.animeId,
                      imageUrl: episode.imageUrl,
                      heroTag: heroTag,
                    ),
                  ),
                );
              }

              return ResourceTile(
                imageHttpHeaders: episode.imageHttpHeaders,
                imageUrl: episode.imageUrl,
                onTopRightIconTap: onTapBookMark,
                onLongPress: onLongPress,
                title: episode.label,
                cardLabel: 'LANÇAMENTOS',
                topRightIcon: ResourceTile.bookMarkIcon(
                  context,
                  episode.stats,
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
