import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:weichatdemo/fish_redux_test/model/list_cell_model.dart';

class ListBottomViewState implements Cloneable<ListBottomViewState> {

  ListCellBottomModel model;
  Color gridColor;


  ListBottomViewState({this.model, this.gridColor});

  @override
  ListBottomViewState clone() {
    return ListBottomViewState()
      ..model = model
      ..gridColor = gridColor;
  }
}

ListBottomViewState initState(Map<String, dynamic> args) {
  return ListBottomViewState();
}
