import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weiChatDemo/base/base_provider_view/provider.dart';
import 'package:weiChatDemo/common/const.dart';

abstract class BaseProviderViewPage<T extends BaseProviderViewProvider>
    extends StatelessWidget {
  final String title = '';
  final bool willPop = true;

  BaseProviderViewPage({super.key});

  Widget buildPage(BuildContext context);

  T initProvider();

  void onWillPop(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onWillPop(context);
        return willPop;
      },
      child: ChangeNotifierProvider(
        create: (BuildContext context) => initProvider(),
        builder: (context, child) => Scaffold(
          appBar: buildAppBar(),
          body: buildPage(context),
        ),
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
