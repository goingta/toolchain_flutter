import 'package:toolchain_flutter/model/item_model.dart';

import './../server/server.dart';
import 'dart:io';

class Network {
  static bool isIOS = Platform.isIOS;

  Future<List<ItemModel>> list({int page = 1,Map<String, dynamic> params}) async {
    Server server = new Server();
    String urlPath = "service/list/list";
    Map<String, dynamic> data = await server.getUrl(urlPath, params);

    print("网络返回结果：" + data.toString());
    List<ItemModel> arr = [];
    List list = data["data"];
    for (var item in list) {
      ItemModel model = new ItemModel.fromJson(item);
      arr.add(model);
    }
    return arr;
  }

  Future<Map<String, dynamic>> detail(String id) async {
    Server server = new Server();
    String urlPath = "service/detail/detail";
    Map<String, dynamic> data = await server.getUrl(urlPath, {id: id});

    print("网络返回结果：" + data.toString());
    // List<ItemModel> arr = [];
    // List list = data["data"];
    // for (var item in list) {
    //   ItemModel model = new ItemModel.fromJson(item);
    //   arr.add(model);
    // }
    return data["data"];
  }
}
