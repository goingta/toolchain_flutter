import 'package:toolchain_flutter/server/server.dart';

class JenkinsServer extends Server<void> {
  JenkinsServer() {
    baseUrl = 'https://dwci.aihaisi.com/';
  }
}
