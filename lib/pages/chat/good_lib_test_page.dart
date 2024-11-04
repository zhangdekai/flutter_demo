import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weiChatDemo/base/base_provider_view/provider.dart';
import 'package:weiChatDemo/base/base_provider_view/view.dart';
import 'package:weiChatDemo/good_libs/card_swiper/card_swiper_page.dart';
import 'package:weiChatDemo/good_libs/flutter_bloc/flutter_bloc_page.dart';
import 'package:weiChatDemo/good_libs/flutter_staggered_grid_view/flutter_staggered_grid_view_page.dart';
import 'package:weiChatDemo/good_libs/pull_to_refresh/pull_to_refesh_page.dart';
import 'package:weiChatDemo/good_libs/scrollable_positioned_list/scrollable_positioned_list_page.dart';
import 'package:weiChatDemo/good_libs/slider_up_panel_page/slider_up_panel_page.dart';

class GoodLibTestPage extends BaseProviderViewPage {
  @override
  String get title => 'Good Lib List';

  List<String> _data = [
    'ScrollablePositionedListPage',
    'Slider Up Panel',
    'Flutter Bloc',
    'Pull to Refresh',
    'Card Swiper',
    'Flutter StaggeredGridView',
    'Screen_protect',
    'Screen_shot'
  ];

  @override
  Widget buildPage(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: _data.length,
        itemBuilder: (con, index) {
          return GestureDetector(
            onTap: () {
              print('点击了第${index}个');
              _onTap(index, context);
            },
            child: ListTile(
              title: Text('${index} - ${_data[index]}'),
            ),
          );
        });
  }

  void _onTap(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.of(context).push(CupertinoPageRoute(builder: (c) => ScrollablePositionedListPage()));
        break;
      case 1:
        Navigator.of(context).push(CupertinoPageRoute(builder: (c) => SliderUpPanelPage()));
        break;
      case 2:
        Navigator.of(context).push(CupertinoPageRoute(builder: (c) => FlutterBlocTestPage()));
        break;
      case 3:
        Navigator.of(context).push(CupertinoPageRoute(builder: (c) => PullToRefreshPage()));
        break;
      case 4:
        Navigator.of(context).push(CupertinoPageRoute(builder: (c) => CardSwiperPage()));
        break;
      case 5:
        Navigator.of(context).push(CupertinoPageRoute(builder: (c) => FlutterStaggeredGridViewPage()));
        break;
    }
  }

  @override
  BaseProviderViewProvider initProvider() {
    // TODO: implement initProvider
    throw UnimplementedError();
  }
}
