import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CustomerAdapterState> buildReducer() {
  return asReducer(
    <Object, Reducer<CustomerAdapterState>>{
      CustomerAdapterAction.action: _onAction,
    },
  );
}

CustomerAdapterState _onAction(CustomerAdapterState state, Action action) {
  final CustomerAdapterState newState = state.clone();
  return newState;
}
