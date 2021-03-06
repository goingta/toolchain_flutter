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
    String webUrl = host + url;
    // print("url: $webUrl");
    Response response = await dio.post(webUrl, data: formData);
    // Response response = await dio.post(
    //   "http://www.dtworkroom.com/doris/1/2.0.0/test",
    //   data: {"aa": "bb" * 22},
    //   onSendProgress: (int sent, int total) {
    //     print("$sent $total");
    //   },
    // );
    // print("Response complete");
    // print("post data=" + response.data.toString());
    Map<String, dynamic> data = response.data["data"];
    return data;
  }
}
