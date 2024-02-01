import 'package:flutter/material.dart';
import 'package:weiChatDemo/base/base_view.dart';

/*
NestedScrollView 原理：

NestedScrollView build 方法中，return的是一个敢InheritedWidget 包裹的 自定义CustomScrollView,
header 和body 都是CustomScrollView 的子 sliver。

1: NestedScrollView 整体就是一个 CustomScrollView （实际上是 CustomScrollView 的一个子类）

2: header 和 body 都是 CustomScrollView 的子 Sliver ，注意，虽然 body 是一个 RenderBox，但是它会被包装为 Sliver 。

3: CustomScrollView 将其所有子 Sliver 在逻辑上分为 header 和 body 两部分：header 是前面部分、body 是后面部分。

4: 当 body 是一个可滚动组件时， 它和 CustomScrollView 分别有一个 Scrollable ，
由于 body 在 CustomScrollView 的内部，所以称其为内部可滚动组件，称 CustomScrollView 为外部可滚动组件；
同时 因为 header 部分是 Sliver，所以没有独立的 Scrollable，滑动时是受 CustomScrollView 的 Scrollable 控制，
所以为了区分，可以称 header 为外部可滚动组件（Flutter 文档中是这么约定的）。

4: NestedScrollView 核心功能就是通过一个协调器来协调外部（outer）可滚动组件和内部（inner）
可滚动组件的滚动，以使滑动效果连贯统一，协调器的实现原理就是分别给内外可滚动组件分别设置一个 controller，
然后通过这两个controller 来协调控制它们的滚动。

 */

SliverList _buildSliverList(int count) {
  return SliverList(
      delegate: SliverChildBuilderDelegate((c, i) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        '$i - ${c.runtimeType}',
        textScaleFactor: 1.5,
      ),
    );
  }, childCount: count));
}

class NestedScrollViewPage extends BaseView {
  @override
  String get title => 'NestedScrollView';

  @override
  PreferredSizeWidget? buildAppBar() => null;

  @override
  Widget buildPage(BuildContext context) {
    /// 在手机上OK，web 不太OK（横向滑动时）
    return _NestedTabBarView(sliver: _buildSliverList(30));
  }
}

class NestedScrollViewPage1 extends BaseView {
  @override
  String get title => 'NestedScrollView';

  @override
  PreferredSizeWidget? buildAppBar() => null;

  final _tabs = <String>['猜你喜欢', '今日特价', '发现更多'];

  GlobalKey _tabGlobalKey = GlobalKey();

  @override
  Widget buildPage(BuildContext context) {
    return _buildDefaultTabController();
  }

  DefaultTabController _buildDefaultTabController() {
    return DefaultTabController(
      key: _tabGlobalKey,
      length: _tabs.length, // tab的数量.
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                title: const Text('商城'),
                // pinned: true,
                floating: true,
                snap: true,
                forceElevated: innerBoxIsScrolled,
                bottom: TabBar(
                  tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          children: _tabs.map((String name) {
            return Builder(
              builder: (BuildContext context) {
                return CustomScrollView(
                  key: PageStorageKey<String>(name),
                  slivers: <Widget>[
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(8.0),
                      sliver: _buildSliverList(30),
                    ),
                  ],
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class NestedScrollViewPage2 extends BaseView {
  @override
  String get title => 'NestedScrollView';

  @override
  PreferredSizeWidget? buildAppBar() => null;

  @override
  Widget buildPage(BuildContext context) {
    return _buildNestedScrollView1();
  }

  NestedScrollView _buildNestedScrollView1() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          // 实现 snap 效果
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              floating: true,
              snap: true,
              expandedHeight: 200,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  "assets/sea_image.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ];
      },
      body: Builder(builder: (BuildContext context) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
            _buildSliverList(30)
          ],
        );
      }),
    );
  }
}

class NestedScrollViewPage3 extends BaseView {
  @override
  String get title => 'NestedScrollView';

  @override
  PreferredSizeWidget? buildAppBar() => null;

  @override
  Widget buildPage(BuildContext context) {
    return _buildNestedScrollView();
  }

  NestedScrollView _buildNestedScrollView() {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          // 返回一个 Sliver 数组给外部可滚动组件。
          return <Widget>[
            SliverAppBar(
              title: const Text('嵌套ListView'),
              pinned: true, // 固定在顶部
              forceElevated: innerBoxIsScrolled,
            ),
            _buildSliverList(5), //构建一个 sliverList
          ];
        },
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          physics: const ClampingScrollPhysics(), //重要
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 50,
              child: Center(child: Text('Item $index')),
            );
          },
        ));
  }
}

class _NestedTabBarView extends StatefulWidget {
  final Widget? sliver;
  const _NestedTabBarView({super.key, this.sliver});

  @override
  State<_NestedTabBarView> createState() => _NestedTabBarViewState();
}

class _NestedTabBarViewState extends State<_NestedTabBarView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _tabs = <String>['猜你喜欢', '今日特价', '发现更多'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              title: const Text('商城'),
              // pinned: true,
              floating: true,
              snap: true,
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(
                controller: _tabController,
                tabs: _tabs.map((String name) => Tab(text: name)).toList(),
              ),
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((String name) {
          return Builder(
            builder: (BuildContext context) {
              return CustomScrollView(
                key: PageStorageKey<String>(name),
                slivers: <Widget>[
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: widget.sliver,
                  ),
                ],
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
