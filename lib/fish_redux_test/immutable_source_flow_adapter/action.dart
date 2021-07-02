import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum ImmutableSourceFlowAction { action }

class ImmutableSourceFlowActionCreator {
  static Action onAction() {
    return const Action(ImmutableSourceFlowAction.action);
  }
}
