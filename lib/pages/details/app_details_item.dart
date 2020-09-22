import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toolchain_flutter/model/pgy_item_model.dart';
import 'package:toolchain_flutter/model/program_type.dart';
import 'package:toolchain_flutter/theme/light_color.dart';
import 'package:url_launcher/url_launcher.dart';

class AppDetailsItem extends StatelessWidget {
  // 属性
  final PGYItemModel pgyItemModel;

  // 程序类型
  final ProgramType programType;

  // 蒲公英 _api_key
  final String pgyApiKey;

  //构造函数
  AppDetailsItem(
      {Key key,
      @required this.pgyItemModel,
      @required this.programType,
      @required this.pgyApiKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "版本：${pgyItemModel.buildVersion}(${pgyItemModel.buildVersionNo}) [${pgyItemModel.buildBuildVersion}]\n时间：${pgyItemModel.buildCreated}",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '${pgyItemModel.buildUpdateDescription}',
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              new FlatButton(
                onPressed: () {
                  share(context, pgyItemModel.toJson());
                },
                child: new Text(
                  "分享二维码",
                  style: TextStyle(
                    color: LightColor.primaryColor,
                  ),
                ),
              ),
              ((programType == ProgramType.IOS && !Platform.isIOS) ||
                      (programType == ProgramType.ANDROID &&
                          !Platform.isAndroid))
                  ? SizedBox.shrink()
                  : const SizedBox(
                      width: 10.0,
                    ),
              ((programType == ProgramType.IOS && !Platform.isIOS) ||
                      (programType == ProgramType.ANDROID &&
                          !Platform.isAndroid))
                  ? SizedBox.shrink()
                  : new RaisedButton(
                      onPressed: () {
                        install(context, pgyItemModel.buildKey);
                      },
                      child: new Text(
                        "安装",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: LightColor.primaryColor,
                    )
            ],
          ),
        ],
      ),
    );
  }

  /*
   * 安装
   */
  void install(BuildContext context, String buildKey) {
    String url = "";
    if (Platform.isIOS) {
      url =
          "itms-services://?action=download-manifest&url=https://www.pgyer.com/app/plist/$buildKey";
    } else {
      url =
          "https://www.pgyer.com/apiv2/app/install?_api_key=$pgyApiKey&buildKey=$buildKey";
    }
    launch(url);
  }

  /*
   *  分享
   */
  void share(BuildContext context, Map model) async {
    const platform = const MethodChannel('goingta.flutter.io/share');
    await platform.invokeMethod("shareToWechat", model);
  }
}
