import 'package:fish_redux/fish_redux.dart';

class list_cellState implements Cloneable<list_cellState> {

  @override
  list_cellState clone() {
    return list_cellState();
  }
}

list_cellState initState(Map<String, dynamic> args) {
  return list_cellState();
}
