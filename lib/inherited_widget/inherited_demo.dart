import 'package:flutter/material.dart';

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
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>()!;
//    return context.inheritFromWidgetOfExactType(MyData) as MyData;
  }

  @override
  bool updateShouldNotify(MyInheritedWidget old) {
    return old.data != data;
  }
}

class InheritedDemo extends StatefulWidget {
  @override
  _InheritedDemoState createState() => _InheritedDemoState();
}

class _InheritedDemoState extends State<InheritedDemo> {
  int count = 1;
  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(count,
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
        ));
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
