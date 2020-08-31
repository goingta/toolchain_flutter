import 'package:toolchain_flutter/model/program_item_model.dart';

class AppItemModel extends ProgramItemModel {
  // 蒲公英 ApiKey
  final String pgyApiKey;
  // 蒲公英 AppKey
  final String pgyAppKey;
  // Jenkins 构建 Token
  final String jenkinsToken;

  AppItemModel.fromJson(Map<String, dynamic> json)
      : pgyApiKey = json['pgyApiKey'],
        pgyAppKey = json['pgyAppKey'],
        jenkinsToken = json['jenkinsToken'],
        super.fromJson(json);
}
