import './../server/user_server.dart';
import 'dart:io';

class UserNetwork {
  static bool isIOS = Platform.isIOS;

  Future<Map<String, dynamic>> loginWithWechatWork(String code) async {
    UserServer server = new UserServer();
    String urlPath = "console/v1/wx/user/info_from_oauth_code";
    Map<String, dynamic> data = await server.getUrl(urlPath, {"code": code});
    return data;
  }
}
