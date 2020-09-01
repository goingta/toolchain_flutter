import 'package:toolchain_flutter/model/app_item_model.dart';
import 'package:toolchain_flutter/model/mini_program_item_model.dart';
import 'package:toolchain_flutter/model/program_item_model.dart';
import 'package:toolchain_flutter/model/program_type.dart';
import 'package:toolchain_flutter/server/yapi_server.dart';

class YapiNetwork {
  static YapiServer _yApiServer = YapiServer();

  Future<List<ProgramItemModel>> getProgramList(int programType) async {
    try {
      final Map<String, dynamic> jsonMap = await _yApiServer.get(
        "open/api/program",
        queryParameters: {"programType": programType},
      );
      final List values = jsonMap["data"];
      return values != null
          ? values
              .map((item) => _convertToProgramItemModel(programType, item))
              .toList()
          : List.empty();
    } catch (e) {
      return Future.error(e);
    }
  }

  ProgramItemModel _convertToProgramItemModel(int programType, dynamic item) {
    if (programType == ProgramType.MINI_PROGRAM.code) {
      return MiniProgramItemModel.fromJson(item);
    } else if (programType == ProgramType.IOS.code ||
        programType == ProgramType.ANDROID.code) {
      return AppItemModel.fromJson(item);
    } else {
      return ProgramItemModel.fromJson(item);
    }
  }
}
