import 'package:fish_redux/fish_redux.dart';
import 'package:weichatdemo/fish_redux_test/component/state.dart';

//TODO replace with your own action
enum DynamicSourceFlowAction { changePageName }

class DynamicSourceFlowActionCreator {
  static Action changePageName(ListCellState state) {
    return  Action(DynamicSourceFlowAction.changePageName, payload: state);
  }
}
