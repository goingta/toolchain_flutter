import 'package:flutter/material.dart';

import 'applet_item.dart';
import '../../model/applet_model.dart';

class AppletPage extends StatefulWidget {
  //构造函数
  AppletPage({Key key}) : super(key: key);

  @override
  _AppletPageState createState() => _AppletPageState();
}

class _AppletPageState extends State<AppletPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // 返回true
  List<AppletModel> _list = [new AppletModel("images/tax.jpeg", "个税小程序")];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("小程序"),
        backgroundColor: Colors.blue, //设置appbar背景颜色
        centerTitle: true, //设置标题是否局中
      ),
      body: new ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          AppletModel model = _list[index];
          return new AppletViewItem(model: model);
        },
      ),
    );
  }
}
