import 'package:app_utils/utils/list_utils.dart';
import 'package:app_utils/utils/string_utils.dart';
import 'package:dartz/dartz.dart';

import '../../../../helpers/errors/app_exception.dart';
import '../../../browse/domain/enums/media_type.dart';
import '../../../core/domain/entities/usecase.dart';
import '../../domain/entities/plugin/plugin.dart';
import '../../domain/entities/plugin/plugin_filter.dart';
import '../../domain/errors/plugin_errors.dart';
import '../../domain/repositories/search_plugins_repository.dart';
import '../plugins/anilist/anilist.dart';
import '../plugins/mal/mal.dart';

class LocalSearchPluginRepository extends SearchPluginRepository {
  static const _plugins = <Plugin>[
    MyAnimeListPlugin(),
    AniListPlugin(),
  ];

  const LocalSearchPluginRepository();

  @override
  Future<Either<AppException, List<Plugin>>> get plugins async {
    return Right(_plugins);
  }

  @override
  Future<Either<AppException, List<Plugin>>> filter(PluginFilter filter) async {
    final matches =
        _plugins.where((plugin) => _hasPluginMatch(plugin, filter)).toList();

    if (matches.isEmpty) return Left(NoPluginResults());

    return Right(matches);
  }

  @override
  Future<Either<AppException, List<Plugin>>> searchByText(String text) async {
    return await filter(PluginFilter(text: text));
  }

  @override
  Future<Either<AppException, List<Plugin>>> searchByUseCase<U extends UseCase>(
    MediaType mediaType,
  ) async {
    final supportedPlugins = <Plugin>[];

    for (final plugin in _plugins) {
      if (await plugin.controller.supports<U>(mediaType)) {
        supportedPlugins.add(plugin);
      }
    }

    if (supportedPlugins.isEmpty) return Left(NoPluginResults());

    return Right(supportedPlugins);
  }

  bool _hasPluginMatch(Plugin plugin, PluginFilter filter) {
    final text = filter.text != null ? normalizeString(filter.text) : null;
    final supportedMediaTypes = filter.supportedMediaTypes;
    final supportedTypes = filter.supportedTypes;

    final pluginInfo = plugin.info;

    final conditions = <bool>[
      text != null && text.isNotEmpty
          ? (hasMatch(plugin.id, text) ||
              hasMatch(plugin.info.shortName, text) ||
              hasMatch(plugin.info.displayName, text))
          : true,
      supportedMediaTypes != null && supportedMediaTypes.isNotEmpty
          ? hasIntersection(pluginInfo.supportedMediaTypes, supportedMediaTypes)
          : true,
      supportedTypes != null && supportedTypes.isNotEmpty
          ? hasIntersection(pluginInfo.supportedTypes, supportedTypes)
          : true,
    ];

    return conditions.every((condition) => condition);
  }
}
