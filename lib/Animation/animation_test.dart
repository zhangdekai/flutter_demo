import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
/*
1: AnimatedContainer   widget属性有动画
2: AnimatedSwitcher  两个widget 之间切换


 */

class AnimationTest extends StatefulWidget {
  const AnimationTest({Key key}) : super(key: key);

  @override
  _AnimationTestState createState() => _AnimationTestState();
}

class _AnimationTestState extends State<AnimationTest> {
  bool selected = false;
  String tempString = 'hello';
  int number = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimationTest'),
      ),
      body:
          _fanGunWidgetTest(), // _fanGunWidgetTest,  _animatedSwitcher, animatedContainerTest()
      floatingActionButton: TextButton(
          onPressed: () {
            setState(() {
              selected = !selected;
              tempString = tempString + '1';
            });
          },
          child: Text(
            'Set',
            style: TextStyle(color: Colors.black, fontSize: 30),
          )),
    );
  }

  Widget _fanGunWidgetTest() {
    return Center(
      child: Container(
        height: 120,
        // width: 300,
        color: Colors.blue[300],
        child: Row(
          children: [
            AnimatedCounter(
              value: 1,
              duration: Duration(milliseconds: 500),
            ),
            AnimatedCounter(
              value: 8,
              duration: Duration(milliseconds: 500),
            ),
            AnimatedCounter(
              value: number,
              duration: Duration(milliseconds: 500),
            ),
            IconButton(
                icon: Icon(
                  Icons.add,
                  size: 40,
                ),
                onPressed: () {
                  setState(() {
                    number++;
                  });
                })
          ],
        ),
      ),
    );
  }

  Widget _animatedContainerTest() {
    return Center(
      child: AnimatedContainer(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.blue, Colors.yellow],
              stops: [0.2, 0.5]),
          borderRadius: BorderRadius.circular(75),
          boxShadow: [BoxShadow(spreadRadius: 2, blurRadius: 15)], //
          // color: selected ? Colors.red : Colors.blue,
        ),
        width: selected ? 250.0 : 150.0,
        height: selected ? 250.0 : 150.0,
        alignment: selected ? Alignment.center : AlignmentDirectional.topCenter,
        duration: Duration(seconds: 2),
        curve: Curves.fastOutSlowIn,
        child: FlutterLogo(size: 75),
      ),
    );
  }

  ///AnimatedSwitcher
  Widget _animatedSwitcher() {
    return Center(
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        color: Colors.blue,
        width: selected ? 250.0 : 150.0,
        height: selected ? 250.0 : 150.0,
        child: AnimatedSwitcher(
          duration: Duration(seconds: 1),
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          child: Text(
            tempString,
            key: UniqueKey(),
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}

class AnimatedCounter extends StatelessWidget {
  final int value;
  final Duration duration;

  const AnimatedCounter(
      {Key key, @required this.value, @required this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween(end: value.toDouble()),
      duration: duration,
      builder: (BuildContext context, double value, Widget child) {
        final whole = value ~/ 1;
        final decimal = value - whole;
        print('$whole + $decimal');
        return Expanded(
          child: Stack(
            children: [
              Positioned(
                  top: -100 * decimal, // 0 --> 100
                  child: Opacity(
                    opacity: 1 - decimal,
                    child: Text(
                      '$whole',
                      style: TextStyle(fontSize: 100),
                    ),
                  )),
              Positioned(
                  top: 100 - decimal * 100, // 100 --> 0
                  child: Opacity(
                    opacity: decimal,
                    child: Text(
                      '${whole + 1}',
                      style: TextStyle(fontSize: 100),
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}
