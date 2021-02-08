import 'package:meta/meta.dart';

import 'media_stream.dart';

class ImageStream extends MediaStream {
  final double width;
  final double height;

  const ImageStream({
    String displayName,
    @required String url,
    int qualityLevel,
    this.height,
    this.width,
  }) : super(
          displayName: displayName,
          qualityLevel: qualityLevel,
          url: url,
        );

  @override
  List<Object> get props => [id, displayName, url];
}
