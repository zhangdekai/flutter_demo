import 'package:fish_redux/fish_redux.dart';

class CSCustomFlowState implements Cloneable<CSCustomFlowState> {

  @override
  CSCustomFlowState clone() {
    return CSCustomFlowState();
  }
}

CSCustomFlowState initState(Map<String, dynamic> args) {
  return CSCustomFlowState();
}
