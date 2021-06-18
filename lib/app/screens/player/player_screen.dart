import 'package:anime_dart/app/setup.dart';
import 'package:anime_dart/app/store/player_store.dart';
import 'package:flick_video_player/flick_video_player.dart'
    hide FlickLandscapeControls, FlickPortraitControls;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PlayerScreen extends StatefulWidget {
  final String id;
  final String url;

  const PlayerScreen({Key key, this.id, this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PlayerScreenState();
  }
}

class _PlayerScreenState extends State<PlayerScreen> {
  final playerStore = getIt<PlayerStore>();
  _PlayerScreenState();

  @override
  void initState() {
    super.initState();

    playerStore.setEpisodeDetails(widget.id, widget.url);

    if (playerStore.episodeUrlPlaying == null) {
      throw Exception("Is extremelly needed that the episode url is != null");
    }

    playerStore.initializePlayerController();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.bottom,
      SystemUiOverlay.top,
    ]);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    playerStore.exitPlayer();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromRGBO(15, 15, 25, 1),
      elevation: 0,
      child: Center(
        child: Observer(
          builder: (_) {
            return FlickVideoPlayer(
              flickManager: playerStore.flickManager,
              flickVideoWithControls: FlickVideoWithControls(
                videoFit: BoxFit.contain,
                controls: FlickLandscapeControls(),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FlickLandscapeControls extends StatelessWidget {
  const FlickLandscapeControls({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlickPortraitControls(
      fontSize: 14,
      iconSize: 30,
      progressBarSettings: FlickProgressBarSettings(
        height: 5,
      ),
    );
  }
}

/// Default portrait controls.
class FlickPortraitControls extends StatelessWidget {
  const FlickPortraitControls(
      {Key key,
      this.iconSize = 20,
      this.fontSize = 12,
      this.progressBarSettings})
      : super(key: key);

  /// Icon size.
  ///
  /// This size is used for all the player icons.
  final double iconSize;

  /// Font size.
  ///
  /// This size is used for all the text.
  final double fontSize;

  /// [FlickProgressBarSettings] settings.
  final FlickProgressBarSettings progressBarSettings;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: FlickShowControlsAction(
            child: FlickSeekVideoAction(
              child: Center(
                child: FlickVideoBuffer(
                  child: FlickAutoHideChild(
                    showIfVideoNotInitialized: false,
                    child: ClipOval(
                      child: Container(
                        color: Colors.grey.withOpacity(.5),
                        child: FlickPlayToggle(
                          size: 30,
                          color: Colors.black,
                          padding: EdgeInsets.all(12),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: FlickAutoHideChild(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(10.0),
                height: 75,
                color: Colors.black.withOpacity(.8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: FlickVideoProgressBar(
                        flickProgressBarSettings: progressBarSettings,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlickPlayToggle(
                          size: iconSize,
                        ),
                        SizedBox(
                          width: iconSize / 2,
                        ),
                        FlickSoundToggle(
                          size: iconSize,
                        ),
                        SizedBox(
                          width: iconSize / 2,
                        ),
                        Row(
                          children: <Widget>[
                            FlickCurrentPosition(
                              fontSize: fontSize,
                            ),
                            FlickAutoHideChild(
                              child: Text(
                                ' / ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: fontSize),
                              ),
                            ),
                            FlickTotalDuration(
                              fontSize: fontSize,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        FlickFullScreenToggle(
                          size: iconSize,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
