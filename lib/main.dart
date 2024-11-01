import 'dart:async';
import 'package:flutter/material.dart' hide Page, Action;
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:weiChatDemo/const_value/route_name.dart';
import 'package:weiChatDemo/generated/l10n.dart';
import 'package:weiChatDemo/page_route/page_route_test.dart';
import 'package:weiChatDemo/pages/root_page.dart';
import 'package:weiChatDemo/widgets_test/widgets_test/view.dart';
import 'common/const.dart';
import 'event/event_handle_test/view.dart';
import 'good_libs/flutter_bloc/cubit_test/cubit.dart';

void main() {
  _debugModel();

  runZonedGuarded(() => runApp(MyApp()), (error, stack) {
    /// can add error report here, such as report to firebase crash
    debugPrint('error == $error');
  });
}

void _catchError() {
  FlutterError.onError = (FlutterErrorDetails details) {
    // reportError();
  };
}

void _debugModel() {
  /// 开启Debug 可视化模式，Debug UI
  // debugPaintLayerBordersEnabled = true;
  // debugPaintSizeEnabled = true;

  // 性能Debug
  debugPrintMarkNeedsLayoutStacks = false;
  debugPrintMarkNeedsPaintStacks = false;
}

/// This widget is the root of your application.
///
class MyApp extends StatelessWidget with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return _buildMaterialApp();

    return _buildGetMaterialApp();
  }

  Widget _buildMaterialApp() {
    final app = MaterialApp(
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

    return _buildMultiBlocProvider(app);
  }

  Widget _buildMultiBlocProvider(Widget child) {
    return MultiBlocProvider(providers: [
      ///此处通过BlocProvider创建的Bloc或者Cubit是全局的
      BlocProvider(create: (context) => GlobalBloc()),
      BlocProvider(create: (context) => GlobalBlocA()),
    ], child: child);
  }

  GetMaterialApp _buildGetMaterialApp() {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildThemeData,
      initialRoute: RouteName.homepage,
      getPages: [
        GetPage(name: RouteName.homepage, page: () => RootPage()),
        GetPage(name: RouteName.pageRouteTest3, page: () => PageRouteTest3()),
        GetPage(name: RouteName.pageEventTest, page: () => EventHandleTestPage()),
        GetPage(name: RouteName.pageWidgetsTest, page: () => WidgetsTestPage()),
      ],
      navigatorObservers: [
        _MyNavigatorObserver(),
      ],
      localizationsDelegates: [S.delegate],
      supportedLocales: [
        const Locale('en', 'US'), // 美国英语
        const Locale('zh', 'CN'), // 中文简体
      ],
      locale: Locale('en', 'US'),
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
      primaryColor: weChatThemeColor,
      scaffoldBackgroundColor: Colors.white,
      splashFactory: NoSplash.splashFactory, // 禁止波纹效果
    );
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
