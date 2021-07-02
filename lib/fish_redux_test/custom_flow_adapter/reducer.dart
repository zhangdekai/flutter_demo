import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CSCustomFlowState> buildReducer() {
  return asReducer(
    <Object, Reducer<CSCustomFlowState>>{
      CSCustomFlowAction.action: _onAction,
    },
  );
}

CSCustomFlowState _onAction(CSCustomFlowState state, Action action) {
  final CSCustomFlowState newState = state.clone();
  return newState;
}
