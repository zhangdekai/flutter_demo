import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bloc_test/view.dart';
import 'cubit_test/view.dart';
/*
https://juejin.cn/post/6856268776510504968

 */

class FlutterBlocTestPage extends StatefulWidget {
  const FlutterBlocTestPage({super.key});

  @override
  State<FlutterBlocTestPage> createState() => _FlutterBlocTestPageState();
}

class _FlutterBlocTestPageState extends State<FlutterBlocTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Bloc Test Pager'),
      ),
      body: Column(
        children: [
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (c) => CubitTestPage()));
              },
              child: Text('Flutter Cubit Test Page')),
          SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(CupertinoPageRoute(builder: (c) => BlocTestPage()));
              },
              child: Text('Flutter Bloc Test Page')),
        ],
      ),
    );
  }
}
