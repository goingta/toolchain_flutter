import 'package:dio/dio.dart';

class Server {
  static const pgyHost = 'https://www.pgyer.com/';

  Future<Map<String, dynamic>> getUrl(String url, Map params,
      {String host = pgyHost}) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get(host + url, queryParameters: params);
    // print("get data=" + response.data.toString());
    Map<String, dynamic> data = response.data["data"];
    return data;
  }

  Future<Map<String, dynamic>> post(String url, Map<String, dynamic> params,
      {String host = pgyHost}) async {
    FormData formData = new FormData.from(params);
    Dio dio = new Dio();
    Response response = await dio.post(host + url, data: formData);
    // print("post data=" + response.data.toString());
    Map<String, dynamic> data = response.data["data"];
    return data;
  }
}
