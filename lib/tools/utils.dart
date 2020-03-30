import 'dart:convert';

class Utils {
  static stringToJson(String jsonString) {
    return jsonDecode(jsonString);
  }

  static jsonToString(Map<String, dynamic> json) {
    return new JsonEncoder.withIndent("    ").convert(json);
  }
}
