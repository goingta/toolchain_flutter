import 'package:toolchain_flutter/model/program_item_model.dart';

class AppItemModel extends ProgramItemModel {
  // 蒲公英 ApiKey
  final String pgyApiKey;
  // 蒲公英 AppKey
  final String pgyAppKey;
  // Jenkins 工程名字
  final String jenkinsProjectName;
  // Jenkins 构建 Token
  final String jenkinsToken;

  AppItemModel.fromJson(Map<String, dynamic> json)
      : pgyApiKey = json['pgyApiKey'],
        pgyAppKey = json['pgyAppKey'],
        jenkinsProjectName = json['jenkinsProjectName'],
        jenkinsToken = json['jenkinsToken'],
        super.fromJson(json);
}
