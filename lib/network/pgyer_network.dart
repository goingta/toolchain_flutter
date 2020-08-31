import 'package:toolchain_flutter/model/pgy_item_model.dart';
import 'package:toolchain_flutter/server/pgyer_server.dart';

class PGYNetwork {
  static PGYServer _pgyServer = new PGYServer();

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
}
