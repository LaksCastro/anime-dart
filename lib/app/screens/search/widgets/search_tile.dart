import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:anime_dart/app/core/search/domain/entities/anime.dart';

class SearchTile extends StatelessWidget {
  final Anime anime;
  final String cardLabel;
  final void Function() onTap;
  final void Function() onTapFavorite;

  SearchTile({
    Key key,
    this.anime,
    this.cardLabel,
    this.onTap,
    this.onTapFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageWidth = 80;
    double imageHeight = 115;

    return GestureDetector(
        onTap: onTap,
        child: Stack(children: [
          Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              padding: EdgeInsets.all(10),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                    width: imageWidth,
                    height: imageHeight,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            httpHeaders: anime.imageHttpHeaders,
                            imageUrl: anime.imageUrl,
                            placeholder: (context, url) => Container(
                                width: imageWidth,
                                height: imageHeight,
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(.10)),
                            errorWidget: (context, url, error) => Container(
                                width: imageWidth,
                                height: imageHeight,
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondary
                                    .withOpacity(.10)
                                    .withOpacity(.60))))),
                Flexible(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(cardLabel,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                          fontSize: 12)),
                                ),
                                Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(anime.title,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            height: 1.5,
                                            fontSize: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                .fontSize)))
                              ])),
                    ]))
              ])),
          Positioned(
              child: GestureDetector(
                  onTap: onTapFavorite,
                  child: Container(
                      height: 85,
                      width: 85,
                      padding: EdgeInsets.only(top: 10, right: 10),
                      alignment: Alignment.topRight,
                      child: Icon(Icons.favorite,
                          color: anime.isFavorite
                              ? Theme.of(context).secondaryHeaderColor
                              : Theme.of(context).canvasColor))),
              right: 0,
              top: 0)
        ]));
  }
}
