import 'package:anime_dart/app/screens/anime_details/widgets/anime_details_header.dart';
import 'package:anime_dart/app/screens/anime_details/widgets/anime_details_tile.dart';
import 'package:anime_dart/app/setup.dart';
import 'package:anime_dart/app/store/anime_details_store.dart';
import 'package:anime_dart/app/store/central_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AnimeDetailsListWithHeader extends StatefulWidget {
  final String storeListenerKey;
  final String imageUrl;
  final String heroTag;

  const AnimeDetailsListWithHeader({
    Key key,
    this.storeListenerKey,
    this.imageUrl,
    this.heroTag,
  }) : super(key: key);

  @override
  _AnimeDetailsListWithHeaderState createState() =>
      _AnimeDetailsListWithHeaderState();
}

class _AnimeDetailsListWithHeaderState
    extends State<AnimeDetailsListWithHeader> {
  final centralStore = getIt<CentralStore>();

  String get _storeListenerKey => widget.storeListenerKey;
  AnimeDetailsStore localStore;

  @override
  void initState() {
    super.initState();

    localStore = centralStore.getAnimeDetailsListener(_storeListenerKey);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => localStore.loadAnimeDetails(localStore.animeDetails.id),
      child: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                AnimeDetailsHeader(
                  storeListenerKey: _storeListenerKey,
                  imageUrl: widget.imageUrl,
                  heroTag: widget.heroTag,
                ),
              ],
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(bottom: 20)),
          Observer(
            builder: (_) => SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, i) {
                  if (localStore?.episodesOfAnimeDetails != null) {
                    final episode = localStore.episodesOfAnimeDetails[i];

                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: AnimeDetailsTile(
                        episode: episode,
                        allEpisodes: localStore.episodesOfAnimeDetails,
                        initialIndex: i,
                      ),
                    );
                  }

                  return Center(child: CircularProgressIndicator());
                },
                childCount: localStore.episodesOfAnimeDetails?.length ?? 1,
              ),
            ),
          ),
          SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),
    );
  }
}
