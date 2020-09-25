import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluwx_worker/fluwx_worker.dart' as fluwxWorker;
import 'package:toast/toast.dart';
import 'package:toolchain_flutter/common/global.dart';
import 'package:toolchain_flutter/model/user.dart';
import 'package:toolchain_flutter/pages/login/login_page.dart';
import 'package:toolchain_flutter/pages/tab/tab_page.dart';
import 'package:toolchain_flutter/router/nav_key.dart';

class SplashPage extends StatelessWidget {
  static const String id = "/";

  SplashPage() {
    Global.init();
    Timer(Duration(seconds: 2), () {
      fluwxWorker
          .register(
              schema: Global.schema,
              corpId: Global.corpId,
              agentId: Global.agentId)
          .then((value) => User.getCurrentUser())
          .then((user) => NavKey.navKey.currentState
              .pushReplacementNamed(user == null ? LoginPage.id : TabPage.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(microseconds: 0)).then((value) =>
        Toast.show("当前工具链环境：${Global.appEnv.value}", context, duration: 2));
    return Container(
      child: Image.asset(
        'assets/images/splash_image.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
