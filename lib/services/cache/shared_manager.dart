import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_tracker/services/cache/shared_not_initialize.dart';

import '../../screens/home/home_model.dart';


class SharedManager {
  SharedPreferences? preferences;

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }


  void _checkPreferences() {
    if (preferences == null) throw SharedNotInitializeException();
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
