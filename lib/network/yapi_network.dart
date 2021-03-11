import 'package:toolchain_flutter/model/app_item_model.dart';
import 'package:toolchain_flutter/model/h5_item_model.dart';
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
      // final List values = jsonMap["data"];
      List values = [{"programType":1,"name":"医联","logo":"https://cdn-app-icon.pgyer.com/4/0/6/e/5/406e561da738ddcbd9d0498b9131dcee?x-oss-process=image/resize,m_lfit,h_120,w_120/format,jpg","desc":"医生端App","owner":"王聪","pgyApiKey":"87a96feb51f5ecdfafc2bc4c9eeb045a","pgyAppKey":"4ce2be3b8f9a05aa967ebf3007445e0e","jenkinsProjectName":"ios-medlinker","jenkinsToken":"ab5ca6249862f5a60ac451599b5d9937"},{"programType":1,"name":"象伢医生","logo":"https://cdn-app-icon.pgyer.com/9/1/5/4/7/9154761509b5645fcd03e6704dc02e3e?x-oss-process=image/resize,m_lfit,h_120,w_120/format,jpg","desc":"莉莉安项目","owner":"曾强","pgyApiKey":"87a96feb51f5ecdfafc2bc4c9eeb045a","pgyAppKey":"11a57dec60b5f35640624f284c4cfe67","jenkinsProjectName":"ios-lilian","jenkinsToken":"ab5ca6249862f5a60ac451599b5d9938"},{"programType":1,"name":"医联健康","logo":"https://cdn-app-icon.pgyer.com/e/5/6/5/e/e565e8634ccf6dc265cb31c82b552f5f?x-oss-process=image/resize,m_lfit,h_120,w_120/format,jpg","desc":"患者端App","owner":"刘烁欲","pgyApiKey":"87a96feb51f5ecdfafc2bc4c9eeb045a","pgyAppKey":"b3429914daff5a71349507eff9543808","jenkinsProjectName":"ios-medlinker","jenkinsToken":"ab5ca6249862f5a60ac451599b5d9937"}];
      if(programType == 2) {
        values = [{"programType":2,"name":"医联","logo":"https://cdn-app-icon.pgyer.com/4/0/6/e/5/406e561da738ddcbd9d0498b9131dcee?x-oss-process=image/resize,m_lfit,h_120,w_120/format,jpg","desc":"医生端App","owner":"彭道松","pgyApiKey":"87a96feb51f5ecdfafc2bc4c9eeb045a","pgyAppKey":"3509e633c760ce74ad41c5cab7926c1d","jenkinsProjectName":"android-medlinker","jenkinsToken":"ab5ca6249862f5a60ac451599b5d9931"},{"programType":2,"name":"象伢医生","logo":"https://cdn-app-icon.pgyer.com/9/1/5/4/7/9154761509b5645fcd03e6704dc02e3e?x-oss-process=image/resize,m_lfit,h_120,w_120/format,jpg","desc":"莉莉安项目","owner":"胡博超","pgyApiKey":"87a96feb51f5ecdfafc2bc4c9eeb045a","pgyAppKey":"88c253365026d8393f4b55897d47a782","jenkinsProjectName":"ios-lilian","jenkinsToken":"ab5ca6249862f5a60ac451599b5d9938"},{"programType":2,"name":"医联健康","logo":"https://cdn-app-icon.pgyer.com/e/5/6/5/e/e565e8634ccf6dc265cb31c82b552f5f?x-oss-process=image/resize,m_lfit,h_120,w_120/format,jpg","desc":"患者端App","owner":"何明阳","pgyApiKey":"87a96feb51f5ecdfafc2bc4c9eeb045a","pgyAppKey":"0843b21e532b7eaaf0fb1dc1d2fc6ac4","jenkinsProjectName":"ios-medlinker","jenkinsToken":"ab5ca6249862f5a60ac451599b5d9937"}];
      }
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
    } else if (programType == ProgramType.H5.code) {
      return H5ProgramItemModel.fromJson(item);
    } else {
      return ProgramItemModel.fromJson(item);
    }
  }
}
