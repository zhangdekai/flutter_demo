import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum CSStaticFlowAction { action }

class CSStaticFlowActionCreator {
  static Action onAction() {
    return const Action(CSStaticFlowAction.action);
  }
}
