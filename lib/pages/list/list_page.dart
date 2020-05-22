import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:toolchain_flutter/model/item_model.dart';
import 'package:toolchain_flutter/network/network.dart';
import 'package:toolchain_flutter/pages/list/list_item.dart';
import 'package:toolchain_flutter/theme/light_color.dart';

import '../../model/applet_model.dart';

class ListPage extends StatefulWidget {
  static const String id = "/list";
  final String title;
  final Map arguments;
  //构造函数
  ListPage({Key key, this.title , this.arguments}) : super(key: key);
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // 返回true
  bool _loading = false;
  bool _needLoadMore = true;
  List<ItemModel> _list = [];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Map<String,dynamic> args = ModalRoute.of(context).settings.arguments;

    if (_list.length == 0 && !_loading && _needLoadMore) {
      _loadData(1, {"tid": args["tid"]});
    }



    return new Scaffold(
      appBar: new AppBar(
        title:
            new Text(this.widget.title, style: TextStyle(color: Colors.white)),
        backgroundColor: LightColor.primaryColor, //设置appbar背景颜色
        centerTitle: true, //设置标题是否局中
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: _loading ? Center(
              child: SpinKitDoubleBounce(
                color: Theme.of(context).primaryColor,
                size: 50.0,
              ),
            ) : _list.length == 0 ? Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20),
                    Image(
                          image: AssetImage(
                            'assets/graphics/not-found.png',
                          )),
                    Text("暂无数据",
                            style: TextStyle(color: LightColor.primaryColor))
                  ])
             ): ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, index) {
          ItemModel model = _list[index];
          return new ListViewItem(model: model);
        },
      ),
    );
  }

  Future<Null> _loadData(int page,Map<String,dynamic> params) async {
      _loading = true;
    // print("page:$page,type:${this.widget.type},title:${this.widget.title}");
    Network network = new Network();
    List<ItemModel> arr = await network.list(page: page, params: params);
    _needLoadMore = arr.length >= 20;
    setState(() {
      _loading = false;
      _list.addAll(arr);
      _needLoadMore = arr.length != 0;
    });
  }
}
