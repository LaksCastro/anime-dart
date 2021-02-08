part of 'anilist.dart';

/// [AniList] plugin implementation info/metadata
class AniListInfo extends PluginInfo {
  static const _supportedLocales = <ShortLocale>{
    ShortLocale.enUs,
  };
  static const _supportedMediaTypes = <MediaType>{
    MediaType.image,
    MediaType.video,
  };

  /// If a plugin offers a [PluginType.authentication] scope
  ///
  /// So he must implement one of [AuthUseCases] (see [/auth/domain/usecases])
  static const _supportedTypes = <PluginType>{
    PluginType.authentication,
    PluginType.data,
  };

  const AniListInfo()
      : super(
          displayName: 'AniList',
          brandImage: null,
          key: 'app.plugin.anilist.info',
          shortName: 'AniList',
          supportedLocales: _supportedLocales,
          supportedMediaTypes: _supportedMediaTypes,
          supportedTypes: _supportedTypes,
        );
}
