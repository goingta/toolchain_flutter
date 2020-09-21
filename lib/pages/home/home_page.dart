import 'package:flutter/material.dart';
import 'package:toolchain_flutter/model/program_type.dart';
import 'package:toolchain_flutter/pages/home/home_item.dart';

class HomePage extends StatelessWidget {
  static const String id = "/home_page";

  /// - 服务菜单
  final List<HomeItemViewModel> serviceList = [
    HomeItemViewModel(title: 'iOS', programType: ProgramType.IOS),
    HomeItemViewModel(title: 'Android', programType: ProgramType.ANDROID),
    HomeItemViewModel(title: 'H5', programType: ProgramType.H5),
    HomeItemViewModel(title: '小程序', programType: ProgramType.MINI_PROGRAM),
    HomeItemViewModel(title: 'Java', programType: ProgramType.JAVA),
    HomeItemViewModel(title: 'Node', programType: ProgramType.NODE)
  ];

  HomePage({Key key}) : super(key: key);

  SliverToBoxAdapter _buildHeader(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return SliverToBoxAdapter(
      child: Container(
        height: 225,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.6],
            colors: [
              Theme.of(context).primaryColor.withGreen(190),
              Theme.of(context).primaryColor,
            ],
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(
              screenWidth * 0.50,
              40,
            ),
            bottomRight: Radius.elliptical(
              screenWidth * 0.50,
              40,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 40.0,
          ),
          child: Text(
            "欢迎使用工具链...",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  SliverGrid _buildItems() {
    return SliverGrid.count(
      crossAxisCount: 2,
      crossAxisSpacing: 0,
      mainAxisSpacing: 10,
      childAspectRatio: 3 / 2,
      children: List.generate(
        serviceList.length,
        (index) => HomeItem(data: serviceList[index]),
      ).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _buildHeader(context),
          _buildItems(),
        ],
      ),
    );
  }
}
