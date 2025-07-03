

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String offlineKey = 'isOffline';
  static const String darkThemeKey = 'isDarkTheme';
  static const String languageKey = 'language';

  Future<void> saveOffline(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(offlineKey, value);
  }

  Future<void> saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(darkThemeKey, isDark);
  }

  Future<void> saveLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageKey, language);
  }

  Future<bool> getOffline() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(offlineKey) ?? false;
  }

  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(darkThemeKey) ?? false;
  }

  Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(languageKey) ?? 'en';
  }
}