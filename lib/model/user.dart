import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../model/user_model.dart';
import '../network/user_network.dart';

abstract class User {
  static String preUserInfo = "PreUserInfo";

  static Future<bool> signIn(String email, String password) async {
    String userInfo =
        "{'name':'先生','avatar':'http://avatar','token':'Us5fepIESZHYO1jrPsNXYrecRyk'}";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(preUserInfo, userInfo);
    return true;
  }

  static Future<bool> fluwxWorkerSignIn(code) async {
    UserNetwork network = UserNetwork();
    Map<String, dynamic> userInfo = await network.loginWithWechatWork(code);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(preUserInfo, userInfo.toString());
    return true;
  }

  static Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(preUserInfo);
    return;
  }

  static Future<UserModel> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userInfo = prefs.getString(preUserInfo);
    // print(userInfo);
    try {
      UserModel user = new UserModel.fromJson(jsonDecode(userInfo));
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
