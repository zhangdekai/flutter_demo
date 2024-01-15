import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weiChatDemo/base/base_provider_view/view.dart';
import 'provider.dart';

/*

本首页rootPage，使用了横向的PageView，对其实现了Keep live 缓存。

PageView 是一个StatefulWidget， 内部实现也是和ListView一样的滚动机制，也是采用了Scrollable， ViewPort, Sliver，按需加载的布局模式。
不同点是，PageView 没有设置默认的预渲染区，cacheExtent, 其ViewPort 的属性 cacheExtentType 是 viewPort型，
allowImplicitScrolling 为true时，默认预渲染前后一页内容。

所以需要我们自己实现其滚动缓存，自定义的 State 实现 AutomaticKeepLiveMixIn 中 wantKeepLive => true，
build 方法中调用 super.build(context)， 即可实现缓存PageView children.
 */

class SliverPageViewPage extends BaseProviderViewPage<SliverPageViewProvider> {
  @override
  String get title => 'PageView';

  @override
  Widget buildPage(BuildContext context) {
    final provider = context.read<SliverPageViewProvider>();

    return PageView.custom(
      allowImplicitScrolling: true, // 允许隐式滚动， true 允许预渲染 前后1页内容
      controller: provider.pageController,
      scrollDirection: Axis.vertical,
      childrenDelegate: SliverChildBuilderDelegate((c, i) {
        return Card(
          color: Colors.blue[100],
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '$i - runtimeType == ${c.runtimeType} \n\n\n toString() == ${c.toString()}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
          ),
        );
      }, childCount: provider.dataList.length),
    );
  }

  @override
  SliverPageViewProvider initProvider() => SliverPageViewProvider();
}
