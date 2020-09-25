import 'package:flutter/material.dart';
import 'package:toolchain_flutter/theme/light_color.dart';

class TitleText extends StatelessWidget {
  final String title;
  final double fontSize;
  const TitleText(this.title, {Key key, this.fontSize = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
          alignment: Alignment.centerLeft,
          child: Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                  color: LightColor.black))),
    );
  }
}


class BoldText extends StatelessWidget {
  final String title;
  final double fontSize;
  const BoldText(this.title, {Key key, this.fontSize = 12}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: fontSize, color: LightColor.black,fontWeight: FontWeight.bold),
    );
  }
}

class DescText extends StatelessWidget {
  final String title;
  final double fontSize;
  const DescText(this.title, {Key key, this.fontSize = 12}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: fontSize, color: LightColor.grey),
    );
  }
}
