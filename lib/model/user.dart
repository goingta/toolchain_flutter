import 'dart:async';
import '../model/user_model.dart';

abstract class User {
  static Future<String> signIn(String email, String password) async {

    return "";
  }

  static Future<void> signOut() async {

  }

  static Future<UserModel> getCurrentUser() async {
    // UserModel user = UserModel("goingta", "", "");
    UserModel user = null;
    return user;
  }

}
