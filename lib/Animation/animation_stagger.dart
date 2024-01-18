import 'package:flutter/material.dart';

///实现一个柱状图增长的动画：
//
// 开始时高度从0增长到300像素，同时颜色由绿色渐变为红色；这个过程占据整个动画时间的60%。
// 高度增长到300后，开始沿X轴向右平移200像素；这个过程占用整个动画时间的40%。
///

class StaggerAnimation extends StatelessWidget {
  final Animation<double> controller;

  late Animation<double> height;
  late Animation<Color?> color;
  late Animation<EdgeInsets> edgeInsets;

  StaggerAnimation({super.key, required this.controller}) {
    height = Tween(begin: 0.0, end: 300.0).animate(CurvedAnimation(
        parent: controller, curve: Interval(0, 0.6, curve: Curves.ease)));

    color = ColorTween(begin: Colors.green, end: Colors.red).animate(
        CurvedAnimation(
            parent: controller, curve: Interval(0, 0.6, curve: Curves.easeIn)));

    edgeInsets = Tween<EdgeInsets>(
            begin: EdgeInsets.only(left: 0), end: EdgeInsets.only(left: 200))
        .animate(CurvedAnimation(
            parent: controller, curve: Interval(0.6, 1, curve: Curves.ease)));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (c, child) {
          return Container(
            padding: edgeInsets.value,
            alignment: Alignment.bottomLeft,
            child: Container(
              color: color.value,
              height: height.value,
              width: 50,
            ),
          );
        });
  }
}

class StaggerAnimationTest extends StatefulWidget {
  const StaggerAnimationTest({super.key});

  @override
  State<StaggerAnimationTest> createState() => _StaggerAnimationTestState();
}

class _StaggerAnimationTestState extends State<StaggerAnimationTest>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
  }

  Future<void> _play() async {
    await animationController.forward().orCancel;

    await animationController.reverse().orCancel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stagger Animation'),
      ),
      body: Column(
        children: [
          Container(
              width: 300,
              height: 300,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.grey[200]!)),
              child: StaggerAnimation(controller: animationController)),
          TextButton(onPressed: _play, child: Text('Start Animation'))
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}
