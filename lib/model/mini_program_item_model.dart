import 'package:toolchain_flutter/model/program_item_model.dart';

class MiniProgramItemModel extends ProgramItemModel {
  // 小程序原始 ID
  final String appId;

  MiniProgramItemModel.fromJson(Map<String, dynamic> json)
      : appId = json["appId"],
        super.fromJson(json);
}
