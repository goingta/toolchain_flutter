//package
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toolchain_flutter/pages/details/details_item.dart';
import 'package:toolchain_flutter/theme/light_color.dart';

//项目内的库
import '../../network/pgyer_network.dart';
import '../../network/jenkins_network.dart';
import '../../model/item_model.dart';
import '../../components/loadMore.dart';

class DetailsPage extends StatefulWidget {
  static const String id = "/details";
  final String title;
  final int type;
  final String logo;
  //构造函数
  DetailsPage({Key key, this.title, this.type, this.logo}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<DetailsPage>
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
  void didUpdateWidget(DetailsPage oldWidget) {
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
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(this.widget.title, style: TextStyle(color: Colors.white)),
          backgroundColor: LightColor.primaryColor, //设置appbar背景颜色
          centerTitle: true, //设置标题是否局
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          ),
      body: new ListPageContainer(
          title: this.widget.title,
          type: this.widget.type,
          logo: this.widget.logo),
    );
  }
}

class ListPageHeader extends StatelessWidget {
  final String title;
  final String logo;
  final int type;

  ListPageHeader({this.title, this.type, this.logo}) : super();

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
                child: Image.asset(this.logo, height: 88.0)),
            new Expanded(
                flex: 2,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(this.title, style: TextStyle(fontSize: 24.0)),
                        this.type == 1
                            ? new FlatButton(
                                onPressed: () {
                                  _build(context);
                                },
                                child: new Text("构建新版本",
                                    style: TextStyle(color: Colors.white)),
                                color: LightColor.primaryColor)
                            : new Container()
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
    JenkinsNetwork network = new JenkinsNetwork();
    // Map<String, dynamic> data = await network.jenkinsBuild();
    network.jenkinsBuild();
    Toast.show("触发成功！", context);
  }
}

class ListPageContainer extends StatefulWidget {
  final String title;
  final int type;
  final String logo;
  ListPageContainer({this.title, this.type, this.logo}) : super();
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
        ListPageHeader(
            title: this.widget.title,
            type: this.widget.type,
            logo: this.widget.logo),
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
    // print("page:$page,type:${this.widget.type},title:${this.widget.title}");
    PGYNetwork network = new PGYNetwork(type: this.widget.type);
    List<ItemModel> arr = await network.getList(page: page);
    _needLoadMore = arr.length >= 20;
    print("数据加载完毕!");
    setState(() {
      _list.addAll(arr);
    });
  }

  _getItem(int index) {
    if (index == _list.length - 1 && index != 0) {
      return _needLoadMore ? LoadMore() : Container();
    } else {
      ItemModel model = _list[index];
      return new DetailsItem(model: model);
    }
  }
}
