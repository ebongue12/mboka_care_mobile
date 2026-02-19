import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveToken(String token) async {
    await _prefs.setString('access_token', token);
  }

  static String? getToken() {
    return _prefs.getString('access_token');
  }

  static Future<void> saveUserId(String id) async {
    await _prefs.setString('user_id', id);
  }

  static String? getUserId() {
    return _prefs.getString('user_id');
  }

  static Future<void> clearAll() async {
    await _prefs.clear();
  }

  static bool isLoggedIn() {
    return getToken() != null;
  }
}
