import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliverTestPage extends StatefulWidget {
  const SliverTestPage({Key key}) : super(key: key);

  @override
  _SliverTestPageState createState() => _SliverTestPageState();
}

class _SliverTestPageState extends State<SliverTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(),
    );
  }
}
