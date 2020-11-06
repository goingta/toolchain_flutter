import 'package:toolchain_flutter/common/app_env.dart';
import 'package:toolchain_flutter/common/global.dart';
import 'package:toolchain_flutter/server/json_server.dart';

class SphinxServer extends JsonServer {
  SphinxServer() {
    if (Global.appEnv == AppEnv.DEV) {
      baseUrl = 'https://sphinx.xingrengo.com/';
    } else if (Global.appEnv == AppEnv.TEST) {
      baseUrl = 'https://sphinx.aihaisi.com/';
    } else if (Global.appEnv == AppEnv.STAGING) {
      baseUrl = 'https://sphinx.aihaisi.com/';
    } else {
      baseUrl = 'https://sphinx.xrxr.xyz/';
    }
  }
}
