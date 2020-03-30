import 'package:flutter/material.dart';
import 'package:toolchain_flutter/theme/light_color.dart';

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
  List<AppletModel> _list = [
    new AppletModel(
        "images/aboutus_healthLife.png", "企鹅家庭医生", "gh_3734c6c0be0a"),
    new AppletModel("images/aboutus_step.png", "乱步挑战", "gh_8fa9da3971e7"),
    new AppletModel("images/aboutus_vaccine.png", "企鹅疫苗小助手", "gh_30479e47f009"),
    new AppletModel("images/aboutus_terminal.png", "企鹅健康终端", "gh_eb1c9a3dc898"),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("小程序",style: TextStyle(color: Colors.white)),
        backgroundColor: LightColor.primaryColor, //设置appbar背景颜色
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
