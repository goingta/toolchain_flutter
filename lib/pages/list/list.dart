//package
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//项目内的库
import 'list_item.dart';
import '../../network/list.dart';
import '../../model/itemModel.dart';
import '../../components/loadMore.dart';

class ListPage extends StatefulWidget {
  //构造函数
  ListPage({Key key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // 返回true

  @override
  void initState() {
    print('ListPage initState');
    super.initState();
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
            centerTitle: true //设置标题是否局
            ),
        body: new ListPageContainer(),
      ),
    );
  }
}

class ListPageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
        decoration: new BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            new BoxShadow(
              color: Colors.grey[200],
              offset: new Offset(0.0, 2.0),
              blurRadius: 4.0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, //子组件的排列方式为主轴两端对齐
          children: <Widget>[
            new ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset("images/logo.png", height: 88.0)),
            new Expanded(
                flex: 2,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text("工具链", style: TextStyle(fontSize: 24.0)),
                        new FlatButton(
                            onPressed: () {
                              _build(context);
                            },
                            child: new Text("构建新版本",
                                style: TextStyle(color: Colors.white)),
                            color: Colors.blue)
                      ],
                    ))),
            new Container(
                child: Container(
                    width: 90.0,
                    height: 30,
                    child: new Text("历史版本"),
                    alignment: Alignment.center,
                    color: Colors.grey[200]),
                alignment: Alignment.bottomCenter)
          ],
        ));
  }

  void _build(BuildContext context) async {
    PGYNetwork network = new PGYNetwork();
    Map<String, dynamic> data = await network.jenkinsBuild();
    Toast.show("触发成功！", context);
  }
}

class ListPageContainer extends StatefulWidget {
  @override
  _ListPageContainerState createState() => _ListPageContainerState();
}

class _ListPageContainerState extends State<ListPageContainer> {
  //数据源
  List<ItemModel> _list = [];
  bool _needLoadMore = true;
  int _page = 1;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  final ScrollController _scrollController = new ScrollController();

  void initState() {
    print('ListPageContainer initState');
    super.initState();
    _refresh();

    ///增加滑动监听
    _scrollController.addListener(() {
      ///判断当前滑动位置是不是到达底部，触发加载更多回调
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (_needLoadMore) {
          print("加载更多!");
          this._loadData(++_page);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        ListPageHeader(),
        Container(
            height: 1.0,
            decoration: new BoxDecoration(
                border: new Border.all(color: Colors.grey[200]))),
        Flexible(
            child: _list.length == 0
                ? new Center(child: SpinKitWave(color: Colors.blue))
                : new RefreshIndicator(
                    onRefresh: _refresh,
                    child: ListView.builder(
                        key: _refreshIndicatorKey,
                        itemCount: _list.length,

                        ///保持ListView任何情况都能滚动，解决在RefreshIndicator的兼容问题。
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return _getItem(index);
                        },
                        controller: _scrollController)))
      ],
    );
  }

  Future<Null> _refresh() async {
    _list.clear();
    _page = 1;
    await _loadData(_page);
    return null;
  }

  Future<Null> _loadData(int page) async {
    print("page:$page");
    PGYNetwork network = new PGYNetwork();
    List<ItemModel> arr = await network.getList(page: page);
    _needLoadMore = arr.isNotEmpty;
    print("数据加载完毕!");
    setState(() {
      _list.addAll(arr);
    });
  }

  _getItem(int index) {
    if (index == _list.length - 1) {
      return _needLoadMore ? LoadMore() : Container();
    } else {
      ItemModel model = _list[index];
      return new ListViewItem(model: model);
    }
  }
}
