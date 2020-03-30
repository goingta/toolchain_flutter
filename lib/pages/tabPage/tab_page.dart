import 'package:flutter/material.dart';
import 'package:toolchain_flutter/pages/home/home_page.dart';
import 'package:toolchain_flutter/pages/list/list_page.dart';
import 'package:toolchain_flutter/pages/profile/profile.dart';
import '../../theme/light_color.dart';

class TabPage extends StatefulWidget {
  static const String id = "/tab";
  TabPage({Key key}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with SingleTickerProviderStateMixin {
  //属性
  int _tabindex;
  PageController _pageController;
  TabController _tabController;

  @override
  void initState() {
    print("tabController");
    super.initState();
    _pageController = new PageController();
    _tabController = new TabController(vsync: this, length: 2);
    _tabindex = 0;
  }

  //当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  BottomNavigationBarItem _bottomIcons(IconData icon) {
    return BottomNavigationBarItem(icon: Icon(icon), title: Text(""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new PageView(
        children: [
          new HomePage(),
          new ListPage(title: "我的收藏"),
          new ProfilePage()
        ],
        controller: _pageController,
        physics: new NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
      ),
      // body: TabBarView(
      //     controller: _tabController,
      //     children: [new ListPage(), new AppletPage()]),
      bottomNavigationBar: BottomNavigationBar(
          onTap: navigationTapped,
          currentIndex: _tabindex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: LightColor.primaryColor,
          unselectedItemColor: Colors.grey.shade300,
          type: BottomNavigationBarType.fixed,
          items: [
            _bottomIcons(Icons.home),
            _bottomIcons(Icons.star_border),
            _bottomIcons(Icons.person),
          ]
        ),
    );
  }

  void navigationTapped(int page) {
    //Animating Page
    _pageController.jumpToPage(page);
    // _tabController.index = page;
  }

  void onPageChanged(int page) {
    setState(() {
      this._tabindex = page;
    });
  }
}
