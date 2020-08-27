import './../server/jenkins_server.dart';
import 'dart:io';

class JenkinsNetwork {
  static bool isIOS = Platform.isIOS;

  Future<Map<String, dynamic>> jenkinsBuild(String token,String platform) async {
    JenkinsServer server = new JenkinsServer();
    String urlPath = "job/toolchain_flutter/buildWithParameters?token=$token&Platform=$platform";
    Map<String, dynamic> data = await server.post(urlPath, {"1": "1"},
        headers: {"Authorization": "Basic ZGV2OmRvY3Rvcndvcms="});
    return data;
  }
}
