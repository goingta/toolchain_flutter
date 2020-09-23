/// 构建
class XPBuildItem {
  final int buildId;
  final String comment;
  final String commitId;
  final String ref;
  final int created;
  final XPBuildStatus status;

  XPBuildItem.fromJson(Map<String, dynamic> json)
      : buildId = json['buildId'],
        comment = json['comment'],
        ref = json['ref'],
        created = json['created'],
        status = XPBuildStatus.valueOf(json['status']),
        commitId = json['commitId'];
}

/// 构建状态
class XPBuildStatus {
  final String code;
  final String value;

  XPBuildStatus(this.code, this.value);

  static final XPBuildStatus RUNNING = XPBuildStatus("1", "构建中");

  static final XPBuildStatus CANCELED = XPBuildStatus("2", "构建取消");

  static final XPBuildStatus FAILED = XPBuildStatus("3", "构建失败");

  static final XPBuildStatus SUCCESS = XPBuildStatus("4", "构建成功");

  static final XPBuildStatus PENDING = XPBuildStatus("5", "构建排队中");

  static final List<XPBuildStatus> values = [
    RUNNING,
    CANCELED,
    FAILED,
    SUCCESS,
    PENDING,
  ];

  static XPBuildStatus valueOf(String code) {
    for (int i = 0; i < values.length; i++) {
      if (values[i].code == code) {
        return values[i];
      }
    }
    return null;
  }
}
