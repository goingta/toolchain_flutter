import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';
import 'package:toolchain_flutter/model/program_type.dart';
import 'package:toolchain_flutter/model/user.dart';
import 'package:toolchain_flutter/model/xp_program_item_model.dart';
import 'package:toolchain_flutter/model/xp_program_type.dart';
import 'package:toolchain_flutter/network/xp_network.dart';
import 'package:toolchain_flutter/pages/list/xp_list_item.dart';
import 'package:toolchain_flutter/pages/login/login_page.dart';
import 'package:toolchain_flutter/theme/light_color.dart';

class XPListPage extends StatefulWidget {
  static const String id = "/xp_list_page";

  // 程序类型
  final ProgramType programType;

  // 构造函数
  XPListPage({Key key, Map arguments})
      : this.programType = arguments['programType'],
        super(key: key);

  @override
  _XPListPageState createState() => _XPListPageState();
}

class _XPListPageState extends State<XPListPage> {
  bool _loading = true;

  List<XPProgramItemModel> _list = [];

  Future<void> _fetchProgramItems() async {
    XPNetwork xpPortalNetwork = XPNetwork();
    try {
      final List<XPProgramItemModel> xpProgramItemModels = await xpPortalNetwork
          .getProgramList(widget.programType == ProgramType.SERVER
              ? [
                  XPProgramType.API.code,
                  XPProgramType.ADMIN.code,
                  XPProgramType.WEB.code,
                  XPProgramType.RPC.code,
                ]
              : [
                  XPProgramType.SPA.code,
                  XPProgramType.BFF.code,
                ]);
      xpProgramItemModels.sort((a, b) => a.name.compareTo(b.name));
      _list.addAll(xpProgramItemModels);
    } catch (e) {
      //token失效
      if (e.response.statusCode == 403) {
        User.signOut();
        Navigator.pushReplacementNamed(context, LoginPage.id);
      } else {
        Toast.show(e.toString(), context);
      }
    }
    if (mounted) {
      setState(() {
        this._loading = false;
      });
    }
  }

  void initState() {
    super.initState();
    _fetchProgramItems();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          this.widget.programType.value,
        ),
      ),
      body: _loading
          ? Center(
              child: SpinKitDoubleBounce(
                color: Theme.of(context).primaryColor,
                size: 50.0,
              ),
            )
          : _list.length == 0
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Image(
                          image: AssetImage(
                        'assets/graphics/not-found.png',
                      )),
                      Text(
                        "暂无数据",
                        style: TextStyle(
                          color: LightColor.primaryColor,
                        ),
                      )
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _list.length,
                  itemBuilder: (context, index) {
                    XPProgramItemModel xpProgramItemModel = _list[index];
                    return new XPListViewItem(
                      xpProgramItemModel: xpProgramItemModel,
                    );
                  },
                ),
    );
  }
}
