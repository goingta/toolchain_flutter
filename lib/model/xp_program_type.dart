class XPProgramType {
  final int code;
  final String value;
  XPProgramType(this.code, this.value);

  static final XPProgramType API = XPProgramType(0, "api");

  static final XPProgramType ADMIN = XPProgramType(1, "admin");

  static final XPProgramType WEB = XPProgramType(2, "web");

  static final XPProgramType RPC = XPProgramType(3, "rpc");

  static final XPProgramType SPA = XPProgramType(4, "spa");

  static final XPProgramType BFF = XPProgramType(5, "bff");

  static final List<XPProgramType> values = [API, ADMIN, WEB, RPC, SPA, BFF];

  static XPProgramType valueOf(int code) {
    for (int i = 0; i < values.length; i++) {
      if (values[i].code == code) {
        return values[i];
      }
    }
    return null;
  }
}
