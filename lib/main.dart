import 'package:flutter/material.dart' hide Page, Action;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weichatdemo/fish_redux_test/page.dart';
import 'package:weichatdemo/generated/l10n.dart';
import 'package:weichatdemo/pages/root_page.dart';

import 'package:fish_redux/fish_redux.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    BuildOwner owner = WidgetsBinding.instance.buildOwner;

    return _materialApp();

    // return fishRedux();
  }

  MaterialApp _materialApp(){

    var routes = PageRoutes(
      pages: <String, Page<Object, dynamic>>{
        'fish_test': FishReduxTestPage(),
      },
    );

    return MaterialApp(
      title: 'Flutter Demo1123',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        //一下两个可以取消点击 地菜单时的点击效果。
        highlightColor: Color.fromRGBO(1, 0, 0, 0),
        splashColor: Color.fromRGBO(1, 0, 0, 0),
        primarySwatch: Colors.yellow,//影响状态栏颜色呀？？
        cardColor: Color.fromRGBO(1, 1, 1, 0.65),
      ),
      home: RootPage(),
      onGenerateRoute: (RouteSettings settings){

        return MaterialPageRoute(builder: (context){

          return routes.buildPage(settings.name, settings.arguments);

        });

      },// InheritedDemo   RootPage StateManagerDemo MyHomePage(title: 'Flutter Demo Home Page')
    );
  }




  /// 创建应用的根 Widget
  /// 1. 创建一个简单的路由，并注册页面
  /// 2. 对所需的页面进行和 AppStore 的连接
  /// 3. 对所需的页面进行 AOP 的增强
  MaterialApp fishRedux(){

    var routes = PageRoutes(
        pages: <String, Page<Object, dynamic>>{
          'fish_test': FishReduxTestPage(),
        },
      visitor: (String path, Page<Object, dynamic> page) {
          // vistorDetail(path, page);
    },
        );

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //一下两个可以取消点击 地菜单时的点击效果。
        highlightColor: Color.fromRGBO(1, 0, 0, 0),
        splashColor: Color.fromRGBO(1, 0, 0, 0),
        primarySwatch: Colors.yellow, //影响状态栏颜色呀？？
        cardColor: Color.fromRGBO(1, 1, 1, 0.65),
      ),
      home: routes.buildPage('fish_test', null),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (context) {
          return routes.buildPage(settings.name, settings.arguments);
        });
      }, // InheritedDemo   RootPage StateManagerDemo MyHomePage(title: 'Flutter Demo Home Page')
    );
  }

  vistorDetail(String path, Page<Object, dynamic> page){
    /// 只有特定的范围的 Page 才需要建立和 AppStore 的连接关系
    /// 满足 Page<T> ，T 是 GlobalBaseState 的子类


    // if (page.isTypeof<GlobalBaseState>()) {
    //   /// 建立 AppStore 驱动 PageStore 的单向数据连接
    //   /// 1. 参数1 AppStore
    //   /// 2. 参数2 当 AppStore.state 变化时, PageStore.state 该如何变化
    //   page.connectExtraStore<GlobalState>(GlobalStore.store,
    //           (Object pagestate, GlobalState appState) {
    //         final GlobalBaseState p = pagestate;
    //         if (p.themeColor != appState.themeColor) {
    //           if (pagestate is Cloneable) {
    //             final Object copy = pagestate.clone();
    //             final GlobalBaseState newState = copy;
    //             newState.themeColor = appState.themeColor;
    //             return newState;
    //           }
    //         }
    //         return pagestate;
    //       });
    // }

    /// AOP
    /// 页面可以有一些私有的 AOP 的增强， 但往往会有一些 AOP 是整个应用下，所有页面都会有的。
    /// 这些公共的通用 AOP ，通过遍历路由页面的形式统一加入。
    page.enhancer.append(
      /// View AOP
      viewMiddleware: <ViewMiddleware<dynamic>>[
        safetyView<dynamic>(),
      ],

      /// Adapter AOP
      adapterMiddleware: <AdapterMiddleware<dynamic>>[
        safetyAdapter<dynamic>()
      ],

      /// Effect AOP
      effectMiddleware: <EffectMiddleware<dynamic>>[
        _pageAnalyticsMiddleware<dynamic>(),
      ],

      /// Store AOP
      middleware: <Middleware<dynamic>>[
        logMiddleware<dynamic>(tag: page.runtimeType.toString()),
      ],
    );
  }
  /// 简单的 Effect AOP
  /// 只针对页面的生命周期进行打印
  EffectMiddleware<T> _pageAnalyticsMiddleware<T>({String tag = 'redux'}) {
    return (AbstractLogic<dynamic> logic, Store<T> store) {
      return (Effect<dynamic> effect) {
        return (Action action, Context<dynamic> ctx) {
          if (logic is Page<dynamic, dynamic> && action.type is Lifecycle) {
            print('${logic.runtimeType} ${action.type.toString()} ');
          }
          return effect?.call(action, ctx);
        };
      };
    };
  }


}
