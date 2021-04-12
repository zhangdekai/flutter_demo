import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<listview_adapterState> buildReducer() {
  return asReducer(
    <Object, Reducer<listview_adapterState>>{
      listview_adapterAction.action: _onAction,
    },
  );
}

listview_adapterState _onAction(listview_adapterState state, Action action) {
  final listview_adapterState newState = state.clone();
  return newState;
}
