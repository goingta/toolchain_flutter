import './../server/pgyer_server.dart';
import './../model/pgy_item_model.dart';
import 'dart:io';

class PGYNetwork {
  static bool isIOS = Platform.isIOS;
  int type; //0是工具链本身，1是企鹅APP
  PGYNetwork({this.type});
  //工具链 蒲公英配置
  var pgyerToolChainAppKey = isIOS
      ? "df0fa62af1afe652c6cc881091d808fc"
      : "aad7f7999b29743c6820c113e92bdb5a";
  var pgyerToolChainApiKey = "01f1afe385c48954fd713ba5d533b62c";
  var pgyerToolChainUserKey = "1355980667be03e4544e23214b5e8c14";

  // var pgyerHealthAppKey = isIOS
  //     ? "6f5f513de56605e2da0db3f3108f7911"
  //     : "bf323da6d0fd071c90d0b9a2ac44c20b";
  // var pgyerHealthApiKey = "01f1afe385c48954fd713ba5d533b62c";
  // var pgyerHealthUserKey = "1355980667be03e4544e23214b5e8c14";

  Future<List<PGYItemModel>> getList({int page = 1, appKey, apiKey}) async {
    PGYServer server = new PGYServer();
    Map<String, dynamic> data = await server.post("apiv2/app/builds", {
      "_api_key": apiKey,
      "appKey": appKey,
      "page": page
    });

    print("网络返回结果：" + data.toString());

    List<PGYItemModel> arr = [];
    List list = data["data"]["list"];
    for (var item in list) {
      PGYItemModel model = new PGYItemModel.fromJson(item);
      arr.add(model);
    }
    return arr;
  }
}
