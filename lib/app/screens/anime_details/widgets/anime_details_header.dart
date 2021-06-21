import 'package:anime_dart/app/setup.dart';
import 'package:anime_dart/app/store/anime_details_store.dart';
import 'package:anime_dart/app/store/central_store.dart';
import 'package:anime_dart/app/store/theme_store.dart';
import 'package:anime_dart/app/widgets/text_placeholder/text_placeholder.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AnimeDetailsHeader extends StatefulWidget {
  final String storeListenerKey;
  final String imageUrl;
  final String heroTag;

  const AnimeDetailsHeader({
    Key key,
    this.storeListenerKey,
    this.imageUrl,
    this.heroTag,
  }) : super(key: key);

  @override
  _AnimeDetailsHeaderState createState() => _AnimeDetailsHeaderState();
}

class _AnimeDetailsHeaderState extends State<AnimeDetailsHeader> {
  String get _storeListenerKey => widget.storeListenerKey;
  final _centralStore = getIt<CentralStore>();
  final _themeStore = getIt<ThemeStore>();

  AnimeDetailsStore localStore;

  @override
  void initState() {
    super.initState();

    localStore = _centralStore.getAnimeDetailsListener(_storeListenerKey);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).cardColor),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, left: 20),
                width: 140,
                height: 200,
                child: Hero(
                  tag: widget.heroTag,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      httpHeaders: localStore.animeDetails?.imageHttpHeaders,
                      imageUrl:
                          widget.imageUrl ?? localStore.animeDetails?.imageUrl,
                      placeholder: (context, url) => Container(
                        width: 140,
                        height: 200,
                        color: Colors.purple.withOpacity(.10),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 140,
                        height: 200,
                        color: Colors.black.withOpacity(.60),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              top: 30,
                              left: 10,
                              right: 10,
                            ),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: localStore.animeDetails?.year != null
                                ? Text(
                                    localStore.animeDetails.year,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  )
                                : TextPlaceholder(),
                          ),
                          Observer(
                            builder: (context) {
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary
                                      .withOpacity(0.05),
                                  border: Border(
                                    left: BorderSide(
                                      color: _themeStore.isDarkTheme
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                      style: BorderStyle.solid,
                                      width: 2,
                                    ),
                                  ),
                                ),
                                margin: EdgeInsets.only(top: 10),
                                padding: EdgeInsets.only(
                                  top: 20,
                                  bottom: 20,
                                  left: 10,
                                  right: 10,
                                ),
                                child: localStore.animeDetails?.title != null
                                    ? Text(
                                        localStore.animeDetails.title,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              .fontSize,
                                        ),
                                      )
                                    : TextPlaceholder(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20)
                .copyWith(bottom: 0),
            alignment: Alignment.centerLeft,
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.start,
              runSpacing: 0,
              alignment: WrapAlignment.start,
              children: [
                for (final genre in localStore.animeDetails?.genres ?? [])
                  Container(
                    margin: EdgeInsets.only(right: 5, bottom: 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.all(5),
                    child: Text(
                      genre,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  )
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 20)
                .copyWith(top: 0, bottom: 20),
            child: Text(
              localStore.animeDetails?.synopsis ?? '',
              style: TextStyle(height: 2),
            ),
          ),
        ],
      ),
    );
  }
}
