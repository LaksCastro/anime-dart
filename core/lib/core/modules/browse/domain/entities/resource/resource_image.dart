import '../../../../core/domain/entities/entity.dart';
import '../resource_types/image_stream.dart';

class ResourceImage extends Entity {
  final ImageStream bannerImage;
  final Set<ImageStream> coverImage;

  const ResourceImage(
    String id, {
    this.bannerImage,
    this.coverImage,
  }) : super(id);

  @override
  List<Object> get props => [bannerImage, ...coverImage];
}
