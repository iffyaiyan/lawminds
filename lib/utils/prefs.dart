import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static String isLoggedIn = 'is_logged_in';

  static Future<void> setIsLogin(bool val) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Prefs.isLoggedIn, val);

  }

  static Future<bool> getIsLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Prefs.isLoggedIn) ?? false;
  }
}