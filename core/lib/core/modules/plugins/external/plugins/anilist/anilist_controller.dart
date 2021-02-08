part of 'anilist.dart';

class AniListController extends PluginController {
  const AniListController()
      : super('app.plugin.anilist.controller', _useCaseHandlers);

  static const _useCaseHandlers = <Type, Map<MediaType, UseCase>>{
    SearchByText: {
      MediaType.video: AniListSearchAnimesByText(),
    },
  };
}
