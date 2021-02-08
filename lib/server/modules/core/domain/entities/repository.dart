import 'package:dartz/dartz.dart';

import 'entity.dart';

abstract class Repository extends Entity {
  const Repository(String name) : super(name);

  @override
  List<Object> get props => [id];
}
