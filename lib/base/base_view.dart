import 'package:flutter/material.dart';
import 'package:weiChatDemo/common/const.dart';

@immutable
abstract class BaseView extends StatelessWidget {
  String title = '';
  bool willPop = true;

  BaseView({super.key});

  Widget buildPage(BuildContext context);

  void onWillPop(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onWillPop(context);
        return willPop;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: weChatThemeColor,
          elevation: 1,
        ),
        body: buildPage(context),
      ),
    );
  }
}