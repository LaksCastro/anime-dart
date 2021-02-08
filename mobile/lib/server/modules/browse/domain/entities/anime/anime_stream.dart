import '../resource/resource_stream.dart';
import '../resource_types/video_stream.dart';
import 'anime_details.dart';

abstract class AnimeEpisodeStream extends ResourceStream<Set<VideoStream>> {
  final AnimeDetails context;

  AnimeEpisodeStream(
    String id, {
    Set<VideoStream> enjoy,
    this.context,
  }) : super(id, enjoy: enjoy);
}
