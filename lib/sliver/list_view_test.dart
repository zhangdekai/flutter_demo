import 'package:flutter/material.dart';
import 'package:weiChatDemo/base/base_view/view.dart';
import 'package:weiChatDemo/sliver/list_view_controller.dart';

/*
ListView 原理
ListView 内部组合了 Scrollable、Viewport 和 Sliver，需要注意：
1. ListView 中的列表项组件都是 RenderBox，并不是 Sliver， 这个一定要注意。
2. 一个 ListView 中只有一个Sliver，对列表项进行按需加载的逻辑是 Sliver 中实现的。
3. ListView 的 Sliver 默认是 SliverList，如果指定了 itemExtent,则会使用 SliverFixedExtentList；
如果 prototypeItem 属性不为空，则会使用 SliverPrototypeExtentList，无论是是哪个，都实现了子组件的按需加载模型。

 */

class ListViewTestPage extends BaseViewPage<ListViewController> {
  @override
  String get title => 'ListView Test';

  @override
  Widget buildPage(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollStartNotification) {
          print('ScrollStartNotification');
        } else if (notification is ScrollUpdateNotification) {
          print('ScrollUpdateNotification');
        } else if (notification is ScrollEndNotification) {
          print('ScrollEndNotification');
        }

        print("notification.metrics: ${notification.metrics.pixels}");
        return false;
        //return true; //放开此行注释后，进度条将失效
      },
      child: Column(
        children: [
          SizedBox(height: 16),
          Text('ListView.separated'),
          Expanded(
            child: ListView.separated(
                controller: controller.scrollController,
                // cacheExtent: 250,  默认 250
                itemBuilder: (c, i) {
                  print('ListView itemBuilder index = $i');
                  return ListTile(
                      title: Text('$i - item runType is ${c.runtimeType}'));
                },
                separatorBuilder: (c, i) {
                  return const Divider();
                },
                itemCount: 30),
          )
        ],
      ),
    );
  }

  @override
  ListViewController initController() => ListViewController();

  @override
  Widget? get floatingActionButton => controller.showTopBar
      ? FloatingActionButton(
          onPressed: controller.goUp,
          child: Icon(Icons.arrow_upward_rounded),
        )
      : null;
}
