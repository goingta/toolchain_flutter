import 'dart:io';

import 'package:toolchain_flutter/model/pgy_item_model.dart';
import 'package:toolchain_flutter/model/pgy_update_model.dart';
import 'package:toolchain_flutter/server/pgyer_server.dart';

class PGYNetwork {
  static PGYServer _pgyServer = new PGYServer();

  /// 分页获取所有版本
  Future<List<PGYItemModel>> getBuildList(
      int page, String apiKey, String appKey) async {
    try {
      final Map<String, dynamic> jsonMap = await _pgyServer.post(
        "apiv2/app/builds",
        formData: {
          "_api_key": apiKey,
          "appKey": appKey,
          "page": page,
        },
      );
      final List values = (jsonMap["data"] ?? {})["list"] ?? List.empty();
      return values.map((item) => PGYItemModel.fromJson(item)).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  /// 检查更新
  Future<PGYUpdateModel> checkUpdate() async {
    try {
      final Map<String, dynamic> jsonMap = await _pgyServer.post(
        "apiv2/app/check",
        formData: {
          "_api_key": "01f1afe385c48954fd713ba5d533b62c",
          "appKey": Platform.isIOS
              ? "4f55bb2a4d7f22a959204032c2042204"
              : "aad7f7999b29743c6820c113e92bdb5a",
        },
      );
      return PGYUpdateModel.fromJson(jsonMap["data"]);
    } catch (e) {
      return Future.error(e);
    }
  }
}
