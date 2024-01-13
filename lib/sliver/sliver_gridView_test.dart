import 'package:flutter/material.dart';
import 'package:weiChatDemo/base/base_view.dart';

class GridViewPageTest extends BaseView {
  @override
  String get title => 'GridView ';

  @override
  Widget buildPage(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, //横轴三个子widget
          childAspectRatio: 1, //宽高比为1时，子widget
          mainAxisSpacing: 16,
          crossAxisSpacing: 16),
      itemBuilder: (c, i) {
        return ColoredBox(
          child: _children[i],
          color: Colors.greenAccent,
        );
      },
      itemCount: _children.length,
    );
  }

  List<Widget> get _children {
    return <Widget>[
      Icon(Icons.ac_unit),
      Icon(Icons.airport_shuttle),
      Icon(Icons.all_inclusive),
      Icon(Icons.beach_access),
      Icon(Icons.cake),
      Icon(Icons.free_breakfast)
    ];
  }
}
