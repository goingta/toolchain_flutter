import 'dart:async';

import 'package:flutter/material.dart';
import 'package:toolchain_flutter/common/global.dart';
import 'package:toolchain_flutter/model/user.dart';
import 'package:toolchain_flutter/pages/login/login_page.dart';
import 'package:toolchain_flutter/pages/tab/tab_page.dart';
import 'package:toolchain_flutter/router/nav_key.dart';
import 'package:fluwx_worker/fluwx_worker.dart' as fluwxWorker;

class SplashPage extends StatelessWidget {
  static const String id = "/";

  SplashPage() {
    Global.init();
    Timer(Duration(seconds: 1), () {
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
    return Container(
      child: Image.asset(
        'images/splash_image.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
