import 'package:meta/meta.dart';

import '../cache/cache_manager.dart';

class ThemeConfig {
  final String cacheKey;
  final CacheManager cacheManager;

  const ThemeConfig({
    @required this.cacheManager,
    @required this.cacheKey,
  });
}
