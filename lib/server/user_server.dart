import 'package:toolchain_flutter/common/app_env.dart';
import 'package:toolchain_flutter/common/global.dart';
import 'package:toolchain_flutter/server/json_server.dart';

class UserServer extends JsonServer {
  UserServer() {
    if (Global.appEnv == AppEnv.DEV) {
      baseUrl = 'https://api-dev.doctorwork.com/oa-sso-web/';
    } else if (Global.appEnv == AppEnv.TEST) {
      baseUrl = 'https://api-qa.doctorwork.com/oa-sso-web/';
    } else if (Global.appEnv == AppEnv.STAGING) {
      baseUrl = 'https://api-pre.doctorwork.com/oa-sso-web/';
    } else {
      baseUrl = 'https://api.doctorwork.com/oa-sso-web/';
    }
  }
}
