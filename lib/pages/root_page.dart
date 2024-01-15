import 'package:flutter/material.dart';
import 'package:weiChatDemo/base/base_getX_view/view.dart';
import 'package:weiChatDemo/pages/chat/chat_page.dart';
import 'package:weiChatDemo/pages/discover/discover_page.dart';
import 'package:weiChatDemo/pages/friends/friend_page.dart';
import 'package:weiChatDemo/pages/mine_page.dart';
import 'package:weiChatDemo/widgets/keep_live_widget.dart';
import 'root_page_controller.dart';

// ignore: must_be_immutable
class RootPage extends BaseViewPage<RootPageController> {
  List<Widget> _pages = [ChatPage(), FriendPage(), DiscoverPage(), MinePage()];

  @override
  Widget buildPage(BuildContext context) {
    print('RootPage  - buildPage');
    return PageView(
      controller: controller.pageController,
      children: _pages.map((e) => KeepLiveWidget(e)).toList(),
      physics: NeverScrollableScrollPhysics(), //禁止左右滑动
      onPageChanged: (int index) {
        //页面滚动变化时调用
      },
    );
  }

  @override
  RootPageController initController() => RootPageController();

  @override
  Widget? get bottomNavigationBar => _buildBottomNavigationBar();

  @override
  PreferredSizeWidget? buildAppBar() => null;

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
        onTap: controller.onTap,
        selectedFontSize: 12.0,
        currentIndex: controller.currentIndex,
        fixedColor: Colors.green,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              // 此处需要在pubspec.yaml 配置asset 的添加
              'images/tabbar_chat.png',
              height: 20,
              width: 20,
            ),
            activeIcon: Icon(Icons.accessible),
            label: '微信',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: '通讯录',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '发现',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '我'),
        ]);
  }
}