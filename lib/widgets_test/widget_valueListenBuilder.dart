import 'package:flutter/material.dart';
import 'package:weiChatDemo/base/base_view.dart';

class _ValueModel {
  int count = 10;
  String name = '-哈雷-';
}

class ValueListenBuildTest extends BaseView {
  @override
  String get title => 'ValueListenableBuilder Test';

  final _valueNotifier = ValueNotifier(_ValueModel());

  @override
  Widget buildPage(BuildContext context) {
    return Column(children: [
      SizedBox(height: 20),
      Text('ValueListenableBuilder:'),
      SizedBox(height: 20),
      ValueListenableBuilder<_ValueModel>(
          valueListenable: _valueNotifier,
          builder: (context, value, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${value.count}'),
                SizedBox(width: 10),
                Text('${value.name}')
              ],
            );
          }),
      SizedBox(height: 20),
      TextButton(
          onPressed: () {
            _valueNotifier.value = _ValueModel()
              ..count = 100
              ..name = '斯康杜尼流口水';
          },
          child: Text('修改 valueNotifier'))
    ]);
  }
}
