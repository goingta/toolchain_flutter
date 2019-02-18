import 'package:dio/dio.dart';

class Server {
  var host = 'https://www.pgyer.com/';

  getUrl(String url, Map params, void callback(data)) async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get(host + url, queryParameters: params);
    // print("get data=" + response.data.toString());
    callback(response.data);
  }

  post(String url, Map<String, dynamic> params,
      void callback(data, response)) async {
    FormData formData = new FormData.from(params);
    Dio dio = new Dio();
    Response response = await dio.post(host + url, data: formData);
    // print("post data=" + response.data.toString());
    var data = response.data["data"];
    callback(data, response.data);
  }
}
