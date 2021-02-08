import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../helpers/dto/enums/short_locale.dart';
import '../../../../browse/domain/entities/resource_types/image_stream.dart';
import '../../../../browse/domain/enums/media_type.dart';
import '../../../../browse/domain/enums/plugin_type.dart';

abstract class PluginInfo extends Equatable {
  final String displayName;
  final String shortName;
  final String key;
  final Set<ImageStream> brandImage;
  final Set<MediaType> supportedMediaTypes;
  final Set<PluginType> supportedTypes;
  final Set<ShortLocale> supportedLocales;
  final String id;

  const PluginInfo({
    @required this.displayName,
    @required this.brandImage,
    @required this.key,
    @required this.shortName,
    @required this.supportedMediaTypes,
    @required this.supportedTypes,
    @required this.supportedLocales,
  }) : id = '$key, $displayName, $shortName';

  @override
  List<Object> get props => [id, key, displayName, shortName];
}
