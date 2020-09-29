import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toolchain_flutter/model/app_item_model.dart';
import 'package:toolchain_flutter/model/pgy_item_model.dart';
import 'package:toolchain_flutter/model/program_type.dart';
import 'package:toolchain_flutter/theme/light_color.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluwx/fluwx.dart' as Fluwx;
import 'package:fluwx/fluwx.dart';
import 'package:toast/toast.dart';

class AppDetailsItem extends StatelessWidget {
  // 属性
  final PGYItemModel pgyItemModel;

  // 程序
  final AppItemModel appItemModel;

  //构造函数
  AppDetailsItem({
    Key key,
    @required this.pgyItemModel,
    @required this.appItemModel,
  }) : super(key: key);

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
            children: [
              new FlatButton(
                onPressed: () {
                  this.shareUrl(context);
                },
                child: new Text(
                  "分享二维码",
                  style: TextStyle(
                    color: LightColor.primaryColor,
                  ),
                ),
              ),
              ((appItemModel.programType == ProgramType.IOS &&
                          !Platform.isIOS) ||
                      (appItemModel.programType == ProgramType.ANDROID &&
                          !Platform.isAndroid))
                  ? SizedBox.shrink()
                  : const SizedBox(
                      width: 10.0,
                    ),
              ((appItemModel.programType == ProgramType.IOS &&
                          !Platform.isIOS) ||
                      (appItemModel.programType == ProgramType.ANDROID &&
                          !Platform.isAndroid))
                  ? SizedBox.shrink()
                  : RaisedButton(
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
          "https://www.pgyer.com/apiv2/app/install?_api_key=${appItemModel.pgyApiKey}&buildKey=$buildKey";
    }
    launch(url);
  }

  /*
   *  分享
   */

  void shareUrl(
    BuildContext context,
  ) async {
    var result = await Fluwx.isWeChatInstalled;
    if (!result) {
      Toast.show("未安装微信！", context);
      return;
    }
    var model = WeChatShareWebPageModel(
        "https://www.pgyer.com/${pgyItemModel.buildKey}",
        thumbnail: WeChatImage.asset("assets/images/share_logo.png"),
        title: "${appItemModel.name} - ${appItemModel.programType.value}",
        description:
            "${pgyItemModel.buildVersion}(${pgyItemModel.buildVersionNo}) [${pgyItemModel.buildBuildVersion}]",
        mediaTagName: pgyItemModel.buildVersion);
    var shareResult = await Fluwx.shareToWeChat(model);
    if (!shareResult) {
      Toast.show("分享失败！", context);
    }
  }
}
