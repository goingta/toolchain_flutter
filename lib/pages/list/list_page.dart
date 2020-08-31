import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:toast/toast.dart';
import 'package:toolchain_flutter/model/program_type.dart';
import 'package:toolchain_flutter/model/program_item_model.dart';
import 'package:toolchain_flutter/network/yapi_network.dart';
import 'package:toolchain_flutter/pages/list/list_item.dart';
import 'package:toolchain_flutter/theme/light_color.dart';

class ListPage extends StatefulWidget {
  static const String id = "/list";

  // 程序类型
  final ProgramType programType;

  // 构造函数
  ListPage({Key key, Map arguments})
      : this.programType = arguments['programType'],
        super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  bool _loading = true;

  List<ProgramItemModel> _list = [];

  Future<void> _fetchProgramItems() async {
    YapiNetwork yapiNetwork = YapiNetwork();
    try {
      final List<ProgramItemModel> programItemModels =
          await yapiNetwork.getProgramList(widget.programType.code);
      _list.addAll(programItemModels);
    } on Exception catch (e) {
      Toast.show(e.toString(), context);
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
                    ProgramItemModel programItemModel = _list[index];
                    return new ListViewItem(
                      programItemModel: programItemModel,
                    );
                  },
                ),
    );
  }
}
