class PGYItemModel {
  String buildKey;
  String buildFileSize;
  String buildVersion;
  String buildVersionNo;
  String buildUpdateDescription;
  String buildBuildVersion;
  String buildCreated;

  PGYItemModel(
      {this.buildKey,
      this.buildFileSize,
      this.buildVersion,
      this.buildVersionNo,
      this.buildUpdateDescription,
      this.buildBuildVersion,
      this.buildCreated});

  PGYItemModel.fromJson(Map<String, dynamic> json)
      : buildKey = json['buildKey'],
        buildFileSize = json['buildFileSize'],
        buildVersion = json['buildVersion'],
        buildVersionNo = json['buildVersionNo'],
        buildUpdateDescription = json['buildUpdateDescription'],
        buildBuildVersion = json['buildBuildVersion'],
        buildCreated = json['buildCreated'];

  Map<String, dynamic> toJson() => {
        'buildKey': buildKey,
        'buildFileSize': buildFileSize,
        'buildVersion': buildVersion,
        'buildVersionNo': buildVersionNo,
        'buildUpdateDescription': buildUpdateDescription,
        'buildBuildVersion': buildBuildVersion,
        'buildCreated': buildCreated,
      };
}
