import 'package:anime_dart/app/core/favorites/infra/data_sources/favorites_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsFavoritesDataSource implements FavoritesDataSource {
  final _favoriteListKey = "anime__dart__application__favorites__animes";
  final _favoritePrefix = "anime__dart__application__favorites__prefix";
  SharedPreferences _prefs;

  String _getFavoriteKey(String id) {
    return _favoritePrefix + id;
  }

  Future<SharedPreferences> _getPrefs() async {
    if (_prefs != null) {
      return _prefs;
    }

    _prefs = await SharedPreferences.getInstance();

    return _prefs;
  }

  @override
  Future<bool> isFavorite(String id) async {
    try {
      final prefs = await _getPrefs();

      final favorite = prefs.getBool(_getFavoriteKey(id)) ?? false;

      return favorite;
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<void> setFavorite(String id, bool newValue) async {
    try {
      final prefs = await _getPrefs();

      prefs.setBool(_getFavoriteKey(id), newValue);

      final favoritesList = prefs.getStringList(_favoriteListKey) ?? <String>[];

      int index = favoritesList.indexOf(id);

      if (newValue) {
        if (index == -1) {
          favoritesList.insert(0, id);
        }
      } else {
        if (index != -1) {
          favoritesList.removeAt(index);
        }
      }

      prefs.setStringList(_favoriteListKey, favoritesList);
    } catch (e) {
      throw e;
    }
  }
}
