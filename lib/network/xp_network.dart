import 'package:toolchain_flutter/model/xp_build_item.dart';
import 'package:toolchain_flutter/model/xp_env.dart';
import 'package:toolchain_flutter/model/xp_program_item_model.dart';
import 'package:toolchain_flutter/server/xp_server.dart';

class XPNetwork {
  static XPServer _xpServer = XPServer();

  /// 获取应用列表
  Future<List<XPProgramItemModel>> getProgramList(
      List<int> xpProgramTypes) async {
    try {
      final Map<String, dynamic> jsonMap = await _xpServer.get(
        "open/api/apps",
        queryParameters: {
          "appTypes": xpProgramTypes.join(","),
        },
      );
      final dynamic content = jsonMap["data"];
      final List<dynamic> values = content['content'];
      return values != null
          ? values.map((item) => XPProgramItemModel.fromJson(item)).toList()
          : List.empty();
    } catch (e) {
      return Future.error(e);
    }
  }

  /// 获取构建历史
  Future<List<XPBuildItem>> getBuildHistory(int appId) async {
    try {
      final Map<String, dynamic> jsonMap =
          await _xpServer.get("open/api/build/histories/$appId");
      final List<dynamic> values = jsonMap['data'];
      return values != null
          ? values.map((item) => XPBuildItem.fromJson(item)).toList()
          : List.empty();
    } catch (e) {
      return Future.error(e);
    }
  }

  /// 发布
  Future<void> publish(
      int appId, XPBuildItem xpBuildItem, XPEnv xpEnv, String notes) async {
    try {
      await _xpServer.post(
        "open/api/release",
        queryParameters: {
          "appId": appId,
          "env": xpEnv.code,
        },
        data: {
          "buildId": xpBuildItem.buildId,
          "commitId": xpBuildItem.commitId,
          "ref": xpBuildItem.ref,
          "notes": notes,
        },
      );
    } catch (e) {
      return Future.error(e);
    }
  }
}
