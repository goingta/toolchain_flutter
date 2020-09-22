class XPEnv {
  final int code;
  final String value;
  XPEnv(this.code, this.value);

  static final XPEnv DEV = XPEnv(0, "开发");

  static final XPEnv TEST = XPEnv(2, "测试");

  static final XPEnv STAGING = XPEnv(3, "预发");

  static final XPEnv PRODUCTION = XPEnv(4, "正式");

  static final List<XPEnv> values = [DEV, TEST, STAGING, PRODUCTION];

  static XPEnv valueOf(int code) {
    for (int i = 0; i < values.length; i++) {
      if (values[i].code == code) {
        return values[i];
      }
    }
    return null;
  }
}
