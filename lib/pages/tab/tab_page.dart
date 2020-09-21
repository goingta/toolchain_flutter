import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:toolchain_flutter/model/pgy_update_model.dart';
import 'package:toolchain_flutter/network/pgyer_network.dart';
import 'package:toolchain_flutter/notifier/version_update_change_notifier.dart';
import 'package:toolchain_flutter/pages/home/home_page.dart';
import 'package:toolchain_flutter/pages/profile/profile_page.dart';
import 'package:toolchain_flutter/theme/light_color.dart';

class TabPage extends StatefulWidget {
  static const String id = "/tab_page";
  TabPage({Key key}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  // Tab 当前选中的 index
  int _currentTabindex;
  // 所有的 tab 页面
  final List<Widget> _pages = [HomePage(), ProfilePage()];

  @override
  void initState() {
    super.initState();
    _checkUpdate();
    _currentTabindex = 0;
  }

  /// 检查更新
  Future<void> _checkUpdate() async {
    try {
      PGYUpdateModel pgyUpdateModel = await PGYNetwork().checkUpdate();
      if (pgyUpdateModel != null) {
        final int serverVersion = int.parse(pgyUpdateModel.buildVersion
            .split(".")
            .reduce((value, element) => value + element));
        // 判断版本号
        final int currentVersion = int.parse((await PackageInfo.fromPlatform())
            .version
            .split(".")
            .reduce((value, element) => value + element));
        print(
            "currentVersion = $currentVersion, serviceVersion = $serverVersion");
        if (serverVersion > currentVersion) {
          VersionUpdateChangeNotifier versionUpdateChangeNotifier =
              Provider.of<VersionUpdateChangeNotifier>(context, listen: false);
          versionUpdateChangeNotifier.downloadURL = pgyUpdateModel.downloadURL;
          versionUpdateChangeNotifier.hasNewVersion = true;
          Toast.show("有版本更新，请及时更新哟~", context);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(icon: Icon(icon), title: Text(""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentTabindex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: navigationTapped,
        currentIndex: _currentTabindex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: LightColor.primaryColor,
        unselectedItemColor: Colors.grey.shade300,
        type: BottomNavigationBarType.fixed,
        items: [
          _bottomIcons(Icons.home),
          _bottomIcons(Icons.person),
        ],
      ),
    );
  }

  void navigationTapped(int index) {
    setState(() {
      _currentTabindex = index;
    });
  }
}
