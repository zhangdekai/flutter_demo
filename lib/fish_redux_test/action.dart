import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum FishReduxTestAction { action, tapAction }

class FishReduxTestActionCreator {
  static Action onAction() {
    return const Action(FishReduxTestAction.action);
  }

  // 传递参数
  static Action tapAction(int number) {
    return  Action(FishReduxTestAction.action, payload: number);
  }
}
