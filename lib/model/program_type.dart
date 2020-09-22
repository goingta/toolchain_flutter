class ProgramType {
  final int code;
  final String value;
  ProgramType(this.code, this.value);

  static final ProgramType IOS = ProgramType(1, "iOS");

  static final ProgramType ANDROID = ProgramType(2, "Android");

  static final ProgramType H5 = ProgramType(3, "H5");

  static final ProgramType MINI_PROGRAM = ProgramType(4, "小程序");

  static final ProgramType SERVER = ProgramType(5, "Server");

  static final ProgramType NODE = ProgramType(6, "Node");

  static final List<ProgramType> values = [
    IOS,
    ANDROID,
    H5,
    MINI_PROGRAM,
    SERVER,
    NODE
  ];

  static ProgramType valueOf(int code) {
    for (int i = 0; i < values.length; i++) {
      if (values[i].code == code) {
        return values[i];
      }
    }
    return null;
  }
}
