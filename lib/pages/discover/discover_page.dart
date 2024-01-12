import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weiChatDemo/Animation/animation_test.dart';
import 'package:weiChatDemo/common/const.dart';
import 'package:weiChatDemo/common/navigator_tool.dart';
import 'package:weiChatDemo/const_value/route_name.dart';
import 'package:weiChatDemo/generated/l10n.dart';
import 'package:weiChatDemo/image_crop_test/image_crop.dart';
import 'package:weiChatDemo/inherited_widget/inherited_demo.dart';
import 'package:weiChatDemo/key_test/various_key_test.dart';
import 'package:weiChatDemo/pages/discover/discover_cell.dart';
import 'package:weiChatDemo/provider_test/provider_demo/view.dart';
import 'package:weiChatDemo/sqlite/sqlite_page_test.dart';
import 'package:weiChatDemo/sync_Test/test_dart_sync.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with AutomaticKeepAliveClientMixin {
  Color _themeColor = weChatThemeColor;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('DiscoverPage build');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: weChatThemeColor, // Colors.greenAccent
        //一下三个是专门为了安卓使用的属性
        centerTitle: true,
        title: Text('发现'), //
        elevation: 0.0, //底部边栏
      ),
      body: Container(
        color: _themeColor,
        height: 800,
        child: ListView(
          children: <Widget>[
            DiscoverCell(
              imageName: 'images/朋友圈.png',
              title: '朋友圈',
            ),
            SizedBox(height: 10),
            DiscoverCell(
              imageName: 'images/扫一扫2.png',
              title: '扫一扫',
            ),
            Row(
              children: <Widget>[
                Container(width: 50, height: 0.5, color: Colors.white),
                Container(height: 0.5, color: Colors.red)
              ],
            ),
            DiscoverCell(
              imageName: 'images/摇一摇.png',
              title: '动画-测试',
              callBack: () {
                NavigatorTool.pushFrom(context, AnimationTest());
              },
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              imageName: 'images/看一看icon.png',
              title: '各种各样的Keys',
              callBack: () {
                NavigatorTool.pushFrom(context, VariousKeyTest());
              },
            ),
            Row(
              children: <Widget>[
                Container(width: 50, height: 0.5, color: Colors.white),
                Container(height: 0.5, color: Colors.grey)
              ],
            ),
            DiscoverCell(
              imageName: 'images/搜一搜 2.png',
              title: '图片裁剪',
              callBack: () {
                NavigatorTool.pushFrom(context, ImageClipperTest());
              },
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              imageName: 'images/附近的人icon.png',
              title: '测试 Fish_Redux',
              callBack: () {
                NavigatorTool.pushNamed(context, 'fish_test',
                    argument: {'name': 'i am from discover page'});
              },
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              imageName: 'images/购物.png',
              title: '测试 SQLite',
              subTitle: '618限时特价',
              subImageName: 'images/badge.png',
              callBack: () {
                NavigatorTool.pushFrom(context, SQLiteTestPage());
              },
            ),
            Row(
              children: <Widget>[
                Container(width: 50, height: 0.5, color: Colors.white),
                Container(height: 0.5, color: Colors.grey)
              ],
            ),
            DiscoverCell(
              imageName: 'images/游戏.png',
              title: '测试Provider',
              callBack: () {
                NavigatorTool.pushFrom(context, ProviderDemoPage());
              },
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              imageName: 'images/小程序.png',
              title: 'Widget api test',
              callBack: () {

                Get.toNamed(RouteName.pageWidgetsTest);

                // NavigatorTool.pushFrom(context, WidgetsApiTest(testType: 0,));
              },
            ),
            SizedBox(
              height: 0.5,
            ),
            DiscoverCell(
              imageName: 'images/小程序.png',
              title: '测试Dart异步编程',
              callBack: () {
                NavigatorTool.pushFrom(context, TestDartSync());
              },
            ),
            DiscoverCell(
              imageName: 'images/小程序.png',
              title: '数据共享',
              callBack: () {
                NavigatorTool.pushFrom(context, InheritedWidgetDemo());
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
