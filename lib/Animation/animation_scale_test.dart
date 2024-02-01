import 'package:flutter/material.dart';

/// 演示一下最基础的动画实现方式
class ScaleAnimationRoute extends StatefulWidget {
  const ScaleAnimationRoute({Key? key}) : super(key: key);

  @override
  _ScaleAnimationRouteState createState() => _ScaleAnimationRouteState();
}

//需要继承TickerProvider，如果有多个AnimationController，则应该使用TickerProviderStateMixin。
class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  initState() {
    super.initState();
    _init();
  }

  void _init() {
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    // 加入 Curve 曲线变化 动画
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);

    //图片宽高从0变到300
    // _animationListen();

    animation = Tween(begin: 0.0, end: 350.0).animate(animation);

    // _addStatusListener();

    // animation.value   0 --> 400.0
    // controller.value  0 --> 1.0

    //启动动画(正向执行)
    controller.forward();
  }

  void _addStatusListener() {
    return animation.addStatusListener((status) {
    if (status == AnimationStatus.dismissed) {
      controller.forward();
    } else if (status == AnimationStatus.completed) {
      controller.reverse();
    }
  });
  }

  void _animationListen() {
    animation = Tween(begin: 0.0, end: 400.0).animate(animation)
      ..addListener(() {
        // print('animation.value  == ${animation.value}');
        // print('controller.value  == ${controller.value}');

        setState(() => {});
      });
  }

  @override
  Widget build(BuildContext context) {
    print('ScaleAnimation build');

    return Scaffold(
      appBar: AppBar(title: Text('Scale Animation')),
      body: Stack(
        children: [
          AnimatedBuilder(
              animation: animation,
              child: Image.asset("assets/stone.png", fit: BoxFit.fill),
              builder: (c, child) {
                // print('AnimatedBuilder builder...');
                return SizedBox(
                    width: animation.value,
                    height: animation.value,
                    child: child);
              }),
          Positioned(
            top: 400,
            left: 100,
            child: TextButton(
                onPressed: () {
                  controller.reset();
                  controller.forward();
                },
                child: Text('Start again',style: TextStyle(color: Colors.red),)),
          )
        ],
      ),
    );
  }

  @override
  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }
}
