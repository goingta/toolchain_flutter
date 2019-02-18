import 'package:flutter/material.dart';
import 'pages/list/list.dart';
import 'pages/applet/applet.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '工具链',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabPage(),
      // home: LifecycleAppPage(),
    );
  }
}

class TabPage extends StatefulWidget {
  TabPage({Key key}) : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

PageController pageController;

class _TabPageState extends State<TabPage> with SingleTickerProviderStateMixin {
  //属性
  int _tabindex;
  List<Widget> _pages;
  Widget _listPage;
  Widget _appletPage;

  @override
  void initState() {
    print("tabController");
    super.initState();
    pageController = new PageController();
    _tabindex = 0;
    _listPage = new ListPage();
    _appletPage = new AppletPage();
    _pages = [_listPage, _appletPage];
  }

  //当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_tabindex);
    return Scaffold(
      body: new PageView(
        children: _pages,
        controller: pageController,
        physics: new NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: new BottomNavigationBar(
        onTap: navigationTapped,
        currentIndex: _tabindex,
        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              icon: new Icon(Icons.brightness_5), title: new Text("工具链")),
          new BottomNavigationBarItem(
              icon: new Icon(Icons.map), title: new Text("小程序"))
        ],
      ),
    );
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      this._tabindex = page;
    });
  }
}
