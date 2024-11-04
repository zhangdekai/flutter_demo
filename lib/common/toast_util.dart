import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtil {
  /// 没用context的简易版本，再Android sdk > 30的情况下无法自定义
  static void show(String msg, {ToastGravity gravity = ToastGravity.CENTER, Toast length = Toast.LENGTH_SHORT}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: gravity,
      timeInSecForIosWeb: 1,
      backgroundColor: const Color(0xCC000000),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  /// 这个版本可以包含context，可以适配不同的系统版本
  static void showToast(BuildContext context, String msg,
      {ToastGravity gravity = ToastGravity.CENTER,
      Duration toastDuration = const Duration(seconds: 2),
      Color? bgColor}) {
    if (!context.mounted) return;
    final fToast = FToast().init(context);
    fToast.removeCustomToast();
    fToast.showToast(
        child: Container(
            decoration: BoxDecoration(
              color: bgColor ?? Colors.black.withOpacity(0.8),
              borderRadius: BorderRadiusDirectional.all(
                Radius.circular(4),
              ),
              shape: BoxShape.rectangle,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.all(12),
              child: Text(
                msg,
                style: TextStyle(color: Colors.white),
              ),
            )),
        toastDuration: toastDuration,
        gravity: gravity);
  }
}
