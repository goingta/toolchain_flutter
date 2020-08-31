import 'package:flutter/material.dart';
import 'package:toolchain_flutter/pages/home/home_page.dart';
import 'package:toolchain_flutter/pages/profile/profile_page.dart';
import 'package:toolchain_flutter/theme/light_color.dart';

class TabPage extends StatefulWidget {
  static const String id = "/tab";
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
    _currentTabindex = 0;
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
