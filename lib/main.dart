import 'package:flutter/material.dart';
import 'package:toolchain_flutter/pages/splash/splash_page.dart';
import 'package:toolchain_flutter/router/nav_key.dart';
import 'package:toolchain_flutter/router/routes.dart';
import 'package:toolchain_flutter/theme/theme.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '企鹅工具链',
      theme: AppTheme.lightTheme,
      initialRoute: SplashPage.id,
      onGenerateRoute: Routes.onGenerateRoute,
      navigatorKey: NavKey.navKey,
    );
  }
}
