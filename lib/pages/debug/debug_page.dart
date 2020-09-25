import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:toolchain_flutter/common/app_env.dart';
import 'package:toolchain_flutter/components/title_text.dart';
import 'package:toolchain_flutter/model/user.dart';
import 'package:toolchain_flutter/theme/theme.dart';
import 'package:toolchain_flutter/common/global.dart';
import '../../theme/light_color.dart';

class DebugPage extends StatefulWidget {
  static const String id = "/debug";

  @override
  _DebugState createState() => _DebugState();
}

class _DebugState extends State<DebugPage> {
  bool loading = false;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// 切换环境
  void _changeServer() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return _SelfEnvSelectDialogWidget();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: BoldText("调试菜单", fontSize: 24),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                  child: Padding(
                      padding: EdgeInsets.all(AppTheme.padding),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[Text("切换网络环境")])),
                  onTap: () {
                    _changeServer();
                  }),
              Padding(
                  padding: EdgeInsets.fromLTRB(
                      AppTheme.padding, 0, AppTheme.padding, 0),
                  child: TitleText("其他")),
              GestureDetector(
                  child: Padding(
                      padding: EdgeInsets.all(AppTheme.padding),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[Text("清楚缓存")])),
                  onTap: () {
                    Toast.show("清楚缓存成功！", context);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

/// 切换环境的 Dialog
class _SelfEnvSelectDialogWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SelfEnvSelectDialogWidgetState();
  }
}

class _SelfEnvSelectDialogWidgetState
    extends State<_SelfEnvSelectDialogWidget> {
  int _selfEnvGroupValue = Global.appEnv.code;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('温馨提示'),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text('修改网络环境，需要清除当前所有用户数据，并重启应用'),
            RadioListTile(
              title: Text(AppEnv.DEV.value),
              groupValue: _selfEnvGroupValue,
              value: AppEnv.DEV.code,
              onChanged: _selfEnvValueChanged,
            ),
            RadioListTile(
              title: Text(AppEnv.TEST.value),
              groupValue: _selfEnvGroupValue,
              value: AppEnv.TEST.code,
              onChanged: _selfEnvValueChanged,
            ),
            RadioListTile(
              title: Text(AppEnv.STAGING.value),
              groupValue: _selfEnvGroupValue,
              value: AppEnv.STAGING.code,
              onChanged: _selfEnvValueChanged,
            ),
            RadioListTile(
              title: Text(AppEnv.PROD.value),
              groupValue: _selfEnvGroupValue,
              value: AppEnv.PROD.code,
              onChanged: _selfEnvValueChanged,
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
          child: Text(
            '取消',
            style: TextStyle(color: LightColor.primaryColor),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text(
            '重启',
            style: TextStyle(color: LightColor.primaryColor),
          ),
          onPressed: () async {
            Navigator.of(context).pop();
            _setEnv();
            await User.signOut();
            //随便写一个操作，可以引起程序崩溃就行。
            exit(0);
          },
        )
      ],
    );
  }

  /// 设置环境
  Future<void> _setEnv() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt(
        Global.SHARED_PREFERENCES_KEY_CURRENT_APP_ENV, _selfEnvGroupValue);
    Global.appEnv = AppEnv.valueOf(_selfEnvGroupValue) ?? AppEnv.PROD;
    Toast.show("环境已切换，请手动杀掉应用，重新打开", context, duration: 3);
  }

  void _selfEnvValueChanged(value) {
    _selfEnvGroupValue = value;
    if (mounted) {
      setState(() {});
    }
  }
}
