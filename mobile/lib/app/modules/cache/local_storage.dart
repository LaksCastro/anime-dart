import 'package:shared_preferences/shared_preferences.dart';

import 'cache_interface.dart';

class LocalStorage implements CacheInterface {
  static SharedPreferences _instance;

  @override
  Future<void> deleteAll() async {
    await _init();
    await _instance.clear();
  }

  @override
  Future<void> deleteKey(String key) async {
    await _init();
    await _instance.remove(key);
  }

  @override
  Future<Set<String>> getAll() async {
    await _init();
    return await _instance.getKeys();
  }

  @override
  Future<String> getKey(String key) async {
    await _init();
    return await _instance.getString(key);
  }

  @override
  Future<void> setKey(String key, String value) async {
    await _init();
    await _instance.setString(key, value);
  }

  Future<void> _init() async {
    _instance ??= await SharedPreferences.getInstance();
  }
}
