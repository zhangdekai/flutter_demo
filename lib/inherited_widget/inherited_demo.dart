import 'package:flutter/material.dart';
///  InheritedWidget: Base class for widgets that efficiently propagate information down the tree.
///  widget 基类，可以有效在树向下传播信息。（共享数据）
///  Flutter SDK 通过InheritedWidget 来共享 Theme 和 Local
///  InheritedWidget的在 widget 树中数据传递方向是从上到下的，这和通知Notification的传递方向正好相反

class MyInheritedWidget extends InheritedWidget {
  final int data; //需要在子Widget中共享的数据

  const MyInheritedWidget(
    this.data, {
    Key? key,
    required Widget child,
  })  : assert(child != null),
        super(key: key, child: child);

  //提供一个方法让子Widget访问的共享数据
  static MyInheritedWidget of(BuildContext context) {
    // context.getElementForInheritedWidgetOfExactType();

    //Returns the nearest widget of the given type `T` and creates a dependency
    //on it, or null if no appropriate widget is found.
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>()!;
  }

  @override
  bool updateShouldNotify(MyInheritedWidget old) {
    return old.data != data;
  }
}

class InheritedWidgetDemo extends StatefulWidget {
  @override
  _InheritedWidgetDemoState createState() => _InheritedWidgetDemoState();
}

class _InheritedWidgetDemoState extends State<InheritedWidgetDemo> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('InheritedWidgetDemo'),
      ),
      body: MyInheritedWidget(count,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 100),
            child: Column(
              children: <Widget>[
                Test1(),
                TextButton(
                  child: Text('我是按钮'),
                  onPressed: () {
                    setState(() {
                      count++;
                    });
                  },
                )
              ],
            ),
          )),
    );
  }
}

class Test1 extends StatelessWidget {
//  final count;
//  Test1(this.count);
  @override
  Widget build(BuildContext context) {
    return Test2();
  }
}

class Test2 extends StatelessWidget {
//  final count;
//  Test2(this.count);
  @override
  Widget build(BuildContext context) {
    return Test3();
  }
}

class Test3 extends StatefulWidget {
//  final count;
//  Test3(this.count);
  @override
  _Test3State createState() => _Test3State();
}

class _Test3State extends State<Test3> {
  @override
  Widget build(BuildContext context) {
    return Text(MyInheritedWidget.of(context).data.toString());
//    return Text(MyData.of(context).data.toString());
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    super.didChangeDependencies();
  }
}
