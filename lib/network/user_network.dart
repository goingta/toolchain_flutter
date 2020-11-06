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
        "api/code/login/token",
        queryParameters: {"username": name,"password":password}
      );
      return UserModel.fromJson(jsonMap["data"]);
    } catch (e) {
      return Future.error(e);
    }
  }
}
