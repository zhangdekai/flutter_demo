import 'package:flutter/material.dart';
import 'package:weiChatDemo/const_value/route_name.dart';

/// Flutter 路由机制
/*
Flutter 的路由机制主要涉及两个核心类：Navigator 和 Route。
这两个类共同协作，实现了应用程序中不同页面之间的导航和切换。

1. Navigator 类
Navigator 类是 Flutter 中用于管理页面导航的类，它维护了一个页面栈（Navigator Stack）。
栈中的每个元素代表一个页面，而栈的顶部就是当前页面。
Navigator 提供了一系列方法，用于在页面之间进行切换、管理页面栈的状态等。

主要有 push，pushToName, pop, popUntil

2. Route 类
Route 是表示单个页面的抽象类，有多个实现类，包括 MaterialPageRoute、CupertinoPageRoute 等。
每个页面都对应一个 Route 对象，负责定义页面的生命周期、构建页面的内容、页面切换的动画效果等.

主要有  builder（构建页面）, didPop, didPush 使页面 入栈出栈

3. 路由生命周期
 在 Flutter 中，路由的生命周期主要包括以下几个阶段：
- 创建路由： 创建 Route 对象，用于表示即将显示的页面。
- 构建页面内容： 在 Route 的 build 方法中构建页面的内容。
- 推入导航栈： 当调用 Navigator.push 或 Navigator.pushReplacement 等方法时，将 Route 对象推入导航栈。在此过程中，会调用 Route 的 didPush 方法。
- 页面显示： 导航栈中的页面被显示在屏幕上。
- 返回上一页： 当用户触发返回操作（如点击返回按钮）时，当前页面将被从导航栈中弹出。在此过程中，会调用 Route 的 didPop 方法。
- 页面销毁： 当页面从导航栈中弹出后，如果没有被缓存，则该页面的 dispose 方法会被调用，用于释放资源。

4. 命名路由
Flutter 支持通过命名路由的方式进行页面导航。
在 MaterialApp 的 routes 属性中定义路由表，然后可以通过路由名称进行页面跳转。

MaterialApp(
  routes: {
    '/home': (context) => HomeScreen(),
    '/second': (context) => SecondScreen(),
  },
)
Navigator.pushNamed(context, '/second');

5. 其他路由参数

除了上述介绍的基本路由机制外，Flutter 还提供了其他一些高级功能，例如：

- 路由传参： 通过构造函数、路由表、ModalRoute 的 settings.arguments 等方式传递参数。
- 自定义路由切换动画： 通过自定义 PageRoute 的实现类，可以实现页面切换时的自定义动画效果。
- 监听页面返回事件： 使用 then 方法、await 关键字、WillPopScope 等方式监听页面返回事件。
- 总体而言，Flutter 的路由机制是灵活且强大的，开发者可以根据应用的需求选择合适的导航方式，并在页面切换的过程中执行自定义的逻辑。

 */

class PageRouteTest extends StatefulWidget {
  const PageRouteTest({super.key});

  @override
  State<PageRouteTest> createState() => _PageRouteTestState();
}

class _PageRouteTestState extends State<PageRouteTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('路由'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('监测上一页返回的 值'),
            SizedBox(
              height: 10,
            ),
            Text('1：await  Navigator push 传值'),
            TextButton(
                onPressed: () async {
                  var res = await Navigator.of(context).push(MaterialPageRoute(
                      builder: (w) {
                        return _Page1();
                      },
                      settings: RouteSettings(arguments: {'value': 234})));
                  _showDialogName(context, res);
                },
                child: Text('push 下一页')),
            SizedBox(height: 10),
            Text('2：Navigator push then 获取返回的值'),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (c) {
                    return _Page1();
                  })).then((value) {
                    _showDialogName(context, value);
                  });
                },
                child: Text('push 下一页')),
            SizedBox(height: 10),
            Text('3：WillPopScope 监听当前页 返回事件'),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (c) {
                    return _Page2(
                      value: '222',
                    );
                  }));
                },
                child: Text('push 下一页')),
            SizedBox(height: 10),
            Text('4：ModalRoute addScopedWillPopCallback 监听当前页 返回事件'),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (c) {
                    return _Page1(useModalWay: true);
                  }));
                },
                child: Text('push 下一页')),
            SizedBox(height: 10),
            Text('5：override PageRoute for Navigator.push'),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(_CustomerRoute((c) {
                    return _Page1(useModalWay: false);
                  }));
                },
                child: Text('push 下一页')),
            SizedBox(height: 10),
            Text('6：Navigator.pushNamed 传值arguments '),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteName.pageRouteTest3,
                      arguments: '1 传值成功');
                },
                child: Text('push 下一页')),
          ],
        ),
      ),
    );
  }

  void _showDialogName(BuildContext context, value) {
    showDialog(
        context: context,
        builder: (w) => SimpleDialog(
              title: Text('返回的值'),
              children: [Text('$value')],
            ));
  }
}

class _Page1 extends StatelessWidget {
  final bool? useModalWay;
  const _Page1({super.key, this.useModalWay = false});

  @override
  Widget build(BuildContext context) {
    if (useModalWay!) {
      _useModalWay(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Page1 第二页'),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                Navigator.pop(context, '123');
              },
              child: Text('pop 上一页 返回值')),
        ],
      ),
    );
  }

  void _useModalWay(BuildContext context) {
    ModalRoute.of(context)?.addScopedWillPopCallback(() {
      showDialog(
          context: context,
          builder: (c) {
            return SimpleDialog(
              title: Text('返回被拦截了'),
            );
          });

      return Future.value(true);
    });
  }
}

class _Page2 extends StatelessWidget {
  final String? value;
  const _Page2({super.key, this.value});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('hahaha');
        Navigator.pop(context, '123');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('第二页'),
        ),
        body: Column(
          children: [
            Text('获取 上一页值 为 $value'),
          ],
        ),
      ),
    );
  }
}

class PageRouteTest3 extends StatelessWidget {
  const PageRouteTest3({super.key});

  @override
  Widget build(BuildContext context) {
    // 通过命名路由的传值
    final value = ModalRoute.of(context)?.settings.arguments ??
        '未获得 ModalRoute settings.arguments';

    return Scaffold(
      appBar: AppBar(
        title: Text('第二页'),
      ),
      body: Column(
        children: [
          Text('获取 上一页值 为 $value'),
        ],
      ),
    );
  }
}

class _CustomerRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;

  _CustomerRoute(this.builder);

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => '';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder.call(context);
  }

  @override
  bool didPop(T? result) {
    // This function will be called when the user presses the back button
    print('add logic here for CustomPageRoute didPop');

    return super.didPop(result);
  }

  @override
  TickerFuture didPush() {
    // This function will be called when the user presses to push
    print('add logic here for CustomPageRoute didPush');

    return super.didPush();
  }

  @override
  void dispose() {
    print('CustomPageRoute dispose');

    super.dispose();
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    var offsetAnimation = animation.drive(tween);

    return SlideTransition(position: offsetAnimation, child: child);
  }
}
