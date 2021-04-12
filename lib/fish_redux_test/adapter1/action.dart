import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum CustomerAdapterAction { action }

class CustomerAdapterActionCreator {
  static Action onAction() {
    return const Action(CustomerAdapterAction.action);
  }
}
