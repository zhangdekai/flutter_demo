import 'package:flutter/material.dart';
import 'package:weiChatDemo/base/base_view.dart';
import 'package:weiChatDemo/sliver/list_view_test.dart';
import 'package:weiChatDemo/sliver/sliver_animated_list_test.dart';
import 'package:weiChatDemo/sliver/sliver_customScrollView.dart';
import 'package:weiChatDemo/sliver/sliver_gridView_test.dart';
import 'package:weiChatDemo/sliver/sliver_nestedScrollView.dart';
import 'package:weiChatDemo/sliver/sliver_tab_view/view.dart';
import '../common/common_button.dart';
import 'sliver_page_view/view.dart';

/*
GridView, CustomerScrollView,
[ListView] extends BoxScrollView(abstract) extends ScrollView extends  StatelessWidget.

3.x 我们熟悉的滚动组件都是继承自 ScrollView,它结合 Scrollable，Viewport，Sliver

Flutter 中的可滚动组件主要由三个角色组成：Scrollable、Viewport 和 Sliver：
1: Scrollable ：用于处理滑动手势，确定滑动偏移，滑动偏移变化时构建 Viewport 。
2: Viewport：显示的视窗，即列表的可视区域；
3: Sliver：视窗里要显示的元素。

具体布局过程：
1. Scrollable 监听到用户滑动行为后，根据最新的滑动偏移构建 Viewport 。
2. Viewport 将当前视口信息和配置信息通过 SliverConstraints 传递给 Sliver。
3. Sliver 对子组件（RenderBox）按需进行构建和布局，然后确认自身的位置、绘制等信息，
保存在 geometry 中（一个 SliverGeometry 类型的对象）。

// 主要类的继承
class ListView extends ScrollView
class Scrollable extends StatefulWidget
class Viewport extends MultiChildRenderObjectWidget extends RenderObjectWidget extends Widget
Slivers --> List<Widget>

 */

class SliverWidgetTestPage extends BaseView {
  @override
  String get title => 'Sliver Widget';

  final _gap = 16.0;

  @override
  Widget buildPage(BuildContext context) {
    return Center(
      child: Column(
        children: [
          PushButton.button1(context, ListViewTestPage(), 'ListViewTestPage'),
          TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: _gap))),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => CustomScrollViewTestPage()));
              },
              child: Text('CustomScrollView')),
          TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: _gap))),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (c) => SliverAnimatedListSample()));
              },
              child: Text('SliverAnimatedList')),
          TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: _gap))),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => GridViewPageTest()));
              },
              child: Text('GridView - Test')),
          TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: _gap))),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => SliverPageViewPage()));
              },
              child: Text('PageView - Test')),
          TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: _gap))),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => SliverTabViewPage()));
              },
              child: Text('TabBarView - Test')),
          TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: _gap))),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => NestedScrollViewPage()));
              },
              child: Text('NestedScrollView - _NestedTabBarView')),
          PushButton.button1(context, NestedScrollViewPage1(),
              'DefaultTabController Wrap TabBarView'),
          PushButton.button1(context, NestedScrollViewPage2(),
              'NestedScrollview Wrap CustomScrollview'),
          PushButton.button1(context, NestedScrollViewPage3(),
              'NestedScrollView Wrap ListView'),
        ],
      ),
    );
  }
}
