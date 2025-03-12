import 'package:flutter/material.dart';

import 'animation_custom_decorateBox.dart';

class AnimatedWidgetsTest1 extends StatefulWidget {
  const AnimatedWidgetsTest1({Key? key}) : super(key: key);

  @override
  _AnimatedWidgetsTestState createState() => _AnimatedWidgetsTestState();
}

class _AnimatedWidgetsTestState extends State<AnimatedWidgetsTest1> {
  double _padding = 10;
  var _align = Alignment.topRight;
  double _height = 100;
  double _left = 0;
  Color _color = Colors.red;
  TextStyle _style = const TextStyle(color: Colors.black);
  Color _decorationColor = Colors.blue;
  double _opacity = 1;
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    var duration = const Duration(milliseconds: 400);
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedWidgetsTest1'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _padding = 20;
                });
              },
              child: AnimatedPadding(
                duration: duration,
                padding: EdgeInsets.all(_padding),
                child: const Text("AnimatedPadding"),
              ),
            ),
            SizedBox(
              height: 50,
              child: Stack(
                children: <Widget>[
                  AnimatedPositioned(
                    duration: duration,
                    left: _left,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _left = 100;
                        });
                      },
                      child: const Text("AnimatedPositioned"),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 100,
              color: Colors.grey,
              child: AnimatedAlign(
                duration: duration,
                alignment: _align,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _align = Alignment.center;
                    });
                  },
                  child: const Text("AnimatedAlign"),
                ),
              ),
            ),
            AnimatedSize(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '1 Tap to ${_isExpanded ? 'collapse' : 'expand'}!',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                    ),
                    if (_isExpanded) ...[
                      SizedBox(height: 10),
                      Text(
                        'Dynamic content will appear here when expanded.',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            ColoredBox(
              color: Colors.yellow,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSize(
                    duration: Duration(milliseconds: 500),
                    child: _isExpanded
                        ? Column(
                            children: [
                              SizedBox(height: 10),
                              Text(
                                'Dynamic content will appear here when expanded.',
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              )
                            ],
                          )
                        : Offstage(),
                  ),
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '1 Tap to ${_isExpanded ? 'collapse' : 'expand'}!',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              padding: EdgeInsets.all(16),
              width: 300,
              // height: _isExpanded ? 200 : 60,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    child: Text(
                      'Tap to ${_isExpanded ? 'collapse' : 'expand'}!',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    onTap: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                  ),
                  if (_isExpanded) ...[
                    SizedBox(height: 10),
                    Text(
                      'Dynamic content will appear here when expanded.',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ],
              ),
            ),
            AnimatedContainer(
              duration: duration,
              height: _height,
              color: _color,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _height = 150;
                    _color = Colors.blue;
                  });
                },
                child: const Text(
                  "AnimatedContainer",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            AnimatedDefaultTextStyle(
              child: GestureDetector(
                child: const Text("hello world"),
                onTap: () {
                  setState(() {
                    _style = const TextStyle(
                      color: Colors.blue,
                      decorationStyle: TextDecorationStyle.solid,
                      decorationColor: Colors.blue,
                    );
                  });
                },
              ),
              style: _style,
              duration: duration,
            ),
            AnimatedOpacity(
              opacity: _opacity,
              duration: duration,
              child: TextButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                onPressed: () {
                  setState(() {
                    _opacity = 0.2;
                  });
                },
                child: const Text(
                  "AnimatedOpacity",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            AnimatedDecoratedBox(
              duration: Duration(milliseconds: _decorationColor == Colors.red ? 400 : 2000),
              decoration: BoxDecoration(color: _decorationColor),
              child: Builder(builder: (context) {
                return TextButton(
                  onPressed: () {
                    setState(() {
                      _decorationColor = _decorationColor == Colors.blue ? Colors.red : Colors.blue;
                    });
                  },
                  child: const Text(
                    "AnimatedDecoratedBox toggle",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }),
            )
          ].map((e) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: e,
            );
          }).toList(),
        ),
      ),
    );
  }
}
