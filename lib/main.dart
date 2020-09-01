import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toolchain_flutter/notifier/version_update_change_notifier.dart';
import 'package:toolchain_flutter/pages/splash/splash_page.dart';
import 'package:toolchain_flutter/router/nav_key.dart';
import 'package:toolchain_flutter/router/routes.dart';
import 'package:toolchain_flutter/theme/theme.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: VersionUpdateChangeNotifier(),
        ),
      ],
      child: MaterialApp(
        title: '企鹅工具链',
        theme: AppTheme.lightTheme,
        initialRoute: SplashPage.id,
        onGenerateRoute: Routes.onGenerateRoute,
        navigatorKey: NavKey.navKey,
      ),
    );
  }
}
