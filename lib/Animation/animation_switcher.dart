import 'package:flutter/material.dart';

main() => runApp(MaterialApp(
      home: const AnimationSwitcherTest(),
    ));

class AnimationSwitcherTest extends StatefulWidget {
  const AnimationSwitcherTest({super.key});

  @override
  State<AnimationSwitcherTest> createState() => _AnimationSwitcherTestState();
}

class _AnimationSwitcherTestState extends State<AnimationSwitcherTest> {
  int _count = 0;

  int actionType = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedSwitcher'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'AnimatedSwitcher child 新旧值切换时的动画， \n 注意 child + Key 区分不同的2个child ',
              textAlign: TextAlign.center,
              textScaleFactor: 1.3,
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                var tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));

                if (actionType == 1) {
                  //执行缩放动画
                  return ScaleTransition(child: child, scale: animation);
                } else if (actionType == 2) {
                  //执行Rotation动画
                  return RotationTransition(child: child, turns: animation);
                } else if (actionType == 3) {
                  //执行Fade动画
                  return FadeTransition(child: child, opacity: animation);
                } else if (actionType == 4) {
                  //执行Size动画
                  return SizeTransition(child: child, sizeFactor: animation);
                } else if (actionType == 5) {
                  //执行MySlide动画
                  var tween = Tween(begin: Offset(1, 0), end: Offset(0, 0));
                  return MySlideTransition(
                      position: tween.animate(animation), child: child);
                } else if (actionType == 6) {
                  //执行SlideTransition动画
                  return SlideTransition(
                    position: tween.animate(animation),
                    child: child,
                    textDirection: TextDirection.rtl,
                  );
                } else if (actionType == 7) {
                  actionType = 0;
                  //执行SlideTransition动画
                  return SlideTransitionX(
                    child: child,
                    direction: AxisDirection.down, //上入下出
                    position: animation,
                  );
                }

                return ScaleTransition(child: child, scale: animation);
              },
              child: Text(
                '$_count',
                //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                key: ValueKey<int>(_count),
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
              child: const Text(
                '+1',
              ),
              onPressed: () {
                setState(() {
                  _count += 1;
                  actionType += 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MySlideTransition extends AnimatedWidget {
  const MySlideTransition({
    Key? key,
    required Animation<Offset> position,
    this.transformHitTests = true,
    required this.child,
  }) : super(key: key, listenable: position);

  final bool transformHitTests;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final position = listenable as Animation<Offset>;
    Offset offset = position.value;
    if (position.status == AnimationStatus.reverse) {
      offset = Offset(-offset.dx, offset.dy);
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}

/// 可上下左右 方向  滑出数字，划入数字
class SlideTransitionX extends AnimatedWidget {
  SlideTransitionX({
    Key? key,
    required Animation<double> position,
    this.transformHitTests = true,
    this.direction = AxisDirection.down,
    required this.child,
  }) : super(key: key, listenable: position) {
    switch (direction) {
      case AxisDirection.up:
        _tween = Tween(begin: const Offset(0, 1), end: const Offset(0, 0));
        break;
      case AxisDirection.right:
        _tween = Tween(begin: const Offset(-1, 0), end: const Offset(0, 0));
        break;
      case AxisDirection.down:
        _tween = Tween(begin: const Offset(0, -1), end: const Offset(0, 0));
        break;
      case AxisDirection.left:
        _tween = Tween(begin: const Offset(1, 0), end: const Offset(0, 0));
        break;
    }
  }

  final bool transformHitTests;

  final Widget child;

  final AxisDirection direction;

  late final Tween<Offset> _tween;

  @override
  Widget build(BuildContext context) {
    final position = listenable as Animation<double>;
    Offset offset = _tween.evaluate(position);

    if (position.status == AnimationStatus.reverse) {
      switch (direction) {
        case AxisDirection.up:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.right:
          offset = Offset(-offset.dx, offset.dy);
          break;
        case AxisDirection.down:
          offset = Offset(offset.dx, -offset.dy);
          break;
        case AxisDirection.left:
          offset = Offset(-offset.dx, offset.dy);
          break;
      }
    }
    return FractionalTranslation(
      translation: offset,
      transformHitTests: transformHitTests,
      child: child,
    );
  }
}
