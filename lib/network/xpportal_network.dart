import 'package:toolchain_flutter/model/xp_build_item.dart';
import 'package:toolchain_flutter/model/xp_program_item_model.dart';
import 'package:toolchain_flutter/server/xpportal_server.dart';

class XPPortalNetwork {
  static XPPortalServer _xpPortalServer = XPPortalServer();

  /// 获取应用列表
  Future<List<XPProgramItemModel>> getProgramList(String language) async {
    try {
      final Map<String, dynamic> jsonMap = await _xpPortalServer.get(
        "open/api/apps",
      );
      final dynamic content = jsonMap["data"];
      final List<dynamic> values = content['content'];
      return values != null
          ? values
              .map((item) => XPProgramItemModel.fromJson(item))
              .toList()
              .where((element) => element.language == language)
              .toList()
          : List.empty();
    } catch (e) {
      return Future.error(e);
    }
  }

  /// 获取构建历史
  Future<List<XPBuildItem>> getBuildHistory(int appId) async {
    try {
      final Map<String, dynamic> jsonMap =
          await _xpPortalServer.get("open/api/build/histories/${appId}");
      final List<dynamic> values = jsonMap['data'];
      return values != null
          ? values.map((item) => XPBuildItem.fromJson(item)).toList()
          : List.empty();
    } catch (e) {
      return Future.error(e);
    }
  }
}
