import 'dart:convert';

import 'package:toolchain_flutter/model/user_model.dart';
import 'package:toolchain_flutter/server/sphinx_server.dart';
import 'package:toolchain_flutter/server/user_server.dart';

class UserNetwork {
  static UserServer _userServer = new UserServer();
  static SphinxServer _sphinxServer = new SphinxServer();

  Future<UserModel> loginWithWechatWork(String code) async {
    try {
      final Map<String, dynamic> jsonMap = await _userServer.get(
        "v1/wx/user/app/oauth_code",
        queryParameters: {"code": code},
      );
      return UserModel.fromJson(jsonMap["data"]);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<UserModel> loginWith(String name,String password) async {
    try {
      final Map<String, dynamic> jsonMap = await _sphinxServer.post(
        "v2/auth/fm",
        data: {"name": name,"password":password},
      );
      Map<String,dynamic> data = jsonMap["data"];
      final userMap = await _sphinxServer.get("login/wx",queryParameters: {"token":data["token"]});

      return UserModel.fromJson(userMap["data"]);
    } catch (e) {
      return Future.error(e);
    }
  }
}
