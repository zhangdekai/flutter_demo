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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimationTest'),
      ),
      body: _animatedSwitcher(), //  _animatedSwitcher, animatedContainerTest()
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
