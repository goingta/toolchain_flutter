import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:toolchain_flutter/model/program_type.dart';
import 'package:toolchain_flutter/pages/list/list_page.dart';
import 'package:toolchain_flutter/router/nav_key.dart';
import 'package:toolchain_flutter/theme/light_color.dart';

class HomeItem extends StatelessWidget {
  final HomeItemViewModel data;

  HomeItem({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<ProgramType, IconData> myIcons = {
      ProgramType.IOS: FontAwesome5Brands.app_store_ios,
      ProgramType.ANDROID: FontAwesome5Brands.android,
      ProgramType.H5: FontAwesome5Brands.html5,
      ProgramType.MINI_PROGRAM: FontAwesome5Brands.weixin,
      ProgramType.JAVA: FontAwesome5Brands.java,
      ProgramType.NODE: FontAwesome5Brands.node_js,
    };

    return InkWell(
      onTap: () {
        NavKey.navKey.currentState.pushNamed(
          ListPage.id,
          arguments: {
            'programType': this.data.programType,
          },
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            myIcons[this.data.programType],
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
    );
  }
}

class HomeItemViewModel {
  /// 图标
  final String icon;

  /// 标题
  final String title;

  // 程序类型
  final ProgramType programType;

  const HomeItemViewModel({this.icon, this.title, this.programType});
}
