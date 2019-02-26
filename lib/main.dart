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

  @override
  Widget build(BuildContext context) {
    print("tabIndex $_tabindex");
    return Scaffold(
      body: new PageView(
        children: [new ListPage(), new AppletPage()],
        controller: _pageController,
        physics: new NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
      ),
      // body: TabBarView(
      //     controller: _tabController,
      //     children: [new ListPage(), new AppletPage()]),
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
    _pageController.jumpToPage(page);
    // _tabController.index = page;
  }

  void onPageChanged(int page) {
    setState(() {
      this._tabindex = page;
    });
  }
}
