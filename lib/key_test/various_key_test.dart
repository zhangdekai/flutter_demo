import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VariousKeyTest extends StatefulWidget {
  const VariousKeyTest({Key? key}) : super(key: key);

  @override
  _VariousKeyTestState createState() => _VariousKeyTestState();
}

class _VariousKeyTestState extends State<VariousKeyTest> {
  GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    // UniqueKey();
    // GlobalKey();
    return Scaffold(
      appBar: AppBar(
        title: Text('VariousKey'),
      ),
      body: colorGameTest1(), // colorGameTest1, keyTest, colorGameTest
    );
  }

  final boxs = [
    BoxColor(
      color: Colors.cyan[200],
      key: UniqueKey(),
    ),
    BoxColor(
      color: Colors.cyan[400],
      key: UniqueKey(),
    ),
    BoxColor(
      color: Colors.cyan[600],
      key: UniqueKey(),
    ),
    BoxColor(
      color: Colors.cyan[700],
      key: UniqueKey(),
    ),
    BoxColor(
      color: Colors.cyan[800],
      key: UniqueKey(),
    ),
    Divider(
      thickness: 3,
      color: Colors.green,
    ),
  ];

  Widget colorGameTest1() {
    return Center(
      child: Listener(
        onPointerMove: (event) {
          print('event.position.dx = ${event.position.dx}');
          print('event.position.dy = ${event.position.dy}');
        },
        child: Column(children: boxs),
      ),
    );
  }

  /// ReorderableListView 可拖动子元素 widget
  Widget colorGameTest() {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: ReorderableListView(
              // scrollDirection: Axis.horizontal,
              onReorder: (int oldIndex, int newIndex) {
                if (newIndex > oldIndex) {
                  // 解决从index 0 拖到 2 crash
                  newIndex--;
                }
                print('oldIndex is $oldIndex, newIndex is $newIndex');
                final box = boxs.removeAt(oldIndex);
                boxs.insert(newIndex, box);
              },
              children: boxs,
            ),
          ),
          // SizedBox(
          //   height: 100,
          // ),
          Divider(thickness: 30, color: Colors.green),
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  boxs.shuffle();
                });
              })
        ],
      ),
    );
  }

  Widget keyTest() {
    return Center(
      child: InkWell(
        onTap: () {
          final data = (_globalKey.currentWidget as TestGlobalWidget).data;

          print('获取 TestGlobalWidget data = $data');
        },
        child: Container(
          height: 200,
          width: 100,
          color: Colors.cyan[200],
          child: Column(
            children: [
              Container(
                key: ValueKey(1),
                color: Colors.red,
                child: Text('1'),
              ),
              Container(
                key: ObjectKey(2),
                color: Colors.blue,
                child: Text('2'),
              ),
              Container(
                key: ObjectKey(3),
                color: Colors.yellow,
                child: Text('3'),
              ),

              TestGlobalWidget(
                key: _globalKey,
                data: 1290,
              ),

              // TextField(),
            ],
          ),
        ),
      ),
    );
  }
}

class BoxColor extends StatelessWidget {
  final Color? color;
  const BoxColor({Key? key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Draggable(
      child: Container(
        margin: EdgeInsets.all(8.0),
        color: color,
        width: 50,
        height: 50,
      ),
      feedback: Container(
        margin: EdgeInsets.all(8.0),
        color: color,
        width: 50,
        height: 50,
      ),
      childWhenDragging: Container(
        margin: EdgeInsets.all(8.0),
        width: 50,
        height: 50,
      ),
    );
  }
}

class TestGlobalWidget extends StatefulWidget {
  final int? data;

  const TestGlobalWidget({Key? key, this.data}) : super(key: key);

  @override
  _TestGlobalWidgetState createState() => _TestGlobalWidgetState();
}

class _TestGlobalWidgetState extends State<TestGlobalWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: Colors.amber,
      child: Text('data is ${widget.data}'),
    );
  }
}
