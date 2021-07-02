import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'component/state.dart';
import 'component1/state.dart';
import 'model/list_cell_model.dart';

class FishReduxTestState extends MutableSource implements Cloneable<FishReduxTestState> {

  String name;//= ''
  List<ListCellState> dataList = [];
  ListCellBottomModel bottomModel;
  TextEditingController textEditingController;
  Color gridColor = Colors.blueAccent[100];

  ListBottomViewState bottomViewState;

  // clone方法的赋值写法是必须的
  @override
  FishReduxTestState clone() {
    return FishReduxTestState()
      ..dataList = dataList
      ..name = name
      ..bottomModel = bottomModel
      ..gridColor = gridColor
      ..bottomViewState = bottomViewState;
  }

  @override
  Object getItemData(int index) {
    // TODO: implement getItemData
    return dataList[index];
  }

  @override
  String getItemType(int index) {
    // TODO: implement getItemType
    return 'listCell';//
  }

  @override
  // TODO: implement itemCount
  int get itemCount => dataList.length ?? 0;

  @override
  void setItemData(int index, Object data) {
    // TODO: implement setItemData
    dataList[index] = data;
  }
}

FishReduxTestState initState(Map<String, dynamic> args) {
  //初始化赋值操作
  return FishReduxTestState()
    ..textEditingController = TextEditingController()
    ..name = args['name'] ?? '--';//获取上一页面的数据

}

/// 自定义 connector
class ListCellConnector extends ConnOp<FishReduxTestState,ListBottomViewState> {

  @override
  ListBottomViewState get(FishReduxTestState state) {
    // TODO: implement get

    // print('ListBottomViewState get...');
    return state.bottomViewState; //ListBottomViewState(model: state.bottomModel, gridColor: state.gridColor);
  }

  @override
  void set(FishReduxTestState state, ListBottomViewState subState) {
    // TODO: implement set
    print('set(');
    state.bottomViewState = subState;
    state.gridColor = subState.gridColor;

  }
}
