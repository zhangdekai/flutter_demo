import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weiChatDemo/common/const.dart';

import 'controller.dart';

// ignore: must_be_immutable
abstract class BaseViewPage<T extends BaseViewController> extends StatelessWidget {
  BaseViewPage({Key? key}) : super(key: key);

  String title = '';
  bool willPop = true;

  T get controller => Get.put(initController());
  // final state = Get.find<BaseViewController>().state;

  T initController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              onWillPop(context);
              return willPop;
            },
            child: Scaffold(
              appBar: buildAppBar(),
              body: buildPage(context),
              floatingActionButton: floatingActionButton,
              bottomNavigationBar: bottomNavigationBar,
            ),
          );
        });
  }

  Widget buildPage(BuildContext context);

  PreferredSizeWidget? buildAppBar() => _buildDefaultAppBar;

  Widget? get bottomNavigationBar => null;

  Widget? get floatingActionButton => null;

  AppBar get _buildDefaultAppBar {
    return AppBar(
      title: Text(title),
      backgroundColor: weChatThemeColor,
      elevation: 1,
    );
  }

  void onWillPop(BuildContext context) {}
}
