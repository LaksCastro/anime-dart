part of 'mal.dart';

class MyAnimeListController extends PluginController {
  const MyAnimeListController()
      : super('app.plugin.myanimelist.controller', _useCaseHandlers);

  static const _useCaseHandlers = <Type, Map<MediaType, UseCase>>{
    SearchByText: {
      MediaType.video: MyAnimeListSearchAnimesByText(),
    },
  };
}
