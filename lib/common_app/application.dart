import 'package:shared_preferences/shared_preferences.dart';

class Application {
  Application._();
  static late SharedPreferences preferences;
  static Future<void> setPreferences() async {
    preferences = await SharedPreferences.getInstance();
  }
}
