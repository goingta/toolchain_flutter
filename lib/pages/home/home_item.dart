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
    const myIcons = <AppType, IconData>{
      AppType.ios: FontAwesome5Brands.app_store_ios,
      AppType.android: FontAwesome5Brands.android,
      AppType.h5: FontAwesome5Brands.html5,
      AppType.weapp: FontAwesome5Brands.weixin,
      AppType.java: FontAwesome5Brands.java,
      AppType.node: FontAwesome5Brands.node_js,
    };

    return Container(
        alignment: Alignment.center,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, ListPage.id);
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

  final AppType type;

  const HomeItemViewModel({this.icon, this.title, this.tid, this.type});
}
