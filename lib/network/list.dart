import './../server/server.dart';
import './../model/item_model.dart';

class PGYNetwork {
  int type; //0是工具链本身，1是企鹅APP
  PGYNetwork({this.type});
  //工具链 蒲公英配置
  var pgyerToolChainAppKey = "6ccc42cf2f28f2b85ab16a46c0c1d044";
  var pgyerToolChainApiKey = "87a96feb51f5ecdfafc2bc4c9eeb045a";
  var pgyerToolChainUserKey = "dad6308763eece8035c49ea33e676138";

  var pgyerHealthAppKey = "6ab0025e60ff0cc7333594cc961ebcf2";
  var pgyerHealthApiKey = "87a96feb51f5ecdfafc2bc4c9eeb045a";
  var pgyerHealthUserKey = "dad6308763eece8035c49ea33e676138";

  Future<List<ItemModel>> getList({int page = 1}) async {
    var server = new Server();
    Map<String, dynamic> data = await server.post("apiv2/app/builds", {
      "_api_key": type == 0 ? pgyerToolChainApiKey : pgyerHealthApiKey,
      "appKey": type == 0 ? pgyerToolChainAppKey : pgyerHealthAppKey,
      "page": page
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
    Map<String, dynamic> data = await server.post(
        "view/iOS/job/DoctorHealth/build?token=ab5ca6249862f5a60ac451599b5d9938",
        {"1": "1"},
        host: "http://jenkins.doctorwork.com/",
        headers: {"Authorization": "Basic ZGV2OmRvY3Rvcndvcms="});
    return data;
  }
}
