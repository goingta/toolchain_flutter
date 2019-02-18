import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemModel {
  String buildKey;
  String buildFileSize;
  String buildVersion;
  String buildUpdateDescription;
  String buildBuildVersion;
  String buildCreated;

  ItemModel(
      {this.buildKey,
      this.buildFileSize,
      this.buildVersion,
      this.buildUpdateDescription,
      this.buildBuildVersion,
      this.buildCreated});

  ItemModel.fromJson(Map<String, dynamic> json)
      : buildKey = json['buildKey'],
        buildFileSize = json['buildFileSize'],
        buildVersion = json['buildVersion'],
        buildUpdateDescription = json['buildUpdateDescription'],
        buildBuildVersion = json['buildBuildVersion'],
        buildCreated = json['buildCreated'];

  Map<String, dynamic> toJson() => {
        'buildKey': buildKey,
        'buildFileSize': buildFileSize,
        'buildVersion': buildVersion,
        'buildUpdateDescription': buildUpdateDescription,
        'buildBuildVersion': buildBuildVersion,
        'buildCreated': buildCreated,
      };
}

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
                    new Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        child: new RaisedButton(
                            onPressed: () {
                              openWebUrl(model.buildKey);
                            },
                            child: new Text("分享",
                                style: TextStyle(color: Colors.white)),
                            color: Colors.lightBlue)),
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
    if (isIOS) {
      print("ios install");
      String url =
          "itms-services://?action=download-manifest&url=https://www.pgyer.com/app/plist/$buildKey";
      print("url=" + url);
      launch(url);
    } else {
      print("Android包地址");
    }
  }

  void openWebUrl(String buildKey) {
    String webUrl = "https://www.pgyer.com/$buildKey";
    launch(webUrl);
  }
}
