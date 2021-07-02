import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CSStaticFlowState> buildReducer() {
  return asReducer(
    <Object, Reducer<CSStaticFlowState>>{
      CSStaticFlowAction.action: _onAction,
    },
  );
}

CSStaticFlowState _onAction(CSStaticFlowState state, Action action) {
  final CSStaticFlowState newState = state.clone();
  return newState;
}
