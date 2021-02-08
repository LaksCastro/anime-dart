import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../../helpers/errors/app_exception.dart';
import '../../../../browse/domain/enums/media_type.dart';
import '../../../../browse/domain/errors/browse_errors.dart';
import '../../../../core/domain/entities/entity.dart';
import '../../../../core/domain/entities/usecase.dart';

abstract class PluginController extends Entity {
  @protected
  final Map<Type, Map<MediaType, UseCase>> useCaseHandlers;

  const PluginController(String name, this.useCaseHandlers) : super(name);

  Future<Either<AppException, U>> call<U extends UseCase>(
    MediaType mediaType,
  ) async {
    final useCase = useCaseHandlers[U];

    if (useCase == null) return Left(UnsupportedUseCaseException());

    final handler = useCase[mediaType];

    if (handler == null) return Left(UnsupportedMediaTypeException());

    return Right(handler);
  }

  Future<bool> supports<U extends UseCase>(MediaType mediaType) async {
    return await this(mediaType) is Right;
  }

  @override
  List<Object> get props => [id];
}
