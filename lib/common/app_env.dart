class AppEnv {
  final int code;
  final String value;

  AppEnv(this.code, this.value);

  static final AppEnv DEV = AppEnv(1, "开发环境");

  static final AppEnv TEST = AppEnv(2, "测试环境");

  static final AppEnv STAGING = AppEnv(3, "预发环境");

  static final AppEnv PROD = AppEnv(4, "生产环境");

  static final List<AppEnv> values = [
    DEV,
    TEST,
    STAGING,
    PROD,
  ];

  static AppEnv valueOf(int code) {
    for (int i = 0; i < values.length; i++) {
      if (values[i].code == code) {
        return values[i];
      }
    }
    return null;
  }
}
