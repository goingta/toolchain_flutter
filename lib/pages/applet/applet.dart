import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("小程序"),
          backgroundColor: Colors.blue, //设置appbar背景颜色
          centerTitle: true, //设置标题是否局中
        ),
        body: new Center(
          child: new Text('敬请期待'),
        ),
      ),
    );
  }
}
