class ProgramLanguage {
  final int code;
  final String value;

  ProgramLanguage(this.code, this.value);

  static final ProgramLanguage JAVA = ProgramLanguage(1, "Java");

  static final ProgramLanguage JAVA_SCRIPT = ProgramLanguage(2, "JavaScript");

  static final List<ProgramLanguage> values = [JAVA, JAVA_SCRIPT];

  static ProgramLanguage valueOf(int code) {
    for (int i = 0; i < values.length; i++) {
      if (values[i].code == code) {
        return values[i];
      }
    }
    return null;
  }
}
