import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum listview_adapterAction { action }

class listview_adapterActionCreator {
  static Action onAction() {
    return const Action(listview_adapterAction.action);
  }
}
