import 'package:flutter/material.dart';

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
}
