class XPProgramItemModel {
  // 中文名
  final String chineseName;

  // 创建时间
  final int created;

  // 应用 Id
  final int id;

  // 开发语言
  final String language;

  // 英文名
  final String name;

  XPProgramItemModel.fromJson(Map<String, dynamic> json)
      : chineseName = json['chineseName'],
        created = json['created'],
        id = json['id'],
        language = json['language'][1].toString(),
        name = json['name'];
}
