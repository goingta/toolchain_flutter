import 'package:toolchain_flutter/common/Global.dart';

import 'server.dart';

class UserServer extends Server {
  UserServer() {
    switch (Global.env) {
      case "dev":
        host = 'http://oa.sso.developer.doctorwork.com/';
      break;
      case "qa":
        host = 'http://oa.sso.qa.doctorwork.com/';
      break;
      case "pre":
        host = 'http://oa.sso.pre.doctorwork.com/';
      break;
      case "prd":
        host = 'http://oa.sso.doctorwork.com/';
      break;
    }
  }
}
