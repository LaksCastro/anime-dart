import 'package:meta/meta.dart';

import '../../../../core/domain/entities/entity.dart';

abstract class ResourceCategory extends Entity {
  final String displayName;
  final String key;
  final String description;
  final bool nfsw;

  const ResourceCategory(
    String id, {
    @required this.displayName,
    @required this.key,
    this.description,
    this.nfsw,
  }) : super(id);

  @override
  List<Object> get props => [
        id,
        displayName,
        key,
        description,
        nfsw,
      ];
}
