import 'package:anime_dart/app/constants/utils.dart';
import 'package:anime_dart/app/setup.dart';
import 'package:anime_dart/app/store/central_store.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:video_player/video_player.dart';
part 'player_store.g.dart';

class PlayerStore = _PlayerStoreBase with _$PlayerStore;

abstract class _PlayerStoreBase with Store {
  final centralStore = getIt<CentralStore>();

// ===================
  // PLAYER STATE
// ===================
  @observable
  VideoPlayerController videoPlayerController;

  @observable
  double Function(double) getProgress;

  @observable
  double progress;

  @observable
  double seconds;

  @observable
  bool playerOk;

  @observable
  ChewieController chewieController;

  @observable
  String episodeUrlPlaying;

  @observable
  String episodeIdPlaying;

  @action
  void setEpisodeDetails(String id, String url) {
    episodeUrlPlaying = url;
    episodeIdPlaying = id;
  }

  @action
  Future<void> initializePlayerController() async {
    if (playerOk != null) {
      return;
    }

    playerOk = false;

    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    videoPlayerController = VideoPlayerController.network(episodeUrlPlaying);

    videoPlayerController.addListener(() {
      runInAction(() {
        seconds = videoPlayerController.value.position.inSeconds.toDouble();
      });
    });

    await videoPlayerController.initialize();
    await videoPlayerController.play();

    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: videoPlayerController.value.aspectRatio,
        autoPlay: true,
        looping: true,
        allowFullScreen: true,
        allowedScreenSleep: false,
        autoInitialize: true,
        fullScreenByDefault: true,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitDown,
          DeviceOrientation.portraitUp,
        ],
        systemOverlaysAfterFullScreen: [
          SystemUiOverlay.top,
          SystemUiOverlay.bottom
        ]);

    chewieController.enterFullScreen();
    chewieController.addListener(() {
      if (chewieController.isFullScreen) {
        SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
      } else {
        SystemChrome.setEnabledSystemUIOverlays(
            [SystemUiOverlay.bottom, SystemUiOverlay.top]);
      }
    });

    runInAction(() {
      getProgress = Utils.interpolate(
          xInterval: [0, videoPlayerController.value.duration.inSeconds * 0.8],
          yInterval: [0, 100]);

      playerOk = true;
    });
  }

  Future<void> exitPlayer() async {
    playerOk = false;

    progress = getProgress(seconds);

    centralStore?.setEpisodeStats(episodeIdPlaying, progress);

    await SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.bottom, SystemUiOverlay.top]);

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    await videoPlayerController?.dispose();
    chewieController?.dispose();

    videoPlayerController = null;
    getProgress = null;
    progress = null;
    seconds = null;
    playerOk = null;
  }
}