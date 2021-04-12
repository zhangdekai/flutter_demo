import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weichatdemo/pages/chat/chat_page.dart';
import 'package:weichatdemo/pages/discover/discover_page.dart';
import 'package:weichatdemo/pages/friends/friend_page.dart';
import 'package:weichatdemo/pages/mine_page.dart';

class RootPage extends StatefulWidget {
  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  
  int _currentIndex = 0;

  List<Widget> _pages = [ChatPage(),FriendPage(), DiscoverPage(),MinePage()];
  final PageController _pageController = PageController(initialPage: 0);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
        physics: NeverScrollableScrollPhysics(),//禁止左右滑动
//        onPageChanged: (int index){//页面滚动变化时调用
//          setState(() {
//            _currentIndex = index;
//          });
//        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index){
            setState(() {
              _currentIndex = index;
            });
            _pageController.jumpToPage(index);
          },
          selectedFontSize: 12.0,
          currentIndex: _currentIndex,
          fixedColor: Colors.green,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(// 此处需要在pubspec.yaml 配置asset 的添加
                  'images/tabbar_chat.png',
                  height: 20,
                  width: 20,),
              activeIcon: Image.asset(
                  'images/tabbar_chat_hl.png',
                height: 20,
                width: 20,
              ),
              title: Text('微信'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark), title: Text('通讯录'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history), title: Text('发现'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), title: Text('我'),
            ),
      ]),

    );
  }
}
