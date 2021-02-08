import '../resource/resource_stream.dart';
import '../resource_types/image_stream.dart';

abstract class MangaStream extends ResourceStream<Set<ImageStream>> {
  MangaStream(
    String id, {
    Set<ImageStream> enjoy,
  }) : super(id, enjoy: enjoy);
}
