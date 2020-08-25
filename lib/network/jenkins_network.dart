import './../server/jenkins_server.dart';
import 'dart:io';

class JenkinsNetwork {
  static bool isIOS = Platform.isIOS;

  Future<Map<String, dynamic>> jenkinsBuild() async {
    JenkinsServer server = new JenkinsServer();
    String urlPath = isIOS
        ? "job/toolchain_flutter_ios/build?token=ab5ca6249862f5a60ac451599b5d9938"
        : "job/toolchain_flutter_android/build?token=ab5ca6249862f5a60ac451599b5d9938";
    Map<String, dynamic> data = await server.post(urlPath, {"1": "1"},
        headers: {"Authorization": "Basic ZGV2OmRvY3Rvcndvcms="});
    return data;
  }
}
