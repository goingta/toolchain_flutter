import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:toolchain_flutter/model/pgy_item_model.dart';
import 'package:toolchain_flutter/model/program_type.dart';
import 'package:toolchain_flutter/theme/light_color.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

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
      height: 150.0,
      child: new Stack(
        children: <Widget>[
          new Container(
              child: ListTile(
                  title: Text(
                      "# 版本 ${pgyItemModel.buildVersion}(${pgyItemModel.buildBuildVersion}) 时间：${pgyItemModel.buildCreated}"),
                  subtitle: Text(
                      '${pgyItemModel.buildUpdateDescription.replaceAll("\n", "")}'))),
          new Positioned(
            right: 10.0,
            top: 80.0,
            child: new Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                const SizedBox(
                  width: 10.0,
                ),
                new RaisedButton(
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
          ),
        ],
      ),
    );
  }

  /*
   * 安装
   */
  void install(BuildContext context, String buildKey) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    print("isIos = $isIOS, programType = $programType");
    if ((programType == ProgramType.IOS && !isIOS) ||
        (programType == ProgramType.ANDROID && isIOS)) {
      Toast.show("当前系统与程序不匹配，无法安装", context);
      return;
    }
    String url = "";
    if (isIOS) {
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
