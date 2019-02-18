import './../server/server.dart';

class PGYNetwork {
  //蒲公英
  var pgyerHealthAppKey = "35b60c374269ee0f9ffff517b1b47c9b";
  var pgyerHealthApiKey = "811e984eb5e760bb7f2885484c6c4edb";
  var pgyerHealthUserKey = "15943af593e531aef0b1f7d6c70d4131";

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
