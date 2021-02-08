import 'cache_interface.dart';

class CacheManager implements CacheInterface {
  final CacheInterface implementation;

  const CacheManager(this.implementation);

  @override
  Future<void> deleteAll() async {
    return await implementation.deleteAll();
  }

  @override
  Future<void> deleteKey(String key) async {
    return await implementation.deleteKey(key);
  }

  @override
  Future<Set<String>> getAll() async {
    return await implementation.getAll();
  }

  @override
  Future<String> getKey(String key) async {
    return await implementation.getKey(key);
  }

  @override
  Future<void> setKey(String key, String value) async {
    return await implementation.setKey(key, value);
  }
}
