//package
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

///上拉加载更多
class LoadMore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ///loading框
            new SpinKitWave(color: Colors.blue, size: 10.0),
            new Container(
              width: 5.0,
            ),

            ///加载中文本
            new Text(
              "加载中···",
              style: TextStyle(
                color: Color(0xFF121917),
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ]),
    );
  }
}
