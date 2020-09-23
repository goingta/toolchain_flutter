import 'package:dio/dio.dart';
import 'package:toolchain_flutter/common/app_env.dart';
import 'package:toolchain_flutter/common/global.dart';
import 'package:toolchain_flutter/model/user.dart';
import 'package:toolchain_flutter/model/user_model.dart';
import 'package:toolchain_flutter/server/json_server.dart';

class XPServer extends JsonServer {
  XPServer() {
    if (Global.appEnv == AppEnv.DEV) {
      baseUrl = 'https://xpportal.xingrengo.com/';
    } else if (Global.appEnv == AppEnv.TEST) {
      baseUrl = '';
    } else if (Global.appEnv == AppEnv.STAGING) {
      baseUrl = '';
    } else {
      baseUrl = '';
    }
  }

  @override
  Future<Map<String, dynamic>> request(String requestMethod, String path,
      {Map<String, dynamic> headers,
      Map<String, dynamic> queryParameters,
      Map<String, dynamic> data,
      FormData formData}) async {
    try {
      UserModel userModel = await User.getCurrentUser();
      Map<String, dynamic> xpPortalHeaders = Map<String, dynamic>();
      xpPortalHeaders.addAll({"Authorization": userModel?.token});
      if (headers != null) {
        xpPortalHeaders.addAll(headers);
      }
      print(xpPortalHeaders);
      Map<String, dynamic> jsonMap = await super.request(requestMethod, path,
          headers: xpPortalHeaders,
          queryParameters: queryParameters,
          data: data,
          formData: formData);
      final bool success = jsonMap["success"];
      if (!success) {
        return Future.error(jsonMap["errMessage"] ?? "网络异常，请检查网络");
      }
      return jsonMap;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
