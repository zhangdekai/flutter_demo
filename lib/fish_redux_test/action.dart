import 'package:fish_redux/fish_redux.dart';
import 'package:weichatdemo/fish_redux_test/component/state.dart';
import 'package:weichatdemo/fish_redux_test/component1/state.dart';
import 'package:weichatdemo/fish_redux_test/model/list_cell_model.dart';

//TODO replace with your own action
enum FishReduxTestAction { action, tapAction, initDataList, initBottomData }

class FishReduxTestActionCreator {
  static Action onAction() {
    return const Action(FishReduxTestAction.action);
  }

  // 传递参数
  static Action tapAction(int number) {
    return  Action(FishReduxTestAction.action, payload: number);
  }

  static Action initDataList(List<ListCellState> list) {
    return  Action(FishReduxTestAction.initDataList, payload: list);
  }

  static Action initBottomData(ListBottomViewState state) {
    return  Action(FishReduxTestAction.initBottomData, payload: state);
  }

}
