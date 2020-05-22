import 'package:flutter/material.dart';
import 'package:toolchain_flutter/model/user_model.dart';
import 'package:toolchain_flutter/pages/details/details_page.dart';
import 'package:toolchain_flutter/pages/home/home_page.dart';
import 'package:toolchain_flutter/pages/list/list_page.dart';
import 'package:toolchain_flutter/pages/profile/profile.dart';
import 'package:toolchain_flutter/pages/tabPage/tab_page.dart';
import 'package:toolchain_flutter/theme/light_color.dart';
import 'pages/login/login.dart';
import 'model/user.dart';
import 'common/Global.dart';

void main() => Global.init().then((e) => runApp(App()));

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '企鹅工具链',
      theme: ThemeData(
        primaryColor: LightColor.primaryColor,
        accentColor: LightColor.accentColor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(color: Colors.white),
        fontFamily: 'Rubik',
        textTheme: TextTheme(
          headline:
              TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          button: TextStyle(color: Colors.white),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: LightColor.primaryColor,
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
        TabPage.id: (context) => TabPage(),
        HomePage.id: (context) => HomePage(),
        ProfilePage.id: (context) => ProfilePage(),
        DetailsPage.id: (context) {
          Map<String,dynamic> args = ModalRoute.of(context).settings.arguments;
          //{"title":model.name,"type":1,"logo":"images/health_logo.png"}
          return DetailsPage(title: args["title"],model: args["model"]);
        },
        ListPage.id: (context) {
          Map<String,dynamic> args = ModalRoute.of(context).settings.arguments;
          return ListPage(title:args["type"]);
        }
      },
      // home: LifecycleAppPage(),
    );
  }
}
