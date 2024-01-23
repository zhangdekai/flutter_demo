import 'package:flutter/material.dart';

/// 以下button 用来测试用，Code并不规范
class PushButton {

  static TextButton button1(BuildContext context, Widget widget, String title) {
    return TextButton(
        style: ButtonStyle(
            padding:
                MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 16))),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (c) => widget));
        },
        child: Text(
          title,
          textScaleFactor: 1.5,
        ));
  }

  static TextButton button2(BuildContext context,String title, VoidCallback onTap) {
    return TextButton(
        style: ButtonStyle(
            padding:
            MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 16))),
        onPressed: onTap,
        child: Text(
          title,
          textScaleFactor: 1.5,
        ));
  }
}
