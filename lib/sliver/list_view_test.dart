import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:weiChatDemo/base/base_getX_view/view.dart';
import 'package:weiChatDemo/sliver/list_view_controller.dart';

/*
ListView 原理
ListView 内部组合了 Scrollable、Viewport 和 Sliver，需要注意：
1. ListView 中的列表项组件都是 RenderBox，并不是 Sliver， 这个一定要注意。
2. 一个 ListView 中只有一个Sliver，对列表项进行按需加载的逻辑是 Sliver 中实现的。
3. ListView 的 Sliver 默认是 SliverList，如果指定了 itemExtent,则会使用 SliverFixedExtentList；
如果 prototypeItem 属性不为空，则会使用 SliverPrototypeExtentList，无论是是哪个，都实现了子组件的按需加载模型。


ListView 缓存机制 :
ListView 是Flutter中的可滚动组件，是按需加载Sliver布局方式的组件，其核心父类是ScrollView，
该类整合Scrollable, ViewPort,Slivers 实现了该滚动组件，其中缓存机制是主要和ViewPort中的属性
cacheExtent 和cacheExtentStyle 有关，Flutter默认在列表上 上下未展示区域提供了预渲染区域，
默认预渲染高度是250，该区域元素高度可以设置cacheExtent， 滑动时 下部未展示区域会提前预加载渲染。


ScrollController控制原理：
当ScrollController和可滚动组件关联时，可滚动组件首先会调用ScrollController的createScrollPosition()方法
来创建一个ScrollPosition来存储滚动位置信息，接着，可滚动组件会调用attach()方法，将创建的ScrollPosition添加到
ScrollController的positions属性中，这一步称为“注册位置”，只有注册后animateTo() 和 jumpTo()才可以被调用。
当可滚动组件销毁时，会调用ScrollController的detach()方法，将其ScrollPosition对象从ScrollController的positions属性中移除，
这一步称为“注销位置”，注销后animateTo() 和 jumpTo() 将不能再被调用。

滚动结束时didEndScroll，ScrollPosition 中会采用PageStorage 加 PageStorageKey 来存储当前偏移量offset 。
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
          Obx(() => GestureDetector(
                onTap: controller.increaseCount,
                child: Text(controller.count.value.toString()),
              )),
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
