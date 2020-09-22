import 'package:flutter/material.dart';
import 'package:toolchain_flutter/model/xp_program_item_model.dart';
import 'package:toolchain_flutter/pages/details/xp_details_page.dart';
import 'package:toolchain_flutter/router/nav_key.dart';

class XPListViewItem extends StatelessWidget {
  // 程序描述对象
  final XPProgramItemModel xpProgramItemModel;

  // 构造函数
  XPListViewItem({Key key, @required this.xpProgramItemModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Image.asset(
                "assets/images/list_default_logo.png",
                width: 80.0,
                height: 80.0,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    xpProgramItemModel.name,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text("中文名：" + xpProgramItemModel.chineseName,
                      style: TextStyle(
                        fontSize: 12,
                      )),
                  Text(
                    "开发语言：" + xpProgramItemModel.language,
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        onTap: () {
          NavKey.navKey.currentState.pushNamed(
            XPDetailsPage.id,
            arguments: {
              "xpProgramItemModel": xpProgramItemModel,
            },
          );
        },
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Colors.grey[300],
          ),
        ),
      ),
    );
  }
}
