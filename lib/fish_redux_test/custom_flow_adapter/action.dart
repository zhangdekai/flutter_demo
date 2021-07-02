import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum CSCustomFlowAction { action }

class CSCustomFlowActionCreator {
  static Action onAction() {
    return const Action(CSCustomFlowAction.action);
  }
}
