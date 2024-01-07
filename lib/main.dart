import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Page, Action;
import 'package:get/get.dart';
import 'package:weiChatDemo/const_value/route_name.dart';
import 'package:weiChatDemo/generated/l10n.dart';
import 'package:weiChatDemo/pages/root_page.dart';

import 'event/event_handle_test/view.dart';
import 'page_route(路由机制)/page_route_test.dart';

void main() => runApp(MyApp());

/// This widget is the root of your application.
///
class MyApp extends StatelessWidget with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {

    // return _buildMaterialApp();

    return _buildGetMaterialApp();
  }

  MaterialApp _buildMaterialApp() {
    return MaterialApp(
      theme: _buildThemeData,
      initialRoute: RouteName.homepage,
      routes: {
        RouteName.homepage: (c) => RootPage(),
      },
      localizationsDelegates: [S.delegate],
      navigatorObservers: [
        _MyNavigatorObserver(),
      ],
      debugShowCheckedModeBanner: false,
    );
  }

  GetMaterialApp _buildGetMaterialApp() {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildThemeData,
      initialRoute: RouteName.homepage,
      localizationsDelegates: [S.delegate],
      getPages: [
        GetPage(name: RouteName.homepage, page: () => RootPage()),
        GetPage(name: RouteName.pageRouteTest3, page: () => PageRouteTest3()),
        GetPage(name: RouteName.pageEventTest, page: () => EventHandleTestPage()),
      ],
      navigatorObservers: [
        _MyNavigatorObserver(),
      ],
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached: //挂起
        break;
      case AppLifecycleState.resumed: //前台
        break;
      case AppLifecycleState.paused: //后台
        break;
      case AppLifecycleState.hidden: //隐藏
        break;
      case AppLifecycleState.inactive: //inactive
        break;
    }
  }

  ThemeData get _buildThemeData {
    return ThemeData(
        primaryColor: Colors.yellowAccent,
        scaffoldBackgroundColor: Colors.white);
  }
}

// 路由监听 NavigatorObserver
class _MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    print(previousRoute?.settings.name ?? '');
  }

  @override
  void didPush(Route route, Route? previousRoute) {}

  @override
  void didRemove(Route route, Route? previousRoute) {}

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {}
}
