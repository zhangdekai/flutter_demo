import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:weichatdemo/pages/root_page.dart';
//import 'package:weichatdemo/share_data/inherited_demo.dart';
import 'package:weichatdemo/test_state_manager/state_mag_demo.dart';




void main() {

  return runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //一下两个可以取消点击 地菜单时的点击效果。
        highlightColor: Color.fromRGBO(1, 0, 0, 0),
        splashColor: Color.fromRGBO(1, 0, 0, 0),
        primarySwatch: Colors.yellow,//影响状态栏颜色呀？？
        cardColor: Color.fromRGBO(1, 1, 1, 0.65),


      ),
      home: RootPage(),// InheritedDemo   RootPage StateManagerDemo MyHomePage(title: 'Flutter Demo Home Page')
    );
  }
}