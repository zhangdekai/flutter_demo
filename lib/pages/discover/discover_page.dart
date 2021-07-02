import 'package:flutter/material.dart';
import 'package:weichatdemo/common/const.dart';
import 'package:weichatdemo/common/navigator_tool.dart';
import 'package:weichatdemo/fish_redux_test/page.dart';
import 'package:weichatdemo/generated/l10n.dart';
import 'package:weichatdemo/image_crop_test/image_crop.dart';
import 'package:weichatdemo/pages/discover/discover_cell.dart';
import 'package:weichatdemo/provider_test/provider_test_case.dart';
import 'package:weichatdemo/share_data/inherited_demo.dart';
import 'package:weichatdemo/sqlite/sqlite_page_test.dart';
import 'package:weichatdemo/sync_Test/test_dart_sync.dart';
import 'package:weichatdemo/widgets_test/widget_api_test.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with AutomaticKeepAliveClientMixin {
  Color _themeColor = WeChatThemeColor;

  @override
  void initState() {
    super.initState();

    print('DiscoverPage init来了');
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: WeChatThemeColor, // Colors.greenAccent
        //一下三个是专门为了安卓使用的属性
        centerTitle: true,
        title: Text(S.of(context).title),//Text('发现')
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
              title: '摇一摇',
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              imageName: 'images/看一看icon.png',
              title: '看一看',
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
              callBack: (){

                NavigatorTool.pushFrom(context, ImageClipperTest());

              },
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              imageName: 'images/附近的人icon.png',
              title: '测试 Fish_Redux',
              callBack: (){
                NavigatorTool.pushNamed(context, 'fish_test',argument: {'name': 'i am from discover page'});
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
              callBack: (){
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
                NavigatorTool.pushFrom(context, ProviderTestCase());
              },
            ),
            SizedBox(
              height: 10,
            ),
            DiscoverCell(
              imageName: 'images/小程序.png',
              title: 'Widget api test',
              callBack: (){
                NavigatorTool.pushFrom(context, WidgetsApiTest());
              },
            ),
            SizedBox(
              height: 0.5,
            ),
            DiscoverCell(
              imageName: 'images/小程序.png',
              title: '测试Dart异步编程',
              callBack: (){
                NavigatorTool.pushFrom(context, TestDartSync());
              },
            ),
            DiscoverCell(
              imageName: 'images/小程序.png',
              title: '数据共享',
              callBack: (){
                NavigatorTool.pushFrom(context, InheritedDemo());
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
