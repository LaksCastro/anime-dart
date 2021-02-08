abstract class CacheInterface {
  Future<void> deleteAll();
  Future<void> deleteKey(String key);
  Future<Set<String>> getAll();
  Future<String> getKey(String key);
  Future<void> setKey(String key, String value);
}
