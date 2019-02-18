import 'package:flutter/material.dart';
import 'list_item.dart';
import '../../network/list.dart';

class ListPage extends StatefulWidget {
  //构造函数
  ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  //数据源
  List<ItemModel> _list = [];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    print('ListPage initState');
    super.initState();
    _loadData();
  }

  @override
  void didChangeDependencies() {
    print('ListPage didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(ListPage oldWidget) {
    print('ListPage didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    print('ListPage deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('ListPage dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("goingta’s工具链"),
          backgroundColor: Colors.blue, //设置appbar背景颜色
          centerTitle: true, //设置标题是否局中
        ),
        body: _list.length == 0
            ? new Center(child: CircularProgressIndicator())
            : new RefreshIndicator(
                onRefresh: _refresh,
                child: ListView.builder(
                    key: _refreshIndicatorKey,
                    itemCount: _list.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      ItemModel model = _list[index];
                      return new ListViewItem(model: model);
                    }),
              ),
      ),
    );
  }

  Future<Null> _refresh() async {
    _list.clear();
    _loadData();
    return null;
  }

  void _loadData() {
    PGYNetwork network = new PGYNetwork();
    network.getList((data, response) {
      List<ItemModel> arr = [];
      List list = data["list"];
      for (var item in list) {
        ItemModel model = new ItemModel.fromJson(item);
        arr.add(model);
      }

      setState(() {
        _list = arr;
      });
    });
  }
}
