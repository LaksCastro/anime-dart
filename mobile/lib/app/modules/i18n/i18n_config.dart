import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../cache/cache_manager.dart';

class I18nConfig {
  final String cacheKey;
  final CacheManager cacheManager;

  const I18nConfig({
    @required this.cacheManager,
    @required this.cacheKey,
  });
}
