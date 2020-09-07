import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';
import 'package:toolchain_flutter/model/app_item_model.dart';
import 'package:toolchain_flutter/model/pgy_item_model.dart';
import 'package:toolchain_flutter/model/program_type.dart';
import 'package:toolchain_flutter/network/jenkins_network.dart';
import 'package:toolchain_flutter/network/pgyer_network.dart';
import 'package:toolchain_flutter/pages/details/app_details_item.dart';
import 'package:toolchain_flutter/theme/light_color.dart';

class AppDetailsPage extends StatefulWidget {
  static const String id = "/app_details";

  final AppItemModel appItemModel;

  //构造函数
  AppDetailsPage({Key key, Map arguments})
      : appItemModel = arguments['appItemModel'],
        super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<AppDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          this.widget.appItemModel.name,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: LightColor.primaryColor, //设置appbar背景颜色
        centerTitle: true, //设置标题是否局
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: new ListPageContainer(
        appItemModel: this.widget.appItemModel,
      ),
    );
  }
}

class ListPageHeader extends StatelessWidget {
  // App 程序描述对象
  final AppItemModel appItemModel;

  ListPageHeader({@required this.appItemModel}) : super();

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
              child: appItemModel.logo == "" || appItemModel.logo == null
                  ? Image.asset("images/list_default_logo.png")
                  : Image.network(
                      appItemModel.logo,
                      width: 80.0,
                      height: 80.0,
                      fit: BoxFit.cover,
                    ),
            ),
            new Expanded(
                flex: 2,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(height: 15),
                        new FlatButton(
                          onPressed: () {
                            _build(context);
                          },
                          child: new Text(
                            "构建新版本",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          color: LightColor.primaryColor,
                        )
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

  // 构建新版本
  void _build(BuildContext context) async {
    JenkinsNetwork network = new JenkinsNetwork();
    try {
      await network.jenkinsBuild(
        appItemModel.jenkinsProjectName,
        appItemModel.jenkinsToken,
        appItemModel.programType == ProgramType.IOS ? "iOS" : "Android",
      );
      Toast.show("触发成功！", context);
    } on Exception catch (e) {
      Toast.show(e.toString(), context);
    }
  }
}

class ListPageContainer extends StatefulWidget {
  final AppItemModel appItemModel;

  ListPageContainer({@required this.appItemModel}) : super();

  @override
  _ListPageContainerState createState() => _ListPageContainerState();
}

class _ListPageContainerState extends State<ListPageContainer> {
  // 数据源
  List<PGYItemModel> _list = [];

  bool _hasMore = true;
  bool _loading = true;

  int _currentPage = 1;

  final ScrollController _scrollController = new ScrollController();

  void initState() {
    print('ListPageContainer initState');
    super.initState();
    this._loadData();

    /// 增加滑动监听
    _scrollController.addListener(() {
      if (_scrollController.position.pixels /
              _scrollController.position.maxScrollExtent >
          0.6) {
        if (_hasMore && !_loading) {
          print("loadMore");
          _currentPage++;
          this._loadData();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        ListPageHeader(
          appItemModel: this.widget.appItemModel,
        ),
        Container(
          height: 1.0,
          decoration: new BoxDecoration(
            border: new Border.all(
              color: Colors.grey[200],
            ),
          ),
        ),
        Flexible(
          child: _list.length == 0
              ? Center(
                  child: SpinKitDoubleBounce(
                    color: Theme.of(context).primaryColor,
                    size: 50.0,
                  ),
                )
              : new RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0,
                    ),
                    itemBuilder: (context, index) {
                      return _getItem(index);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 30.0,
                      );
                    },
                    itemCount: _list.length,
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                  )),
        ),
      ],
    );
  }

  Future<Null> _refresh() async {
    _list.clear();
    _currentPage = 1;
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      _loading = true;
      PGYNetwork network = new PGYNetwork();
      final List<PGYItemModel> pgyItemModels = await network.getBuildList(
        _currentPage,
        this.widget.appItemModel.pgyApiKey,
        this.widget.appItemModel.pgyAppKey,
      );
      _list.addAll(pgyItemModels);
      if (pgyItemModels.length == 0) {
        _hasMore = false;
      }
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      Toast.show(e.toString(), context);
    }
    _loading = false;
  }

  _getItem(int index) {
    PGYItemModel pgyItemModel = _list[index];
    return new AppDetailsItem(
      pgyItemModel: pgyItemModel,
      programType: this.widget.appItemModel.programType,
      pgyApiKey: this.widget.appItemModel.pgyApiKey,
    );
  }
}
