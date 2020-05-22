import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:toolchain_flutter/pages/list/list_page.dart';
import 'package:toolchain_flutter/theme/light_color.dart';
import '../../common/basic.dart';

class HomeItem extends StatelessWidget {
  final HomeItemViewModel data;

  HomeItem({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const myIcons = <String, IconData>{
      "iOS": FontAwesome5Brands.app_store_ios,
      "Android": FontAwesome5Brands.android,
      "H5": FontAwesome5Brands.html5,
      "小程序": FontAwesome5Brands.weixin,
      "Java": FontAwesome5Brands.java,
      "Node": FontAwesome5Brands.node_js,
    };

    return Container(
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, ListPage.id,
                arguments: <String, dynamic>{'tid': this.data.tid, 'type':this.data.type});
          },
          child: Column(
            children: <Widget>[
              Icon(
                myIcons[this.data.type],
                size: 55,
                color: LightColor.primaryColor,
              ),
              SizedBox(height: 15),
              Text(
                this.data.title,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
        ));
  }
}

class HomeItemViewModel {
  /// 图标
  final String icon;

  /// 标题
  final String title;

  /// Key
  final String tid;

  final String type;

  const HomeItemViewModel({this.icon, this.title, this.tid, this.type});
}
