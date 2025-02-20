import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHe {
  static const String _firstTimeKey = "isFirstTime";

  static Future<bool> isFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool(_firstTimeKey) ?? true;
    return firstTime;
  }

  static Future<void> setFirstTime() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_firstTimeKey, false);
  }
}
