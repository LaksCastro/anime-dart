part of 'mal.dart';

class MyAnimeListInfo extends PluginInfo {
  static const _supportedLocales = <ShortLocale>{
    ShortLocale.enUs,
  };
  static const _supportedMediaTypes = <MediaType>{
    MediaType.image,
    MediaType.video,
  };
  static const _supportedTypes = <PluginType>{
    PluginType.authentication,
    PluginType.data,
  };

  const MyAnimeListInfo()
      : super(
          displayName: 'MyAnimeList',
          brandImage: null,
          key: 'app.plugin.myanimelist.info',
          shortName: 'MAL',
          supportedLocales: _supportedLocales,
          supportedMediaTypes: _supportedMediaTypes,
          supportedTypes: _supportedTypes,
        );
}
