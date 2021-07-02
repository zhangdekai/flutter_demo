import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ImmutableSourceFlowState> buildReducer() {
  return asReducer(
    <Object, Reducer<ImmutableSourceFlowState>>{
      ImmutableSourceFlowAction.action: _onAction,
    },
  );
}

ImmutableSourceFlowState _onAction(ImmutableSourceFlowState state, Action action) {
  final ImmutableSourceFlowState newState = state.clone();
  return newState;
}
