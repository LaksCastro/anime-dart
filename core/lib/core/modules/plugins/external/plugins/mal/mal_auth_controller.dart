part of 'mal.dart';

class MyAnimeListAuthController extends PluginAuthController {
  const MyAnimeListAuthController()
      : super('app.plugin.myanimelist.authcontroller', _authUseCaseHandlers);

  static const _authUseCaseHandlers = <Type, UseCase>{
    RequestOAuthToken: MyAnimeListRequestOAuthToken(),
    RequestOAuthCode: MyAnimeListRequestOAuthCode(),
  };
}
