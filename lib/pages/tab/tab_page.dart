import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:toolchain_flutter/common/global.dart';
import 'package:toolchain_flutter/pages/home/home_page.dart';
import 'package:toolchain_flutter/pages/profile/profile_page.dart';
import 'package:toolchain_flutter/theme/light_color.dart';
import 'package:toolchain_flutter/tools/version_check_util.dart';

class TabPage extends StatefulWidget {
  static const String id = "/tab_page";

  TabPage({Key key}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  // Tab 当前选中的 index
  int _currentTabIndex;

  // 所有的 tab 页面
  final List<Widget> _pages = [HomePage(), ProfilePage()];

  @override
  void initState() {
    super.initState();
    VersionCheckUtil.checkUpdate(context, false);
    _currentTabIndex = 0;
    Future.delayed(Duration(microseconds: 0)).then((value) =>
        Toast.show("当前工具链环境：${Global.appEnv.value}", context, duration: 2));
  }

  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(icon: Icon(icon), title: Text(""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentTabIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: navigationTapped,
        currentIndex: _currentTabIndex,
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
      _currentTabIndex = index;
    });
  }
}
