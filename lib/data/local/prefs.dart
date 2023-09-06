import 'package:fitness_app_bloc/common_app/application.dart';

class LocalPref {
  LocalPref._();
  static bool? getBool(String key) {
    return Application.preferences.getBool(key);
  }

  static Future<bool> setBool(String key, bool value) {
    return Application.preferences.setBool(key, value);
  }

  static double? getDouble(String key) {
    return Application.preferences.getDouble(key);
  }

  static Future setDouble(String key, double value) {
    return Application.preferences.setDouble(key, value);
  }

  static int? getInt(String key) {
    return Application.preferences.getInt(key);
  }

  static Future<bool> setInt(String key, int value) {
    return Application.preferences.setInt(key, value);
  }

  static String? getString(String key) {
    return Application.preferences.getString(key);
  }

  static Future<bool> setString(String key, String value) {
    return Application.preferences.setString(key, value);
  }
}
