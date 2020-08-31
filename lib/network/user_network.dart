import 'package:toolchain_flutter/model/user_model.dart';
import 'package:toolchain_flutter/server/user_server.dart';

class UserNetwork {
  static UserServer _userServer = new UserServer();

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
}
