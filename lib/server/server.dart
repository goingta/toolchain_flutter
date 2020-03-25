import 'package:dio/dio.dart';
import 'package:toolchain_flutter/common/Global.dart';

class Server {
  String host;

  Server() {
    switch (Global.env) {
      case "dev":
        // host = 'http://toolchain.developer.doctorwork.com/';
        host = 'http://10.1.0.38:7003/';
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

  Future<Map<String, dynamic>> getUrl(String url, Map<String, dynamic> params) async {
    assert(host != null,'host不能为空');
    Dio dio = new Dio();
    String webUrl = host + url;
    try {
      Response response = await dio.get(webUrl, queryParameters: params);
      Map<String, dynamic> data = response.data["data"];
      return data;
    } catch (e) {
      print('访问出错: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>> post(String url, Map<String, dynamic> params, {Map<String, dynamic> headers}) async {
    assert(host != null,'host不能为空');
    FormData formData = new FormData.from(params);
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
      Map<String, dynamic> data = response.data["data"];
      return data;
    } catch (e) {
      print('访问出错: $e');
      return null;
    }
  }
}
