import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ListBottomViewAction { action, changeGridColor }

class ListBottomViewActionCreator {
  static Action onAction() {
    return const Action(ListBottomViewAction.action);
  }

  static Action changeGridColor() {
    return Action(ListBottomViewAction.changeGridColor);
  }

}
