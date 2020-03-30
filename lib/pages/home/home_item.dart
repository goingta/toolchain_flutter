import 'package:flutter/material.dart';
import 'package:toolchain_flutter/pages/list/list_page.dart';
import 'package:toolchain_flutter/theme/light_color.dart';

class HomeItem extends StatelessWidget {
  final HomeItemViewModel data;

  HomeItem({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const myIcons = <String, IconData> {
      'explore': Icons.explore,
      'android': Icons.android,
      'language': Icons.language,
      'backup': Icons.backup,
      'polymer': Icons.polymer,
    };

    return Container(
      alignment: Alignment.center,
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, ListPage.id);
        },
        child: Column(
          children: <Widget>[
            Icon(
              myIcons[this.data.icon],
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
      )
    );
  }
}

class HomeItemViewModel {
  /// 图标
  final String icon;

  /// 标题
  final String title;

  /// Key
  final String tid;

  const HomeItemViewModel({
    this.icon,
    this.title,
    this.tid
  });
}
