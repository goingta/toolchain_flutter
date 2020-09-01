import 'package:toolchain_flutter/server/jenkins_server.dart';

class JenkinsNetwork {
  static JenkinsServer _jenkinsServer = new JenkinsServer();

  Future<void> jenkinsBuild(
      String jenkinsProjectName, String token, String platform) async {
    try {
      await _jenkinsServer.post(
        "job/$jenkinsProjectName/buildWithParameters?token=$token&Platform=$platform",
        data: {
          "1": "1",
        },
        headers: {
          "Authorization": "Basic ZGV2OmRvY3Rvcndvcms=",
        },
      );
    } catch (e) {
      return Future.error(e);
    }
  }
}
