import 'package:fish_redux/fish_redux.dart';

class CSStaticFlowState implements Cloneable<CSStaticFlowState> {

  @override
  CSStaticFlowState clone() {
    return CSStaticFlowState();
  }
}

CSStaticFlowState initState(Map<String, dynamic> args) {
  return CSStaticFlowState();
}
