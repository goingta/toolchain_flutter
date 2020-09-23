import 'package:flutter/material.dart';
import 'package:toolchain_flutter/pages/details/app_details_page.dart';
import 'package:toolchain_flutter/pages/details/xp_details_page.dart';
import 'package:toolchain_flutter/pages/home/home_page.dart';
import 'package:toolchain_flutter/pages/list/list_page.dart';
import 'package:toolchain_flutter/pages/list/xp_list_page.dart';
import 'package:toolchain_flutter/pages/login/login_page.dart';
import 'package:toolchain_flutter/pages/profile/profile_page.dart';
import 'package:toolchain_flutter/pages/splash/splash_page.dart';
import 'package:toolchain_flutter/pages/tab/tab_page.dart';
import 'package:toolchain_flutter/pages/webview/web_view_page.dart';

class Routes {
  static final _routes = {
    SplashPage.id: (context) => SplashPage(),
    LoginPage.id: (context) => LoginPage(),
    ListPage.id: (context, {arguments}) => ListPage(arguments: arguments),
    XPListPage.id: (context, {arguments}) => XPListPage(arguments: arguments),
    TabPage.id: (context) => TabPage(),
    HomePage.id: (context) => HomePage(),
    ProfilePage.id: (context) => ProfilePage(),
    AppDetailsPage.id: (context, {arguments}) =>
        AppDetailsPage(arguments: arguments),
    XPDetailsPage.id: (context, {arguments}) =>
        XPDetailsPage(arguments: arguments),
    WebViewPage.id: (context, {arguments}) => WebViewPage(arguments: arguments),
  };

  // ignore: top_level_function_literal_block
  static final onGenerateRoute = (RouteSettings settings) {
    // 统一处理
    final String name = settings.name;
    final Function pageContentBuilder = _routes[name];
    if (pageContentBuilder != null) {
      if (settings.arguments != null) {
        final Route route = MaterialPageRoute(
            builder: (context) =>
                pageContentBuilder(context, arguments: settings.arguments));
        return route;
      } else {
        final Route route = MaterialPageRoute(
            builder: (context) => pageContentBuilder(context));
        return route;
      }
    }
    return null;
  };
}
