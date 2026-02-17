import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences _prefs;
  static Future<void> init() async { _prefs = await SharedPreferences.getInstance(); }
  static Future<void> saveAccessToken(String token) async => await _prefs.setString('access_token', token);
  static String? getAccessToken() => _prefs.getString('access_token');
  static Future<void> saveRefreshToken(String token) async => await _prefs.setString('refresh_token', token);
  static String? getRefreshToken() => _prefs.getString('refresh_token');
  static Future<void> saveUserId(String id) async => await _prefs.setString('user_id', id);
  static String? getUserId() => _prefs.getString('user_id');
  static Future<void> saveUserRole(String role) async => await _prefs.setString('user_role', role);
  static String? getUserRole() => _prefs.getString('user_role');
  static Future<void> setOnboardingComplete() async => await _prefs.setBool('onboarding_complete', true);
  static bool isOnboardingComplete() => _prefs.getBool('onboarding_complete') ?? false;
  static Future<void> clearAll() async => await _prefs.clear();
}
