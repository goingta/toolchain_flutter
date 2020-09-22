/// 构建
class XPBuildItem {
  final int buildId;
  final String comment;
  final String commitId;
  final String status;

  XPBuildItem.fromJson(Map<String, dynamic> json)
      : buildId = json['buildId'],
        comment = json['comment'],
        status = json['status'],
        commitId = json['commitId'];
}

/// 构建状态
class XPBuildStatus {}
