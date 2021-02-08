import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../helpers/errors/app_exception.dart';
import '../../../../browse/domain/errors/browse_errors.dart';
import '../../../../core/domain/entities/entity.dart';
import '../../../../core/domain/entities/usecase.dart';

abstract class PluginAuthController extends Entity {
  @protected
  final Map<Type, UseCase> authUseCaseHandlers;

  const PluginAuthController(String name, this.authUseCaseHandlers)
      : super(name);

  Future<Either<AppException, U>> call<U extends UseCase>() async {
    final useCase = authUseCaseHandlers[U];

    if (useCase == null) return Left(UnsupportedUseCaseException());

    return Right(useCase);
  }

  Future<bool> supports<U extends UseCase>() async {
    return await this<U>() is Right;
  }

  @override
  List<Object> get props => [id];
}
