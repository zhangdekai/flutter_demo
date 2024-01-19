import 'package:flutter/material.dart';
import 'package:weiChatDemo/base/base_view.dart';

/// Custom Animation can extends ImplicitlyAnimatedWidget
/// State can also extends AnimatedWidgetBaseState
/// The State itself have his animationController, curve, tween.
///
class AnimatedDecoratedBox extends ImplicitlyAnimatedWidget {
  final BoxDecoration decoration;
  final Widget child;

  const AnimatedDecoratedBox({
    Key? key,
    required this.decoration,
    required this.child,
    Curve curve = Curves.linear,
    required Duration duration,
  }) : super(
          key: key,
          curve: curve,
          duration: duration,
        );

  @override
  _AnimatedDecoratedBoxState createState() {
    return _AnimatedDecoratedBoxState();
  }
}

class _AnimatedDecoratedBoxState
    extends AnimatedWidgetBaseState<AnimatedDecoratedBox> {
  DecorationTween? _decoration;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: _decoration == null
          ? BoxDecoration(color: Colors.white)
          : _decoration!.evaluate(animation),
      child: widget.child,
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _decoration = visitor(
      _decoration,
      widget.decoration,
      (value) => DecorationTween(begin: value),
    ) as DecorationTween;
  }
}

class AnimationCustomExample extends StatefulWidget {
  const AnimationCustomExample({super.key});

  @override
  State<AnimationCustomExample> createState() => _AnimationCustomExampleState();
}

class _AnimationCustomExampleState extends State<AnimationCustomExample> {
  Color _decorationColor = Colors.greenAccent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedDecoratedBox'),
      ),
      body: Center(
        child: Column(
          children: [
            AnimatedDecoratedBox(
                decoration: BoxDecoration(color: _decorationColor),
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Text('修改decoration Color'),
                ),
                duration: Duration(milliseconds: 500)),
            TextButton(
                onPressed: () {
                  setState(() {
                    _decorationColor = Colors.red;
                  });
                },
                child: Text('修改为 红色'))
          ],
        ),
      ),
    );
  }
}
