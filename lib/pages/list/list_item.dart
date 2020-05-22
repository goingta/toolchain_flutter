import 'package:flutter/material.dart';
import 'package:toolchain_flutter/model/item_model.dart';
import 'package:toolchain_flutter/pages/details/details_page.dart';


class ListViewItem extends StatelessWidget {
  //属性e
  final ItemModel model;

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
                  child: model.logo == "" || model.logo == null ? Image.asset("images/list_default_logo.png"):Image.network(
                                  model.logo,
                                  width: 80.0,
                                  height: 80.0,
                                  fit: BoxFit.cover)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text(model.name, style: TextStyle(fontSize: 18)),
                  new Text("别名："+model.alias, style: TextStyle(fontSize: 12)),
                  new Text("负责人："+model.owner, style: TextStyle(fontSize: 12))
                ],
              )
            ]),
            onTap: () {
              launchURL(context, model);
            }),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1.0, color: Colors.grey[300]))));
  }

  void launchURL(BuildContext context, ItemModel model) async {
    // const platform = const MethodChannel('goingta.flutter.io/share');
    // await platform.invokeMethod("gotoWechat", model.programName);
    Navigator.pushNamed(context, DetailsPage.id,arguments: {"title":model.name, "model": model});
  }
}
