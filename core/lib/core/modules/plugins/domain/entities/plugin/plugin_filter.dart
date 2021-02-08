import 'package:equatable/equatable.dart';

import '../../../../browse/domain/enums/media_type.dart';
import '../../../../browse/domain/enums/plugin_type.dart';

class PluginFilter extends Equatable {
  final String text;
  final Set<MediaType> supportedMediaTypes;
  final Set<PluginType> supportedTypes;

  const PluginFilter({
    this.text,
    this.supportedMediaTypes,
    this.supportedTypes,
  });

  @override
  List<Object> get props => [
        text,
        if (supportedMediaTypes != null) ...supportedMediaTypes,
        if (supportedMediaTypes != null) ...supportedTypes,
      ];
}
