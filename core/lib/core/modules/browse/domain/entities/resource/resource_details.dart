import '../../../../core/domain/entities/entity.dart';
import '../../enums/media_type.dart';
import 'resource_image.dart';
import 'resource_title.dart';

abstract class ResourceDetails extends Entity {
  final ResourceTitle title;
  final double rating;
  final bool nsfw;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final ResourceImage image;

  const ResourceDetails(
    String id, {
    this.title,
    this.rating,
    this.nsfw,
    this.description,
    this.startDate,
    this.endDate,
    this.image,
  }) : super(id);

  MediaType get mediaType;
}
