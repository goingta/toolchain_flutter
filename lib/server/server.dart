import 'package:dio/dio.dart';
import 'package:toolchain_flutter/common/Global.dart';
import 'package:toolchain_flutter/model/user.dart';
import 'package:toolchain_flutter/model/user_model.dart';

class Server {
  String host;

  Server() {
    switch (Global.env) {
      case "dev":
        // host = 'http://toolchain.developer.doctorwork.com/';
        host = 'http://10.2.0.26:7003/';
        break;
      case "qa":
        host = 'http://toolchain.qa.doctorwork.com/';
        break;
      case "pre":
        host = 'http://toolchain.pre.doctorwork.com/';
        break;
      case "prd":
        host = 'http://toolchain.doctorwork.com/';
        break;
    }
  }

  commonParams(Map<String, dynamic> params) async {
    UserModel user = await User.getCurrentUser();
    params["token"] = user.token;
    return params;
  }

  Future<Map<String, dynamic>> getUrl(
      String url, Map<String, dynamic> params) async {
    assert(host != null, 'host不能为空');
    Dio dio = new Dio();
    String webUrl = host + url;
    try {
      Response response = await dio.get(webUrl, queryParameters: commonParams(params));
      Map<String, dynamic> data = response.data;
      return data;
    } catch (e) {
      print('访问出错: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>> post(String url, Map<String, dynamic> params,
      {Map<String, dynamic> headers}) async {
    assert(host != null, 'host不能为空');
    FormData formData = new FormData.from(commonParams(params));
    Dio dio = new Dio();
    String webUrl = host + url;
    try {
      Response response = await dio.post(webUrl,
          data: formData,
          options: (headers != null && headers.isNotEmpty)
              ? Options(headers: headers)
              : Options());

      if (response.data.toString().isEmpty) {
        print("empty data");
        return {};
      }
      Map<String, dynamic> data = response.data;
      return data;
    } catch (e) {
      print('访问出错: $e');
      return null;
    }
  }
}
