class PGYUpdateModel {
  final String downloadURL;
  final String buildVersion;
  final String buildUpdateDescription;

  PGYUpdateModel.fromJson(Map<String, dynamic> json)
      : downloadURL = json["downloadURL"],
        buildVersion = json["buildVersion"],
        buildUpdateDescription = json["buildUpdateDescription"];
}
