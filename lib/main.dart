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
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 2);
  }

  //当整个页面dispose时，记得把控制器也dispose掉，释放内存
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new TabBarView(
        controller: _tabController,
        children: <Widget>[new ListPage(), new AppletPage()],
      ),
      bottomNavigationBar: new Material(
        color: Colors.white,
        child: new TabBar(
          controller: _tabController,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.black26,
          tabs: <Widget>[
            new Tab(
              text: "工具链",
              icon: new Icon(Icons.brightness_5),
            ),
            new Tab(
              text: "小程序",
              icon: new Icon(Icons.map),
            )
          ],
        ),
      ),
    );
  }
}
