
import 'server.dart';

import 'package:toolchain_flutter/common/Global.dart';

class UserServer extends Server {
  UserServer() {
    switch (Global.env) {
      case "dev":
        host = 'http://api-dev.doctorwork.com/oa-sso-web/';
      break;
      case "qa":
        host = 'http://api-qa.doctorwork.com/oa-sso-web/';
      break;
      case "pre":
        host = 'http://api-pre.doctorwork.com/oa-sso-web/';
      break;
      case "prd":
        host = 'http://api.doctorwork.com/oa-sso-web/';
      break;
    }
  }
}
