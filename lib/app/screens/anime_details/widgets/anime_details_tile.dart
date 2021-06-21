import 'package:anime_dart/app/screens/watch_modal/watch_modal_screen.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

import 'package:anime_dart/app/core/details/domain/entities/episode_details.dart';

class AnimeDetailsTile extends StatefulWidget {
  final EpisodeDetails episode;
  final List<EpisodeDetails> allEpisodes;
  final int initialIndex;

  AnimeDetailsTile({
    Key key,
    @required this.episode,
    @required this.allEpisodes,
    @required this.initialIndex,
  }) : super(key: key);

  @override
  _AnimeDetailsTileState createState() => _AnimeDetailsTileState();
}

class _AnimeDetailsTileState extends State<AnimeDetailsTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showDialog<void>(
          context: context,
          builder: (_) {
            return WatchModalScreen(
              allEpisodes: widget.allEpisodes,
              id: widget.episode.id,
              title: widget.episode.label,
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border(
            left: BorderSide(
              width: 5,
              color: Color.lerp(
                Colors.red,
                Colors.green,
                widget.episode.stats / 100,
              ),
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          title: Text(
            widget.episode.label,
            style: TextStyle(
              height: 1.5,
            ),
          ),
          leading: Icon(
            OMIcons.playArrow,
            color: Theme.of(context).textTheme.bodyText1.color.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
