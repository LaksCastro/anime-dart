import '../../enums/media_type.dart';
import '../resource/resource_details.dart';
import '../resource/resource_image.dart';
import '../resource/resource_title.dart';

abstract class AnimeDetails extends ResourceDetails {
  const AnimeDetails(
    String id, {
    ResourceTitle title,
    double rating,
    bool nsfw,
    String description,
    DateTime startDate,
    DateTime endDate,
    ResourceImage image,
  }) : super(
          id,
          title: title,
          rating: rating,
          nsfw: nsfw,
          description: description,
          startDate: startDate,
          endDate: endDate,
          image: image,
        );

  @override
  MediaType get mediaType => MediaType.video;
}
