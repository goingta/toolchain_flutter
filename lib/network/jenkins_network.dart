import './../server/pgyer_server.dart';
import 'dart:io';

class JenkinsNetwork {
  static bool isIOS = Platform.isIOS;

  Future<Map<String, dynamic>> jenkinsBuild() async {
    var server = new PGYServer();
    String urlPath = isIOS
        ? "view/iOS/job/DoctorHealth/build?token=ab5ca6249862f5a60ac451599b5d9938"
        : "view/Android/job/android-health-rn/build?token=ab5ca6249862f5a60ac451599b5d9938";
    Map<String, dynamic> data = await server.post(urlPath, {"1": "1"},
        headers: {"Authorization": "Basic ZGV2OmRvY3Rvcndvcms="});
    return data;
  }
}
