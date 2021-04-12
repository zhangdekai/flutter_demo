import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

class FishReduxTestState implements Cloneable<FishReduxTestState> {

  int count;
  String name;

  TextEditingController textEditingController;

  // clone方法的赋值写法是必须的
  @override
  FishReduxTestState clone() {
    return FishReduxTestState();
  }
}

FishReduxTestState initState(Map<String, dynamic> args) {
  //初始化赋值操作
  return FishReduxTestState()..count = 0
  ..textEditingController = TextEditingController()
  ..name = args['name'] ?? '--';//获取上一页面的数据

}
