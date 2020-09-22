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
  static const String id = "/app_details_page";

  final AppItemModel appItemModel;

  //构造函数
  AppDetailsPage({Key key, Map arguments})
      : appItemModel = arguments['appItemModel'],
        super(key: key);

  @override
  _AppDetailsState createState() => _AppDetailsState();
}

class _AppDetailsState extends State<AppDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          this.widget.appItemModel.name,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true, //设置标题是否局
      ),
      body: _ListPageContainer(
        appItemModel: this.widget.appItemModel,
      ),
    );
  }
}

class _ListPageHeader extends StatelessWidget {
  // App 程序描述对象
  final AppItemModel appItemModel;

  _ListPageHeader({@required this.appItemModel}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        padding: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey[200],
              offset: Offset(0.0, 2.0),
              blurRadius: 4.0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, //子组件的排列方式为主轴两端对齐
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: appItemModel.logo == "" || appItemModel.logo == null
                  ? Image.asset(
                      "assets/images/list_default_logo.png",
                      width: 80.0,
                      height: 80.0,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      appItemModel.logo,
                      width: 80.0,
                      height: 80.0,
                      fit: BoxFit.cover,
                    ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(height: 15),
                    FlatButton(
                      onPressed: () {
                        _showSelectionDialog(context);
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
                ),
              ),
            ),
            Container(
                child: Container(
                    width: 90.0,
                    height: 30,
                    child: Text("历史版本"),
                    alignment: Alignment.center,
                    color: Colors.grey[200]),
                alignment: Alignment.bottomCenter)
          ],
        ));
  }

  /// 显示环境编译选择 Dialog
  void _showSelectionDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext dialogContext) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Text(
                  "请选择编译目标环境",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ),
              Divider(
                height: 0.5,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(dialogContext);
                  _build(context, "origin/rc");
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Text(
                    "预发",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Divider(
                height: 0.5,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(dialogContext);
                  _build(context, "origin/master");
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Text(
                    "线上",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          );
        });
  }

  /// 构建新版本
  void _build(BuildContext context, String branchName) async {
    JenkinsNetwork network = new JenkinsNetwork();
    try {
      await network.jenkinsBuild(
        appItemModel.jenkinsProjectName,
        appItemModel.jenkinsToken,
        appItemModel.programType == ProgramType.IOS ? "iOS" : "Android",
        branchName,
      );
      Toast.show("触发成功！", context);
    } on Exception catch (e) {
      Toast.show(e.toString(), context);
    }
  }
}

class _ListPageContainer extends StatefulWidget {
  final AppItemModel appItemModel;

  _ListPageContainer({@required this.appItemModel}) : super();

  @override
  _ListPageContainerState createState() => _ListPageContainerState();
}

class _ListPageContainerState extends State<_ListPageContainer> {
  // 数据源
  List<PGYItemModel> _list = [];

  bool _hasMore = true;
  bool _offState = false;
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
        _ListPageHeader(
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
          child: Stack(
            children: [
              RefreshIndicator(
                onRefresh: _refresh,
                child: _offState && _list.length == 0
                    ? ListView(
                        children: [
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(height: 20),
                                Image(
                                    image: AssetImage(
                                  'assets/graphics/not-found.png',
                                )),
                                Text(
                                  "暂无数据，下拉刷新",
                                  style: TextStyle(
                                    color: LightColor.primaryColor,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                    : ListView.separated(
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
                      ),
              ),
              Offstage(
                offstage: _offState,
                child: Center(
                  child: SpinKitDoubleBounce(
                    color: Theme.of(context).primaryColor,
                    size: 50.0,
                  ),
                ),
              ),
            ],
          ),
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
    } catch (e) {
      Toast.show(e.toString(), context);
    }
    _loading = false;
    _offState = true;
    if (mounted) {
      setState(() {});
    }
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
