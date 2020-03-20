import 'dart:async';
import '../model/user_model.dart';
import './model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class User {
  static Future<String> signIn(String email, String password) async {
    return "";
  }

  static Future<void> signOut() async {}

  static Future<UserModel> getCurrentUser() async {
    // UserModel user = UserModel("goingta", "", "");
    UserModel user = null;
    return user;
  }
}
