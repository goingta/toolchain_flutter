class ItemModel {
  String buildKey;
  String buildFileSize;
  String buildVersion;
  String buildUpdateDescription;
  String buildBuildVersion;
  String buildCreated;

  ItemModel(
      {this.buildKey,
      this.buildFileSize,
      this.buildVersion,
      this.buildUpdateDescription,
      this.buildBuildVersion,
      this.buildCreated});

  ItemModel.fromJson(Map<String, dynamic> json)
      : buildKey = json['buildKey'],
        buildFileSize = json['buildFileSize'],
        buildVersion = json['buildVersion'],
        buildUpdateDescription = json['buildUpdateDescription'],
        buildBuildVersion = json['buildBuildVersion'],
        buildCreated = json['buildCreated'];

  Map<String, dynamic> toJson() => {
        'buildKey': buildKey,
        'buildFileSize': buildFileSize,
        'buildVersion': buildVersion,
        'buildUpdateDescription': buildUpdateDescription,
        'buildBuildVersion': buildBuildVersion,
        'buildCreated': buildCreated,
      };
}
