import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:toolchain_flutter/model/user_model.dart';
import 'package:toolchain_flutter/network/user_network.dart';
import 'package:toolchain_flutter/tools/utils.dart';

abstract class User {
  static String preUserInfo = "PreUserInfo";
  static UserModel currentUser;

  static Future<void> signIn(String email, String password) async {
    try {
      UserNetwork network = UserNetwork();
      final UserModel userModel = await network.loginWith(email, password);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userInfoString = Utils.jsonToString(userModel.toJson());
      prefs.setString(preUserInfo, userInfoString);
    } catch (e) {
      return Future.error(e);
    }

  }

  static Future<void> fluwxWorkerSignIn(code) async {
    UserNetwork network = UserNetwork();
    try {
      final UserModel userModel = await network.loginWithWechatWork(code);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userInfoString = Utils.jsonToString(userModel.toJson());
      prefs.setString(preUserInfo, userInfoString);
    } catch (e) {
      return Future.error(e);
    }
  }

  static Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(preUserInfo);
    return;
  }

  static Future<UserModel> getCurrentUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userInfo = prefs.getString(preUserInfo);
      UserModel user = new UserModel.fromJson(Utils.stringToJson(userInfo));
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<UserModel> loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userInfo = prefs.getString(preUserInfo);
    if (userInfo != null) {
      try {
        UserModel user = new UserModel.fromJson(Utils.stringToJson(userInfo));
        User.currentUser = user;
        return user;
      } catch (e) {
        print(e);
        return null;
      }
    } else {
      return null;
    }
  }
}
