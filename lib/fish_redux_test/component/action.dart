import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum list_cellAction { action }

class list_cellActionCreator {
  static Action onAction() {
    return const Action(list_cellAction.action);
  }
}
