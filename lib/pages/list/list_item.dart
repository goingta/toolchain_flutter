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
import 'package:fluwx/fluwx.dart' as Fluwx;
import 'package:toast/toast.dart';

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
                          } else if (programItemModel is H5ProgramItemModel) {
                            _h5ProgramSelectionDialog(
                                context, "share", programItemModel);
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
                          } else if (programItemModel is H5ProgramItemModel) {
                            _h5ProgramSelectionDialog(
                                context, "open", programItemModel);
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
  }

  /// H5分享打开选择 Dialog
  void _h5ProgramSelectionDialog(
    BuildContext context,
    String type,
    H5ProgramItemModel h5ProgramItemModel,
  ) {
    if (h5ProgramItemModel.envs.length <= 0) {
      return;
    }
    showModalBottomSheet(
        context: context,
        builder: (BuildContext dialogContext) {
          return SafeArea(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Text(
                  "请选择${type == "open" ? "打开" : "分享"}环境",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ),
              ListView.separated(
                itemBuilder: (context, index) {
                  H5Env h5Env = h5ProgramItemModel.envs[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pop(dialogContext);
                      if (type == "open") {
                        NavKey.navKey.currentState
                            .pushNamed(WebViewPage.id, arguments: {
                          "title": "${h5ProgramItemModel.name} - ${h5Env.name}",
                          "url": h5Env.url,
                        });
                      } else if (type == "share") {
                        _shareH5(h5Env);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: Text(
                        h5Env.name,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 0.5,
                  );
                },
                itemCount: h5ProgramItemModel.envs.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
            ],
          ));
        });
  }

  /// 分享 h5
  Future<void> _shareH5(H5Env h5env) async {
    await MethodChannel('goingta.flutter.io/share')
        .invokeMethod("sendReqToWechat", {
      "type": "webPage",
      "title": "${programItemModel.name} - ${h5env.name}",
      "description": programItemModel.desc,
      "mediaTagName": programItemModel.name,
      "pageUrl": h5env.url,
    });
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
          return SafeArea(
              child: Column(
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
          ));
        });
  }

  /// 构建新版本
  void _trigger(BuildContext context, String programType, String type) async {
    if (Fluwx.isWeChatInstalled != null) {
    } else {
      Toast.show("未安装微信！", context);
    }

    return;
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
        "pageUrl": "https://www.xingren.com",
        "path": "",
        "userName": (programItemModel as MiniProgramItemModel).appId,
        "withShareTicket": false,
        "hdImageData": programItemModel.logo,
        "programType": programType,
      });
    }
  }
}
