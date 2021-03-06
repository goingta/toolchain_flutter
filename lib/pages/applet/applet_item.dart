import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:flutter/services.dart';

import '../../model/applet_model.dart';

class AppletViewItem extends StatelessWidget {
  //属性
  final AppletModel model;

  //构造函数
  AppletViewItem({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        height: 90.0,
        child: new GestureDetector(
            child: new Row(children: <Widget>[
              new Padding(
                  padding: EdgeInsets.all(10.0),
                  child: new Image.asset(model.icon)),
              new Text(model.title, style: TextStyle(fontSize: 22))
            ]),
            onTap: () {
              launchURL(context);
            }),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1.0, color: Colors.grey[300]))));
  }

  void launchURL(BuildContext context) async {
    const platform = const MethodChannel('goingta.flutter.io/share');
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    if (isIOS) {
      await platform.invokeMethod("gotoWechat", "gh_3ebf96e60b74");
    } else {
      Toast.show("Android版Native方法暂未实现！", context);
    }
  }
}
