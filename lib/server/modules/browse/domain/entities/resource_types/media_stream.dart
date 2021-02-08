import '../../../../core/domain/entities/entity.dart';

abstract class MediaStream extends Entity {
  final String displayName;
  final String url;
  final int qualityLevel;

  const MediaStream({
    this.displayName,
    this.url,
    this.qualityLevel,
  }) : super('$displayName$url');

  @override
  List<Object> get props => [id, displayName, url];
}
