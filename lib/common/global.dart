import 'package:shared_preferences/shared_preferences.dart';
import 'package:toolchain_flutter/common/app_env.dart';

class Global {
  // 当前 App 环境
  static AppEnv appEnv = AppEnv.PROD;

  // 企业微信配置
  static String schema;
  static String agentId;
  static final corpId = 'ww41abef44dc00e8c4';

  // 当前工具链环境的 Key
  static const String SHARED_PREFERENCES_KEY_CURRENT_APP_ENV =
      "SHARED_PREFERENCES_KEY_CURRENT_APP_ENV";

  /// 初始化全局信息，会在APP启动时执行
  static Future init() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int currentAppEnvCode =
        sharedPreferences.getInt(SHARED_PREFERENCES_KEY_CURRENT_APP_ENV);
    appEnv = AppEnv.valueOf(currentAppEnvCode) ?? AppEnv.PROD;
    // 从本地数据中获取当前环境
    if (appEnv == AppEnv.DEV) {
      schema = "wwauth41abef44dc00e8c4000021";
      agentId = "1000021";
    } else if (appEnv == AppEnv.TEST) {
      schema = "wwauth41abef44dc00e8c4000016";
      agentId = "1000016";
    } else if (appEnv == AppEnv.STAGING) {
      schema = "wwauth41abef44dc00e8c4000017";
      agentId = "1000017";
    } else {
      schema = "wwauth41abef44dc00e8c4000015";
      agentId = "1000015";
    }
  }
}
