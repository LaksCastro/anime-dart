import 'media_stream.dart';

class VideoStream extends MediaStream {
  const VideoStream({
    String displayName,
    String url,
    int qualityLevel,
  }) : super(
          displayName: displayName,
          qualityLevel: qualityLevel,
          url: url,
        );

  @override
  List<Object> get props => [id, displayName, url];
}
