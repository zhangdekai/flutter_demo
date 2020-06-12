import 'package:flutter/material.dart';

class StateManagerDemo extends StatefulWidget {
  @override
  _StateManagerDemoState createState() => _StateManagerDemoState();
}

class _StateManagerDemoState extends State<StateManagerDemo> {

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StateManagerDemo'),
      ),
      body: Center(
        child: Chip(label: Text('$count')),//字符串获取数字
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            setState(() {
              count++;
            });

            print('count == $count');

          },child: Icon(Icons.add),),
    );
  }
}
