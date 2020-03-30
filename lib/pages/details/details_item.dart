import 'package:flutter/material.dart';
import 'package:toolchain_flutter/theme/light_color.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:toast/toast.dart';
import 'package:flutter/services.dart';

import '../../model/item_model.dart';

class DetailsItem extends StatelessWidget {
  //属性
  final ItemModel model;

  //构造函数
  DetailsItem({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        height: 150.0,
        child: new Stack(children: <Widget>[
          new Container(
              child: ListTile(
                  title: Text(
                      "# 版本 ${model.buildVersion}(${model.buildBuildVersion}) 时间：${model.buildCreated}"),
                  subtitle: Text(
                      '${model.buildUpdateDescription.replaceAll("\n", "")}'))),
          new Positioned(
              right: 10.0,
              top: 80.0,
              child: new Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new FlatButton(
                        onPressed: () {
                          openWebUrl(context, model.toJson());
                        },
                        child: new Text("分享二维码",
                            style: TextStyle(color: LightColor.primaryColor))),
                    const SizedBox(width: 10.0),
                    new RaisedButton(
                        onPressed: () {
                          launchURL(context, model.buildKey);
                        },
                        child: new Text("安装",
                            style: TextStyle(color: Colors.white)),
                        color: LightColor.primaryColor)
                  ])),
        ]));
  }

  void launchURL(BuildContext context, String buildKey) {
    var url;
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (isIOS) {
      print("iOS install");
      url =
          "itms-services://?action=download-manifest&url=https://www.pgyer.com/app/plist/$buildKey";
    } else {
      print("Android install");
      url =
          "https://www.pgyer.com/apiv2/app/install?_api_key=87a96feb51f5ecdfafc2bc4c9eeb045a&buildKey=$buildKey";
    }
    print("url=" + url);
    launch(url);
  }

  void openWebUrl(BuildContext context, Map model) async {
    // String webUrl = "https://www.pgyer.com/$buildKey";
    // // launch(webUrl);
    // print("webUrl: $webUrl");
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (_) => new WebviewScaffold(
    //             url: webUrl, appBar: new AppBar(title: new Text("二维码")))));

    const platform = const MethodChannel('goingta.flutter.io/share');
    // bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    await platform.invokeMethod("shareToWechat", model);
  }
}
