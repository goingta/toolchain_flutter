import 'package:flutter/material.dart';
import 'package:toolchain_flutter/pages/tabPage/tabPage.dart';
import 'pages/tabPage/tabPage.dart';
import 'pages/login/login.dart';

void main() => runApp(App());

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '企鹅工具链',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Login(),
      // home: LifecycleAppPage(),
    );
  }
}


