import 'package:flutter/material.dart';
import 'package:toolchain_flutter/pages/home/home_item.dart';
// import 'package:flutter_smart_course/src/helper/quad_clipper.dart';
// import 'package:flutter_smart_course/src/pages/recomended_page.dart';
// import 'package:flutter_smart_course/lib/tools/lightColor.dart';
import '../../theme/light_color.dart';
import '../../components/quad_clipper.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  static const String id = "/home";
  double width;

  Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
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
              MediaQuery.of(context).size.width * 0.50, 40),
          bottomRight: Radius.elliptical(
              MediaQuery.of(context).size.width * 0.50, 40),
        ),
      ),
      child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                  top: 40,
                  left: 0,
                  child: Container(
                    width: width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                          SizedBox(height: 10),
                          SizedBox(height: 20),
                          Text(
                            "欢迎使用工具链...",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: 30,
                                fontWeight: FontWeight.w500),
                          )

                      ],
                    ),
                  )),
            ],
          )
    );
  }

  /// 美团 - 服务菜单
 List<HomeItemViewModel> serviceList = [
  HomeItemViewModel(
    title: 'iOS',
    icon: Icon(
      Icons.explore,
      size: 55,
      color: LightColor.primaryColor,
    ),
  ),
  HomeItemViewModel(
    title: 'Android',
    icon: Icon(
      Icons.android,
      size: 55,
      color: LightColor.primaryColor,
    ),
  ),
  HomeItemViewModel(
    title: 'H5',
    icon: Icon(
      Icons.language,
      size: 55,
      color: LightColor.primaryColor,
    ),
  ),
  HomeItemViewModel(
    title: '小程序',
    icon: Icon(
      Icons.polymer,
      size: 55,
      color: LightColor.primaryColor,
    ),
  ),
  HomeItemViewModel(
    title: 'Java',
    icon: Icon(
      Icons.backup,
      size: 55,
      color: LightColor.primaryColor,
    ),
  )
];

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
      return Scaffold(
      body: Column(
          children: <Widget>[
            _header(context),
            GridView.builder(
            shrinkWrap: true,
            itemCount: serviceList.length,
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              // 左右间隔
              crossAxisSpacing: 0,
              // 上下间隔
              mainAxisSpacing: 10,
              //宽高比
              childAspectRatio: 3 / 2,
            ),
            itemBuilder: (context, index) {
              return HomeItem(data: serviceList[index]);
            },
          )
          ],
        ));
  }
}
