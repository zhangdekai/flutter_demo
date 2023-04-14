import 'package:fish_redux/fish_redux.dart';
import 'package:weichatdemo/fish_redux_test/component/state.dart';
import '../state.dart';
import 'action.dart';

Reducer<FishReduxTestState> buildReducer() {
  return asReducer(
    <Object, Reducer<FishReduxTestState>>{
      DynamicSourceFlowAction.changePageName: _changePageName,
    },
  );
}

FishReduxTestState _changePageName(FishReduxTestState state, Action action) {
  final FishReduxTestState newState = state.clone();
  ListCellState temp = action.payload as ListCellState;
  newState.name = temp.model.title;
  return newState;
}
