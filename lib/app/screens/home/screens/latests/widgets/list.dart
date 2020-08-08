import 'package:anime_dart/app/core/browsing/domain/entities/episode.dart';
import 'package:anime_dart/app/screens/home/screens/latests/widgets/tile.dart';
import 'package:flutter/material.dart';

class LatestsList extends StatelessWidget {
  final List<Episode> episodes;
  final String cardLabel;
  final Future<void> Function() onRefresh;
  final void Function() Function(Episode episode) linkBuilder;

  LatestsList(
      {@required this.episodes,
      @required this.cardLabel,
      @required this.onRefresh,
      @required this.linkBuilder});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        color: Theme.of(context).colorScheme.onSecondary,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onRefresh: this.onRefresh,
        child: ListView.separated(
            separatorBuilder: (_, __) =>
                Divider(color: Colors.transparent, height: 10),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            itemCount: episodes.length,
            itemBuilder: (BuildContext context, int index) {
              final episode = episodes[index];

              return LatestsTile(
                  episode: episode,
                  cardLabel: cardLabel,
                  onTap: linkBuilder(episode));
            }));
  }
}
