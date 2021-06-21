import 'package:anime_dart/app/store/watch_episode_store.dart';
import 'package:anime_dart/app/setup.dart';
import 'package:anime_dart/app/store/central_store.dart';
import 'package:anime_dart/app/screens/player/player_screen.dart';
import 'package:anime_dart/app/constants/utils.dart';
import 'package:flutter/material.dart';

import 'package:anime_dart/app/core/details/domain/entities/episode_details.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class WatchModalScreen extends StatefulWidget {
  final String id;
  final List<EpisodeDetails> allEpisodes;
  final String title;

  const WatchModalScreen({
    Key key,
    @required this.title,
    @required this.id,
    @required this.allEpisodes,
  }) : super(key: key);

  @override
  _WatchModalScreenState createState() => _WatchModalScreenState();
}

class _WatchModalScreenState extends State<WatchModalScreen> {
  final localStore = WatchEpisodeStore();

  String _storeListenerKey;

  final _centralStore = getIt<CentralStore>();

  bool get _hasAllEpisodes => widget.allEpisodes != null;

  @override
  void initState() {
    super.initState();

    _storeListenerKey = _centralStore.addWatchEpisodeListener(localStore);

    localStore.setWatchEpisodeId(_hasAllEpisodes ? widget.id : widget.id);

    localStore.loadEpisode();
  }

  @override
  void dispose() {
    _centralStore.removeWatchEpisodeListener(_storeListenerKey);

    super.dispose();
  }

  Widget _buildButton(String label, {VoidCallback onTap, IconData iconData}) {
    return InkWell(
      highlightColor: Colors.grey.withOpacity(.04),
      splashColor: Colors.grey.withOpacity(.04),
      splashFactory: InkSplash.splashFactory,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          children: [
            Icon(
              iconData,
              color: Colors.grey.withOpacity(.2),
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
            Text(label),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      height: 100,
      color: Theme.of(context).dialogTheme.backgroundColor,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.hardEdge,
      child: Observer(
        builder: (_) => localStore.loadingWatchEpisode
            ? _buildLoadingIndicator()
            : ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      widget.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .color
                            .withOpacity(.5),
                      ),
                    ),
                  ),
                  if ((localStore.episodeDetails?.url ?? '').isNotEmpty)
                    _buildButton(
                      'Assistir normal',
                      iconData: Icons.play_arrow_outlined,
                      onTap: () =>
                          _openPlayerScreen(localStore.episodeDetails?.url),
                    ),
                  if ((localStore.episodeDetails?.urlHd ?? '').isNotEmpty)
                    _buildButton(
                      'Assistir HD',
                      iconData: Icons.play_arrow_outlined,
                      onTap: () =>
                          _openPlayerScreen(localStore.episodeDetails?.urlHd),
                    ),
                  if ((localStore.episodeDetails?.urlFullHd ?? '').isNotEmpty)
                    _buildButton(
                      'Assistir Full HD',
                      iconData: Icons.play_arrow_outlined,
                      onTap: () => _openPlayerScreen(
                          localStore.episodeDetails?.urlFullHd),
                    ),
                  if ((localStore.episodeDetails?.url ?? '').isNotEmpty)
                    _buildButton(
                      'Download normal',
                      iconData: Icons.download_outlined,
                      onTap: () =>
                          Utils.openUrl(localStore.episodeDetails?.url),
                    ),
                  if ((localStore.episodeDetails?.urlHd ?? '').isNotEmpty)
                    _buildButton(
                      'Download HD',
                      iconData: Icons.download_outlined,
                      onTap: () =>
                          Utils.openUrl(localStore.episodeDetails?.urlHd),
                    ),
                  if ((localStore.episodeDetails?.urlFullHd ?? '').isNotEmpty)
                    _buildButton(
                      'Download Full HD',
                      iconData: Icons.download_outlined,
                      onTap: () =>
                          Utils.openUrl(localStore.episodeDetails?.urlFullHd),
                    ),
                ],
              ),
      ),
    );
  }

  void _openPlayerScreen(String videoUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PlayerScreen(
          id: localStore.episodeDetails.id,
          url: videoUrl,
        ),
      ),
    );
  }
}
