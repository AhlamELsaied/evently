import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  String lan = "en";

  AppProvider() {
    initProvider();
  }

  Future<void> initProvider() async {
    await getLang();
    await getTheme();
  }

  void changeTheme(ThemeMode? newTheme) async {
    if (newTheme != null) {
      themeMode = newTheme;
    } else {
      themeMode =
          (themeMode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    }
    await saveTheme();
    notifyListeners();
  }

  Future<void> saveTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("theme", themeMode.name);
  }

  Future<void> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String theme = prefs.getString("theme") ?? "light";
    themeMode = (theme == "light") ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  void changeLang(String? newLang) async {
    if (newLang != null) {
      lan = newLang;
    } else {
      lan = (lan == "en") ? "ar" : "en";
    }
    await saveLang();
    notifyListeners();
  }

  Future<void> saveLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("lan", lan);
  }

  Future<void> getLang() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    lan = prefs.getString("lan") ?? "en";
  }
}
