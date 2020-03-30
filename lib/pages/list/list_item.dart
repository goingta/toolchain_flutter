import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/applet_model.dart';

class ListViewItem extends StatelessWidget {
  //属性
  final AppletModel model;

  //构造函数
  ListViewItem({Key key, @required this.model}) : super(key: key);

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
              launchURL(context, model);
            }),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1.0, color: Colors.grey[300]))));
  }

  void launchURL(BuildContext context, AppletModel model) async {
    const platform = const MethodChannel('goingta.flutter.io/share');
    await platform.invokeMethod("gotoWechat", model.programName);
  }
}
