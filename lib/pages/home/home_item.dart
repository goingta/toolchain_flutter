import 'package:flutter/material.dart';

class HomeItem extends StatelessWidget {
  final HomeItemViewModel data;

  HomeItem({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(bottom: 5),
      child: Column(
        children: <Widget>[
          Expanded(child: this.data.icon),
          Text(
            this.data.title,
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeItemViewModel {
  /// 图标
  final Icon icon;

  /// 标题
  final String title;

  const HomeItemViewModel({
    this.icon,
    this.title,
  });
}
