import 'media_stream.dart';

class AudioStream extends MediaStream {
  const AudioStream({
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
