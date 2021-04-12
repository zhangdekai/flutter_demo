import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<list_cellState> buildReducer() {
  return asReducer(
    <Object, Reducer<list_cellState>>{
      list_cellAction.action: _onAction,
    },
  );
}

list_cellState _onAction(list_cellState state, Action action) {
  final list_cellState newState = state.clone();
  return newState;
}
