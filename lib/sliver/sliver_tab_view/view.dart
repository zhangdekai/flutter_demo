import 'package:flutter/material.dart';
import 'package:weiChatDemo/base/base_getX_view/view.dart';
import 'package:weiChatDemo/widgets/keep_live_widget.dart';
import 'controller.dart';

/*

TabBar 和TabBarView 都是stateful widget, TabBarView 内部是使用了一个横向PageView, 使用时需要TabBar和TabBarView 联动起来，
他们都有一个入参[TabController],通过这个 tabController 并mixin SingleTickerProviderStateMixin 来实现联动。
Flutter 提供了更加方便的 [DefaultTabController] widget， 实现了TabBar 和 TabBarView 联动。

DefaultTabController 是一个 InheritedWidget。

 */

class SliverTabViewPage extends BaseViewPage<SliverTabViewController> {
  SliverTabViewPage({Key? key}) : super(key: key);

  @override
  String get title => 'TabBarView';

  @override
  Widget buildPage(BuildContext context) {
    return DefaultTabController(
        length: controller.tabBars.length,
        child: Column(
          children: [
            Container(
              height: 48,
              child: TabBar(
                  tabs: controller.tabBars.map((e) => Tab(text: e)).toList()),
            ),
            // Divider(color: Colors.grey,),
            Expanded(
              child: TabBarView(
                  children: controller.tabBars
                      .map((e) => _buildKeepLiveWidget(e))
                      .toList()),
            )
          ],
        ));
  }

  KeepLiveWidget _buildKeepLiveWidget(String e) {
    return KeepLiveWidget(
                          StatefulBuilder(builder: (c, s) {
                            print('StatefulBuilder---');
                            return Center(child: Text(e));
                          })
                        );
  }

  Column _buildTabBarView() {
    return Column(
      children: [
        Container(
          height: 48,
          child: TabBar(
              controller: controller.tabController,
              tabs: controller.tabBars.map((e) => Tab(text: e)).toList()),
        ),
        // Divider(color: Colors.grey,),
        Expanded(
          child: TabBarView(
              controller: controller.tabController,
              children: controller.tabBars
                  .map((e) => _buildKeepLiveWidget(e))
                  .toList()),
        )
      ],
    );
  }

  @override
  SliverTabViewController initController() => SliverTabViewController();
}
