import 'package:flutter/material.dart';
import 'package:toolchain_flutter/model/user_model.dart';
import 'package:toolchain_flutter/pages/tabPage/tabPage.dart';
import 'pages/tabPage/tabPage.dart';
import 'pages/tabPage/homePage.dart';
import 'pages/login/login.dart';
import 'model/user.dart';
import 'common/Global.dart';

void main() => Global.init().then((e) => runApp(App()));

class App extends StatelessWidget {
  final Color primaryColor = Color(0xff03da9d);
  final Color accentColor = Color(0xff333333);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '企鹅工具链',
      theme: ThemeData(
        primaryColor: primaryColor,
        accentColor: accentColor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(color: Colors.white),
        fontFamily: 'Rubik',
        textTheme: TextTheme(
          headline:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          button: TextStyle(color: Colors.white),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: primaryColor,
          textTheme: ButtonTextTheme.normal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.all(8),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(style: BorderStyle.none),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      home: FutureBuilder<UserModel>(
        future: User.getCurrentUser(),
        builder: (context, AsyncSnapshot<UserModel> user) {
          return user.hasData ? TabPage() : LoginPage();
        },
      ),
      // home: HomePage(),
      routes: {
        LoginPage.id: (context) => LoginPage(),
        TabPage.id: (context) => TabPage()
      },
      // home: LifecycleAppPage(),
    );
  }
}
