import './../server/server.dart';
import './../model/itemModel.dart';

class PGYNetwork {
  //蒲公英
  var pgyerHealthAppKey = "35b60c374269ee0f9ffff517b1b47c9b";
  var pgyerHealthApiKey = "811e984eb5e760bb7f2885484c6c4edb";
  var pgyerHealthUserKey = "15943af593e531aef0b1f7d6c70d4131";

  Future<List<ItemModel>> getList() async {
    var server = new Server();
    Map<String, dynamic> data = await server.post("apiv2/app/builds", {
      "_api_key": pgyerHealthApiKey,
      "appKey": pgyerHealthAppKey,
      "page": "1"
    });

    List<ItemModel> arr = [];
    List list = data["list"];
    for (var item in list) {
      ItemModel model = new ItemModel.fromJson(item);
      arr.add(model);
    }
    return arr;
  }

  Future<Map<String, dynamic>> jenkinsBuild() async {
    var server = new Server();
    Map<String, dynamic> data = await server.getUrl(
        "buildByToken/build", {"job": "{job}", "token": "{token}"},
        host: "http://{IP}:{端口号}");
    return data;
  }
}
