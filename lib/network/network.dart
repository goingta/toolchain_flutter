import './../server/server.dart';
import 'dart:io';

class Network {
  static bool isIOS = Platform.isIOS;

  Future<Map<String, dynamic>> list() async {
    Server server = new Server();
    String urlPath = "service/list/list";
    Map<String, dynamic> data = await server.post(urlPath, {},
        headers: {"Authorization": "Basic ZGV2OmRvY3Rvcndvcms="});
    return data;
  }
}
