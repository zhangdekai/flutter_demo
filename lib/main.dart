import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide Page, Action;
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:weiChatDemo/common/common_func.dart';
import 'package:weiChatDemo/const_value/route_name.dart';
import 'package:weiChatDemo/generated/l10n.dart';
import 'package:weiChatDemo/page_route/page_route_test.dart';
import 'package:weiChatDemo/pages/root_page.dart';
import 'package:weiChatDemo/widgets_test/widgets_test/view.dart';
import 'common/const.dart';
import 'event/event_handle_test/view.dart';
import 'good_libs/flutter_bloc/cubit_test/cubit.dart';

Future<void> main() async {
  // _debugModel();
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  _catchError();
  runZonedGuarded(() => runApp(MyApp()), (error, stack) {
    /// can add error report here, such as report to firebase crash
    debugPrint('main- get runZonedGuarded error == ${error.toString()}');
  });
}

void _catchError() {
  FlutterError.onError = (FlutterErrorDetails details) {
    print('FlutterErrorDetails == ${details.toString()}');
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
    Widget _widget = _buildMaterialApp();

    // _widget = _buildGetMaterialApp();

    // return _widget;

    return EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('de', 'DE')],
        path: 'assets/translations',
        // <-- change the path of the translation files
        // fallbackLocale: Locale('en', 'US'),
        child: _widget);
  }

  Widget _buildMaterialApp() {
    final app = MaterialApp(
      theme: _buildThemeData,
      initialRoute: RouteName.homepage,
      routes: {
        RouteName.homepage: (c) => RootPage(),
      },
      localizationsDelegates: [
        S.delegate,
        // 本地化的代理类
        GlobalMaterialLocalizations.delegate,
        //PS: 基于WidgetsApp类为入口的应用程序进行国际化时, 不需要这个
        GlobalWidgetsLocalizations.delegate,
        // 定义组件默认的文本方向，从左到右或从右到左.
        GlobalCupertinoLocalizations.delegate,
        FlutterQuillLocalizations.delegate,
      ],
      // supportedLocales: [
      //   // 当前应用支持的locale列表
      //   const Locale('en', 'US'), // 美国英语
      //   const Locale('zh', 'CN'), // 中文简体
      //   //其它Locales
      // ],
      // localeListResolutionCallback:
      //     (List<Locale>? locales, Iterable<Locale> supportedLocales) {
      //   //local: 当前的当前的locales 列表
      //   //supportedLocales: 为当前应用支持的locale列表，是开发者在MaterialApp中通过supportedLocales属性注册的
      //   return locales?.firstOrNull;
      // },
      // localeResolutionCallback:
      //     (Locale? locale, Iterable<Locale> supportedLocales) {
      //   //local: 当前的当前的系统语言设置
      //   //supportedLocales: 为当前应用支持的locale列表，是开发者在MaterialApp中通过supportedLocales属性注册的
      //   return locale;
      // },
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
        GetPage(
            name: RouteName.pageEventTest, page: () => EventHandleTestPage()),
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

final router = GoRouter(
  routes: [
    GoRoute(
      name: 'A',
      path: '/',
      builder: (_, __) => const PageA(),
    ),
    GoRoute(
      name: 'B',
      path: '/B',
      builder: (_, __) => const PageB(),
    ),
    GoRoute(
      name: 'C',
      path: '/C',
      builder: (_, __) => const PageC(),
    ),
  ],
);

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}

class PageA extends StatelessWidget {
  const PageA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: createCommonAppBar(context, title: 'A Page'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextButton(
              onPressed: () async {
                context.pushNamed("B").then((v) {
                  // if (context.mounted) {
                  //   context.pushNamed("C");
                  // }
                });
                // await _caseOne();
              },
              child: const Text('Go to page B'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _caseOne() async {
    final ctx = router.routerDelegate.navigatorKey.currentContext!;
    unawaited(ctx.pushNamed('A'));
    await Future.delayed(const Duration(milliseconds: 100));
    ctx.pop(true);
    ctx.goNamed('B');
  }
}

class PageB extends StatelessWidget {
  const PageB({super.key});

  @override
  Widget build(BuildContext context) {
    // context.pop(true);
    return Scaffold(
      appBar: createCommonAppBar(context, title: 'PageB'),
      // backgroundColor: Colors.brown,
      body: Column(
        children: [
          TextButton(
              onPressed: () async {
                // await Future.delayed(Duration(milliseconds: 1001));
                context.pop(true);
                context.pushNamed("C");
              },
              child: Text('Pop'))
        ],
      ),
    );
  }
}

class PageC extends StatefulWidget {
  const PageC({super.key});

  @override
  State<PageC> createState() => _PageCState();
}

class _PageCState extends State<PageC> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createCommonAppBar(context, title: 'PageC'),
      backgroundColor: Colors.brown,
    );
  }
}
