import 'package:dio/dio.dart';

class Server {
  String host;

  Future<Map<String, dynamic>> getUrl(String url, Map params) async {
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
