import 'package:dio/dio.dart';
import 'package:toolchain_flutter/server/json_server.dart';

class PGYServer extends JsonServer {
  PGYServer() {
    baseUrl = 'https://www.pgyer.com/';
  }

  @override
  Future<Map<String, dynamic>> request(String requestMethod, String path,
      {Map<String, dynamic> headers,
      Map<String, dynamic> queryParameters,
      Map<String, dynamic> data,
      FormData formData}) async {
    try {
      final Map<String, dynamic> jsonMap = await super.request(
          requestMethod, path,
          headers: headers,
          queryParameters: queryParameters,
          data: data,
          formData: formData);
      final int code = jsonMap["code"];
      if (code != 0) {
        return Future.error(jsonMap["message"] ?? "蒲公英返回数据异常");
      }
      return jsonMap;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
