import 'package:toolchain_flutter/common/global.dart';
import 'package:toolchain_flutter/server/json_server.dart';

class UserServer extends JsonServer {
  UserServer() {
    switch (Global.env) {
      case "dev":
        baseUrl = 'http://api-dev.doctorwork.com/oa-sso-web/';
        break;
      case "qa":
        baseUrl = 'http://api-qa.doctorwork.com/oa-sso-web/';
        break;
      case "pre":
        baseUrl = 'http://api-pre.doctorwork.com/oa-sso-web/';
        break;
      case "prd":
        baseUrl = 'http://api.doctorwork.com/oa-sso-web/';
        break;
    }
  }
}
