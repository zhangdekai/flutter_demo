import 'package:flutter/material.dart';
import 'package:weiChatDemo/common/const.dart';


@immutable
abstract class BaseView extends StatelessWidget {
  final String title = '';
  final bool willPop = true;

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
        appBar: buildAppBar(),
        body: buildPage(context),
      ),
    );
  }
  PreferredSizeWidget? buildAppBar() => _buildDefaultAppBar;

  AppBar get _buildDefaultAppBar {
    return AppBar(
      title: Text(title),
      backgroundColor: weChatThemeColor,
      elevation: 1,
    );
  }

}