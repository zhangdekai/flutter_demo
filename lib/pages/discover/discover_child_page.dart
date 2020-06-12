import 'package:flutter/material.dart';

class DiscoverChildPage extends StatelessWidget {

  final String title;

  DiscoverChildPage( this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: Text('$title'),
      ),
    );
  }
}

