import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_tracker/services/cache/shared_not_initialize.dart';

import '../../screens/home/home_model.dart';

enum SharedKeys {
  dates,
  weights,
  hello,
  floatingLocation,
  langSetting,
  dateFormatSetting,
  weightFormatSetting
}

class SharedManager {
  SharedPreferences? preferences;

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<bool> checkFirstLogin() async {
    _checkPreferences();
    if (hasKey(SharedKeys.hello)) {
      return false;
    } else {
      await preferences?.setString(SharedKeys.hello.name, "true");
      return true;
    }
  }

  void _checkPreferences() {
    if (preferences == null) throw SharedNotInitializeException();
  }

  Future<void> saveStringItem(SharedKeys key, String value) async {
    _checkPreferences();
    await preferences?.setString(key.name, value);
  }

  String? getStringItem(SharedKeys key) {
    _checkPreferences();
    return preferences?.getString(key.name);
  }


  bool hasKey(SharedKeys key) {
    _checkPreferences();
    return (preferences?.containsKey(key.name) ?? false);
  }

  Future<void> saveUserData(String username, UserData userData) async {
    _checkPreferences();
    await preferences?.setString(username, jsonEncode(userData.toJson()));
    print('saved');
  }

  Future<UserData?> getUserData(String username) async {
    _checkPreferences();
    String? userDataString = preferences?.getString(username);
    if (userDataString != null) {
      Map<String, dynamic> userDataMap = jsonDecode(userDataString);
      return UserData.fromJson(userDataMap);
    } else {
      return null;
    }
  }
}
