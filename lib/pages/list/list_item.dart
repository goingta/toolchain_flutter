import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toolchain_flutter/model/app_item_model.dart';
import 'package:toolchain_flutter/model/h5_item_model.dart';
import 'package:toolchain_flutter/model/mini_program_item_model.dart';
import 'package:toolchain_flutter/model/program_item_model.dart';
import 'package:toolchain_flutter/model/program_type.dart';
import 'package:toolchain_flutter/pages/details/app_details_page.dart';
import 'package:toolchain_flutter/pages/webview/web_view_page.dart';
import 'package:toolchain_flutter/router/nav_key.dart';
import 'package:toolchain_flutter/theme/light_color.dart';

class ListViewItem extends StatelessWidget {
  // 程序描述对象
  final ProgramItemModel programItemModel;

  // 构造函数
  ListViewItem({Key key, @required this.programItemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: programItemModel.logo == "" ||
                          programItemModel.logo == null
                      ? Image.asset(
                          "assets/images/list_default_logo.png",
                          width: 80.0,
                          height: 80.0,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          programItemModel.logo,
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
                        programItemModel.name,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "描述：" + programItemModel.desc,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "负责人：" + programItemModel.owner,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            (programItemModel.programType == ProgramType.H5 ||
                    programItemModel.programType == ProgramType.MINI_PROGRAM)
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlatButton(
                        child: Text(
                          "分享",
                          style: TextStyle(
                            color: LightColor.primaryColor,
                          ),
                        ),
                        onPressed: () {},
                      ),
                      FlatButton(
                        child: Text(
                          "打开",
                          style: TextStyle(
                            color: LightColor.primaryColor,
                          ),
                        ),
                        onPressed: () {
                          launchURL(context, programItemModel);
                        },
                      ),
                    ],
                  )
                : SizedBox.shrink(),
          ],
        ),
        onTap: (programItemModel.programType == ProgramType.MINI_PROGRAM ||
                programItemModel.programType == ProgramType.H5)
            ? null
            : () {
                launchURL(context, programItemModel);
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

  void launchURL(
      BuildContext context, ProgramItemModel programItemModel) async {
    if (programItemModel is MiniProgramItemModel) {
      const platform = const MethodChannel('goingta.flutter.io/share');
      await platform.invokeMethod("gotoWechat", programItemModel.appId);
    } else if (programItemModel is AppItemModel) {
      NavKey.navKey.currentState.pushNamed(
        AppDetailsPage.id,
        arguments: {
          "appItemModel": programItemModel,
        },
      );
    } else if (programItemModel is H5ProgramItemModel) {
      NavKey.navKey.currentState.pushNamed(WebViewPage.id, arguments: {
        "title": "云诊室",
        "url": "https://open.xingren.com/consult/assistant/index",
      });
    }
  }
}
