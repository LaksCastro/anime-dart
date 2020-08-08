import 'package:anime_dart/app/setup.dart';
import 'package:anime_dart/app/store/central_store.dart';
import 'package:anime_dart/app/store/watch_episode_store.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class WatchEpisodeHeader extends StatefulWidget {
  final String storeListenerKey;

  WatchEpisodeHeader({Key key, this.storeListenerKey}) : super(key: key);

  @override
  _WatchEpisodeHeaderState createState() =>
      _WatchEpisodeHeaderState(storeListenerKey: storeListenerKey);
}

class _WatchEpisodeHeaderState extends State<WatchEpisodeHeader> {
  final String storeListenerKey;
  final centralStore = getIt<CentralStore>();
  WatchEpisodeStore localStore;

  _WatchEpisodeHeaderState({this.storeListenerKey}) {
    if (storeListenerKey == null) {
      throw Exception("The store key must be a valid String");
    }
    localStore = centralStore.getWatchEpisodeListener(storeListenerKey);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).cardColor,
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
        child: Column(children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
                width: 140,
                height: 200,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        httpHeaders: localStore.episodeDetails.imageHttpHeaders,
                        imageUrl: localStore.episodeDetails.imageUrl,
                        placeholder: (context, url) => Container(
                            width: 140,
                            height: 200,
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(.30)),
                        errorWidget: (context, url, error) => Container(
                            width: 140,
                            height: 200,
                            color: Theme.of(context)
                                .colorScheme
                                .secondary
                                .withOpacity(.90))))),
            Flexible(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Container(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text("EPISÓDIO",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                        ),
                        Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(0.05),
                                border: Border(
                                    left: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                        style: BorderStyle.solid,
                                        width: 2))),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.only(
                                top: 20, bottom: 20, left: 10, right: 10),
                            child: Observer(builder: (_) {
                              return Text(
                                  localStore.episodeDetails.label +
                                      " - ${localStore.episodeDetails.stats.toInt()}%",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      height: 1.5,
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .fontSize));
                            })),
                      ])),
                ]))
          ]),
          Container(
              padding: EdgeInsets.only(right: 20),
              child: Row(children: [
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          if (localStore.loadingOtherEpisode) {
                            return;
                          }

                          localStore.loadPrevEpisode();
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            margin: EdgeInsets.only(top: 10, right: 2.5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryVariant),
                            alignment: Alignment.center,
                            child: Text("PREV",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary))))),
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          if (localStore.loadingOtherEpisode) {
                            return;
                          }

                          localStore.loadNextEpisode();
                        },
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            margin: EdgeInsets.only(top: 10, left: 2.5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Theme.of(context).colorScheme.secondary),
                            alignment: Alignment.center,
                            child: Text("NEXT",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary)))))
              ]))
        ]));
  }
}
