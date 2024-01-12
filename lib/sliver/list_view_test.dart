import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weiChatDemo/base/base_view.dart';

class ListViewTestPage extends BaseView{

  @override
  String get title => 'ListView Test';

  @override
  Widget buildPage(BuildContext context) {
    return ListView.separated(itemBuilder: (c,i){
      return ListTile(title: Text('$i - ${c.runtimeType}'),);

    }, separatorBuilder: (c,i){
      return const Divider();
    }, itemCount: 20);
  }

}