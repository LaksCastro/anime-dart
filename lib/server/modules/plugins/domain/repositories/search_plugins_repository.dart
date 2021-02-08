import 'package:dartz/dartz.dart';

import '../../../../helpers/errors/app_exception.dart';
import '../../../browse/domain/enums/media_type.dart';
import '../../../core/domain/entities/repository.dart';
import '../../../core/domain/entities/usecase.dart';
import '../entities/plugin/plugin.dart';
import '../entities/plugin/plugin_filter.dart';

abstract class SearchPluginRepository extends Repository {
  const SearchPluginRepository() : super('app.repository.searchplugin');

  Future<Either<AppException, List<Plugin>>> get plugins;
  Future<Either<AppException, List<Plugin>>> searchByText(String text);
  Future<Either<AppException, List<Plugin>>> filter(PluginFilter filter);
  Future<Either<AppException, List<Plugin>>> searchByUseCase<U extends UseCase>(
    MediaType mediaType,
  );
}
