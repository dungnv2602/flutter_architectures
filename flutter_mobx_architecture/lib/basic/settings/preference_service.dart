import 'package:shared_preferences/shared_preferences.dart';

const String _useDarkModeKey = 'useDarkMode';

class PreferenceService {
  final SharedPreferences _sharedPreferences;

  PreferenceService(this._sharedPreferences);

  set useDarkMode(bool useDarkMode) {
    _sharedPreferences.setBool(_useDarkModeKey, useDarkMode);
  }

  bool get useDarkMode => _sharedPreferences.getBool(_useDarkModeKey) ?? false;
}
