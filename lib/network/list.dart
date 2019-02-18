import './../server/server.dart';

class PGYNetwork {
  //蒲公英
  var pgyerHealthAppKey = "6ab0025e60ff0cc7333594cc961ebcf2";
  var pgyerHealthApiKey = "87a96feb51f5ecdfafc2bc4c9eeb045a";
  var pgyerHealthUserKey = "dad6308763eece8035c49ea33e676138";

  getList(void callback(data, response)) {
    var server = new Server();
    server.post(
        "apiv2/app/builds",
        {
          "_api_key": pgyerHealthApiKey,
          "appKey": pgyerHealthAppKey,
          "page": "1"
        },
        callback);
  }
}
