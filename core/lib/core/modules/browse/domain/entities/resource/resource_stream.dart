import 'package:meta/meta.dart';

import '../../../../core/domain/entities/entity.dart';

abstract class ResourceStream<T extends Object> extends Entity {
  final T enjoy;

  const ResourceStream(
    String id, {
    @required this.enjoy,
  }) : super(id);
}
