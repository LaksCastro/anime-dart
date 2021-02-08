import 'package:dartz/dartz.dart';

import '../../../../helpers/errors/app_exception.dart';
import 'entity.dart';

abstract class UseCase<I, O> extends Entity {
  const UseCase(String name) : super(name);

  Future<Either<AppException, O>> call(I input);

  @override
  List<Object> get props => [id];
}
