import 'package:toolchain_flutter/model/program_item_model.dart';

class MiniProgramItemModel extends ProgramItemModel {
  // 小程序原始 ID
  final String appId;
  // Jenkins 工程名字
  final String jenkinsProjectName;
  // Jenkins 构建 Token
  final String jenkinsToken;

  MiniProgramItemModel.fromJson(Map<String, dynamic> json)
      : appId = json["appId"],
        jenkinsProjectName = json['jenkinsProjectName'],
        jenkinsToken = json['jenkinsToken'],
        super.fromJson(json);
}
