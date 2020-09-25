import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toolchain_flutter/model/user_model.dart';
import 'package:toolchain_flutter/network/user_network.dart';
import 'package:toolchain_flutter/tools/utils.dart';

abstract class User {
  static String preUserInfo = "PreUserInfo";
  static UserModel currentUser;

  static Future<bool> signIn(String email, String password) async {
    String userInfo =
        "{\"name\":\"企鹅杏仁\",\"avatar\":\"https://avatar-qiniu.doctorwork.com/o_1drv9787c1qr1668kgf1rkopfp.jpeg\",\"email\":\"flutter@doctorwork.com\",\"position\":\"万科高新大厦\",\"userId\":\"flutter_user_id\"}";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(preUserInfo, userInfo);
    return true;
  }

  static Future<void> fluwxWorkerSignIn(code) async {
    UserNetwork network = UserNetwork();
    try {
      final UserModel userModel = await network.loginWithWechatWork(code);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userInfoString = Utils.jsonToString(userModel.toJson());
      prefs.setString(preUserInfo, userInfoString);
    } on Exception catch (e) {
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
