import 'dart:async';

import 'package:anime_dart/app/core/search/domain/entities/anime.dart';
import 'package:anime_dart/app/screens/anime_details/widgets/anime_details_list.dart';
import 'package:anime_dart/app/screens/anime_details/widgets/anime_details_list_with_header.dart';
import 'package:anime_dart/app/setup.dart';
import 'package:anime_dart/app/store/anime_details_store.dart';
import 'package:anime_dart/app/store/central_store.dart';
import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class AnimeDetailsScreen extends StatefulWidget {
  final String animeId;
  final String imageUrl;
  final String heroTag;

  const AnimeDetailsScreen({this.animeId, this.imageUrl, this.heroTag});

  @override
  _AnimeDetailsScreenState createState() => _AnimeDetailsScreenState();
}

class _AnimeDetailsScreenState extends State<AnimeDetailsScreen> {
  String get _animeId => widget.animeId;

  String storeListenerKey;
  AnimeDetailsStore localStore = AnimeDetailsStore();
  final centralStore = getIt<CentralStore>();

  final searchQuery = TextEditingController();
  Timer debounce;

  bool get _hasImage => widget.imageUrl != null;

  void _onSearchChanged() {
    if (debounce?.isActive ?? false) {
      debounce.cancel();
    }

    debounce = Timer(Duration(milliseconds: 500), () {
      final text = searchQuery.text;

      if (text == localStore.internalSearch) {
        return;
      }

      localStore.setInternalSearch(text);
      localStore.filterEpisodes();
    });
  }

  void _enableSearchMode() {
    localStore.showSearchField(true);
  }

  void _closeSearchMode() {
    searchQuery.clear();
    localStore.closeSearchMode();
  }

  Future<bool> _preventAcidentalPop() async {
    _closeSearchMode();
    return false;
  }

  @override
  void initState() {
    super.initState();

    storeListenerKey = centralStore.addAnimeDetailsListener(localStore);

    localStore.loadAnimeDetails(_animeId);

    searchQuery.addListener(_onSearchChanged);
  }

  void dispose() {
    centralStore.removeAnimeDetailsListener(storeListenerKey);
    searchQuery?.removeListener(_onSearchChanged);
    searchQuery?.dispose();
    debounce?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(
          builder: (_) {
            if (localStore.loading) {
              return Text('Carregando...');
            }

            if (localStore.error != null) {
              return Text('Oooops...');
            }

            if (localStore.showSearch) {
              return Row(
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      style: TextStyle(
                        color: Theme.of(context).primaryIconTheme.color,
                      ),
                      cursorColor: Theme.of(context).primaryIconTheme.color,
                      decoration: InputDecoration.collapsed(
                        hintStyle: TextStyle(
                          color: Theme.of(context)
                              .primaryIconTheme
                              .color
                              .withOpacity(0.5),
                        ),
                        hintText: 'Digite o número do episódio',
                      ),
                      controller: searchQuery,
                    ),
                  ),
                  GestureDetector(
                    onTap: _closeSearchMode,
                    child: Container(
                      height: 40,
                      width: 50,
                      child: Icon(Icons.close),
                      alignment: Alignment.centerRight,
                    ),
                  )
                ],
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(localStore.animeDetails.title),
                ),
                GestureDetector(
                  onTap: _enableSearchMode,
                  child: Container(
                    height: 40,
                    width: 50,
                    child: Icon(Icons.search),
                    alignment: Alignment.centerRight,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      body: Observer(
        builder: (_) {
          if (localStore.loading && !_hasImage) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (localStore.error != null) {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(30),
              child: Text(
                'Ocorreu um erro ao carregar os episódios deste anime, tente novamente!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 1.5,
                ),
              ),
            );
          }

          if (!localStore.searchMode && !localStore.showSearch) {
            return AnimeDetailsListWithHeader(
              storeListenerKey: storeListenerKey,
              imageUrl: widget.imageUrl,
              heroTag: widget.heroTag,
            );
          }

          if (localStore.searchMode) {
            if (localStore.notFoundInternalSearch) {
              return WillPopScope(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      'Não foi posível encontrar o episódio especificado',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                onWillPop: _preventAcidentalPop,
              );
            }

            return WillPopScope(
              child: AnimeDetailsList(storeListenerKey: storeListenerKey),
              onWillPop: _preventAcidentalPop,
            );
          } else {
            return WillPopScope(
              child: AnimeDetailsList(storeListenerKey: storeListenerKey),
              onWillPop: _preventAcidentalPop,
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).cardColor,
        onPressed: () {
          if (localStore.loading || localStore.error != null) {
            return;
          }

          final aux = localStore.animeDetails;

          centralStore.setEpisodeFavorite(
            Anime(
              id: aux.id,
              imageHttpHeaders: aux.imageHttpHeaders,
              imageUrl: aux.imageUrl,
              isFavorite: aux.isFavorite,
              title: aux.title,
            ),
            !localStore.animeDetails.isFavorite,
          );
        },
        child: Observer(
          builder: (_) {
            Color fill = Theme.of(context).textTheme.bodyText1.color;

            if (localStore.loading || localStore.error != null) {
              return Icon(
                OMIcons.helpOutline,
                color: fill.withOpacity(
                  0.3,
                ),
              );
            }

            if (localStore.animeDetails.isFavorite) {
              return Icon(Icons.favorite, color: fill);
            }

            return Icon(OMIcons.favoriteBorder, color: fill);
          },
        ),
      ),
    );
  }
}
