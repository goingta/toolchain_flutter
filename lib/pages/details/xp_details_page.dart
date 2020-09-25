import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';
import 'package:toolchain_flutter/model/xp_build_item.dart';
import 'package:toolchain_flutter/model/xp_env.dart';
import 'package:toolchain_flutter/model/xp_program_item_model.dart';
import 'package:toolchain_flutter/network/xp_network.dart';
import 'package:toolchain_flutter/theme/light_color.dart';

class XPDetailsPage extends StatefulWidget {
  static const String id = "/xp_details_page";

  final XPProgramItemModel xpProgramItemModel;

  //构造函数
  XPDetailsPage({Key key, Map arguments})
      : xpProgramItemModel = arguments['xpProgramItemModel'],
        super(key: key);

  @override
  _XPDetailsState createState() => _XPDetailsState();
}

class _XPDetailsState extends State<XPDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          this.widget.xpProgramItemModel.name,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true, //设置标题是否局
      ),
      body: new _ListPageContainer(
        xpProgramItemModel: this.widget.xpProgramItemModel,
      ),
    );
  }
}

class _ListPageHeader extends StatelessWidget {
  final XPProgramItemModel xpProgramItemModel;

  _ListPageHeader({@required this.xpProgramItemModel}) : super();

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
          children: <Widget>[
            new ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                "assets/images/list_default_logo.png",
                width: 80.0,
                height: 80.0,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  xpProgramItemModel.name,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Text(
                  "中文名：" + xpProgramItemModel.chineseName,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Text(
                  "开发语言：" + xpProgramItemModel.language,
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Expanded(
              child: new Container(
                child: Container(
                  width: 90.0,
                  height: 30,
                  child: new Text("历史构建"),
                  alignment: Alignment.center,
                  color: Colors.grey[200],
                ),
                alignment: Alignment.bottomRight,
              ),
            )
          ],
        ));
  }

  /// 显示环境编译选择 Dialog
  void _showSelectionDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext dialogContext) {
          return SafeArea(
              child: Column(
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
                  // _build(context, "origin/rc");
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
                  // _build(context, "origin/master");
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
          ));
        });
  }
}

class _ListPageContainer extends StatefulWidget {
  final XPProgramItemModel xpProgramItemModel;

  _ListPageContainer({@required this.xpProgramItemModel}) : super();

  @override
  _ListPageContainerState createState() => _ListPageContainerState();
}

class _ListPageContainerState extends State<_ListPageContainer> {
  // 数据源
  List<XPBuildItem> _list = [];

  bool _offState = false;

  void initState() {
    super.initState();
    this._loadBuildHistory();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        _ListPageHeader(
          xpProgramItemModel: this.widget.xpProgramItemModel,
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
          child: Stack(children: [
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
                        return Divider(
                          color: Colors.grey,
                        );
                      },
                      itemCount: _list.length,
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
          ]),
        ),
      ],
    );
  }

  Future<Null> _refresh() async {
    _list.clear();
    _loadBuildHistory();
  }

  Future<void> _loadBuildHistory() async {
    try {
      XPNetwork xpPortalNetwork = XPNetwork();
      final List<XPBuildItem> xpBuildItems =
          await xpPortalNetwork.getBuildHistory(widget.xpProgramItemModel.id);
      _list.addAll(xpBuildItems);
    } catch (e) {
      Toast.show(e.toString(), context);
    }
    _offState = true;
    if (mounted) {
      setState(() {});
    }
  }

  _getItem(int index) {
    XPBuildItem xpBuildItem = _list[index];

    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "分支：${xpBuildItem.ref}",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "时间：${DateTime.fromMillisecondsSinceEpoch(xpBuildItem.created ?? 0)}",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 60,
                padding: const EdgeInsets.symmetric(
                  horizontal: 5.0,
                  vertical: 3.0,
                ),
                decoration: BoxDecoration(
                  color: _getIndicatorColor(xpBuildItem.status),
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      10.0,
                    ),
                  ),
                ),
                child: Text(
                  xpBuildItem.status?.value ?? "构建未知",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          ),
          Text(
            '${xpBuildItem.commitId}',
          ),
          Text(
            '${xpBuildItem.comment}',
          ),
          // SizedBox(
          //   width: 10,
          // ),
          // Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          //   RaisedButton(
          //     onPressed: xpBuildItem.status == XPBuildStatus.SUCCESS
          //         ? () {
          //             _showSelectionDialog(xpBuildItem);
          //           }
          //         : null,
          //     child: new Text(
          //       "发布",
          //       style: TextStyle(
          //         color: Colors.white,
          //       ),
          //     ),
          //     color: xpBuildItem.status == XPBuildStatus.SUCCESS
          //         ? LightColor.primaryColor
          //         : LightColor.lightGrey,
          //   ),
          // ]),
        ],
      ),
    );
  }

  Color _getIndicatorColor(XPBuildStatus xpBuildStatus) {
    Color color;
    if (xpBuildStatus == XPBuildStatus.SUCCESS) {
      color = Colors.green;
    } else if (xpBuildStatus == XPBuildStatus.FAILED) {
      color = Colors.red;
    } else if (xpBuildStatus == XPBuildStatus.PENDING) {
      color = Colors.orange;
    } else if (xpBuildStatus == XPBuildStatus.RUNNING) {
      color = Colors.blue;
    } else {
      color = Colors.grey;
    }
    return color;
  }

  /// 显示选择发布环境的 Dialog
  void _showSelectionDialog(XPBuildItem xpBuildItem) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext dialogContext) {
          return SafeArea(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                ),
                child: Text(
                  "请选择发布目标环境",
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
                  _inputNotes(xpBuildItem, XPEnv.DEV);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Text(
                    XPEnv.DEV.value,
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
                  _inputNotes(xpBuildItem, XPEnv.TEST);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Text(
                    XPEnv.TEST.value,
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
                  _inputNotes(xpBuildItem, XPEnv.STAGING);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Text(
                    XPEnv.STAGING.value,
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
                  _inputNotes(xpBuildItem, XPEnv.PRODUCTION);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Text(
                    XPEnv.PRODUCTION.value,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ));
        });
  }

  /// 输入发布日志
  void _inputNotes(XPBuildItem xpBuildItem, XPEnv xpEnv) {
    final TextEditingController publishNotesController =
        TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              '发布日志',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: TextField(
              controller: publishNotesController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: "请输入发布日志（非必须）",
              ),
              maxLines: 5,
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  '取消',
                  style: TextStyle(color: LightColor.primaryColor),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _publish(xpBuildItem, xpEnv, publishNotesController.text);
                },
                child: Text(
                  '发布',
                  style: TextStyle(color: LightColor.primaryColor),
                ),
              ),
            ],
          );
        });
  }

  /// 发布
  Future<void> _publish(
      XPBuildItem xpBuildItem, XPEnv xpEnv, String notes) async {
    XPNetwork xpNetwork = XPNetwork();
    try {
      await xpNetwork.publish(
          widget.xpProgramItemModel.id, xpBuildItem, xpEnv, notes);
    } catch (e) {
      print(e);
      Toast.show(e.toString(), context);
    }
  }
}
