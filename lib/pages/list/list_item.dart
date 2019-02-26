import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/itemModel.dart';

class ListViewItem extends StatelessWidget {
  //属性
  final ItemModel model;
  bool isIOS;

  //构造函数
  ListViewItem({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    isIOS = Theme.of(context).platform == TargetPlatform.iOS;
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
                          openWebUrl(model.buildKey);
                        },
                        child: new Text("分享二维码",
                            style: TextStyle(color: Colors.lightBlue))),
                    const SizedBox(width: 10.0),
                    new RaisedButton(
                        onPressed: () {
                          launchURL(model.buildKey);
                        },
                        child: new Text("安装",
                            style: TextStyle(color: Colors.white)),
                        color: Colors.lightBlue)
                  ])),
        ]));
  }

  void launchURL(String buildKey) {
    var url;
    if (isIOS) {
      print("iOS install");
      url =
          "itms-services://?action=download-manifest&url=https://www.pgyer.com/app/plist/$buildKey";
    } else {
      print("Android install");
      url =
          "https://www.pgyer.com/apiv2/app/install?_api_key=811e984eb5e760bb7f2885484c6c4edb&buildKey=$buildKey";
    }
    print("url=" + url);
    launch(url);
  }

  void openWebUrl(String buildKey) {
    String webUrl = "https://www.pgyer.com/$buildKey";
    launch(webUrl);
  }
}
