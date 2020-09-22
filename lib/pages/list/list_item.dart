import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'package:toolchain_flutter/model/app_item_model.dart';
import 'package:toolchain_flutter/model/mini_program_item_model.dart';
import 'package:toolchain_flutter/model/program_item_model.dart';
import 'package:toolchain_flutter/model/program_type.dart';
import 'package:toolchain_flutter/pages/details/app_details_page.dart';
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
                        onPressed: () {
                          //此处判断调用H5，小程序Sheet
                          if (programItemModel.programType ==
                              ProgramType.MINI_PROGRAM) {
                            _smallProgramSelectionDialog(context, "share");
                          }
                        },
                      ),
                      FlatButton(
                        child: Text(
                          "打开",
                          style: TextStyle(
                            color: LightColor.primaryColor,
                          ),
                        ),
                        onPressed: () {
                          //此处判断调用H5，小程序Sheet
                          if (programItemModel.programType ==
                              ProgramType.MINI_PROGRAM) {
                            _smallProgramSelectionDialog(context, "open");
                          }
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
    }

    // const platform = const MethodChannel('goingta.flutter.io/share');
    // await platform.invokeMethod("gotoWechat", model.programName);
    // Navigator.pushNamed(context, DetailsPage.id,arguments: {"title":model.name, "model": model});
    // if (model.type == "h5") {
    //   Navigator.push(
    //     context,
    //     new MaterialPageRoute(
    //         builder: (context) => new WebViewPage(
    //             title: "云诊室",
    //             url: "https://open.xingren.com/consult/assistant/index")),
    //   );
    // } else if (model.type == "ios") {
    //   Navigator.pushNamed(context, DetailsPage.id,
    //       arguments: {"title": model.name, "model": model});
    // } else {
    //   const platform = const MethodChannel('goingta.flutter.io/share');
    //   await platform.invokeMethod("gotoWechat", "gh_ace42616fd18");
    // }
  }

  /// 显示版本分享打开选择 Dialog
  void _smallProgramSelectionDialog(
    BuildContext context,
    String type,
  ) {
    Map dic = {"share": "分享", "open": "打开"};
    showModalBottomSheet(
        context: context,
        builder: (BuildContext dialogContext) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Text(
                  "小程序三个版本应用场景不同请自行选择${dic[type]}版本",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ),
              Divider(
                height: 0.5,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(dialogContext);
                  _trigger(context, "test", type);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Text(
                    "研发版",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Divider(
                height: 0.5,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(dialogContext);
                  _trigger(context, "preview", type);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Text(
                    "体验版",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Divider(
                height: 0.5,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(dialogContext);
                  _trigger(context, "release", type);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Text(
                    "线上版",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          );
        });
  }

  /// 构建新版本
  void _trigger(BuildContext context, String programType, String type) async {
    // 找插件判断是否安装微信
    const platform = const MethodChannel('goingta.flutter.io/share');
    if (type == "open") {
      await platform.invokeMethod("gotoWechat", {
        "appid": (programItemModel as MiniProgramItemModel).appId,
        "programType": programType
      });
    }
    if (type == "share") {
      await platform.invokeMethod("sendReqToWechat", {
        "type": "miniProgram",
        "title": programItemModel.name,
        "description": programItemModel.desc,
        "mediaTagName": programItemModel.name,
        //小程序分享特有配置
        "pageUrl": (programItemModel as MiniProgramItemModel).appId,
        "userName": (programItemModel as MiniProgramItemModel).appId,
        "hdImageData": programItemModel.logo,
        "programType": programType,
      });
    }
    Toast.show("触发成功！", context);
  }
}
