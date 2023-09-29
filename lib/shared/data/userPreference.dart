// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static Future<void> saveCredentials(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  static Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  static Future<String?> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('password');
  }


  static Future<void> saveRace(String race) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('race', race);
  }

  static Future<String?> getRace() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('race');
  }

}
