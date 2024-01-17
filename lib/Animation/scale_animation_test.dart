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
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceInOut);

    //匀速
    //图片宽高从0变到300
    animation = Tween(begin: 0.0, end: 400.0).animate(animation)
      ..addListener(() {
        // print('animation.value  == ${animation.value}');
        // print('controller.value  == ${controller.value}');

        setState(() => {});
      });
    // animation.value   0 --> 400.0
    // controller.value  0 --> 1.0

    //启动动画(正向执行)
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    print('ScaleAnimation build');

    return Scaffold(
      appBar: AppBar(title: Text('Scale Animation')),
      body: Stack(
        children: [
          SizedBox(
              width: animation.value,
              height: animation.value,
              child: Image.asset(
                "asset/stone.png",
                fit: BoxFit.fill
              )),
          Positioned(
            top: 450,
            child: TextButton(
                onPressed: () {
                  controller.reset();
                  controller.forward();
                },
                child: Text('Start again')),
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
