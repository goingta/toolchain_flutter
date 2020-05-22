import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';
import '../network/user_network.dart';
import '../tools/utils.dart';

abstract class User {
  static String preUserInfo = "PreUserInfo";

  static Future<bool> signIn(String email, String password) async {
    String userInfo =
        "{\"name\":\"企鹅杏仁\",\"avatar\":\"https://avatar-qiniu.doctorwork.com/o_1drv9787c1qr1668kgf1rkopfp.jpeg\",\"email\":\"flutter@doctorwork.com\",\"position\":\"万科高新大厦\",\"userId\":\"flutter_user_id\"}";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(preUserInfo, userInfo);
    return true;
  }

  static Future<bool> fluwxWorkerSignIn(code) async {
    UserNetwork network = UserNetwork();
    Map<String, dynamic> result = await network.loginWithWechatWork(code);
    if (result != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userInfoString = Utils.jsonToString(result["data"]);
      prefs.setString(preUserInfo, userInfoString);
      return true;
    } else {
      return false;
    }
  }

  static Future<void> signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(preUserInfo);
    return;
  }

  static Future<UserModel> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userInfo = prefs.getString(preUserInfo);
    try {
      UserModel user = new UserModel.fromJson(Utils.stringToJson(userInfo));
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
