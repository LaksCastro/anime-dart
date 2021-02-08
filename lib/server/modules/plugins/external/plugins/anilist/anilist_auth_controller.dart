part of 'anilist.dart';

class AniListAuthController extends PluginAuthController {
  const AniListAuthController()
      : super('app.plugin.anilist.authcontroller', _authUseCaseHandlers);

  static const _authUseCaseHandlers = <Type, UseCase>{
    RequestOAuthToken: AniListRequestOAuthToken(),
    RequestOAuthCode: AniListRequestOAuthCode(),
  };
}
