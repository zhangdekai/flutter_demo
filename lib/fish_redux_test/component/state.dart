import 'package:fish_redux/fish_redux.dart';
import 'package:weichatdemo/fish_redux_test/model/list_cell_model.dart';

class ListCellState implements Cloneable<ListCellState> {

  ListCellModel model;
  ListCellState({this.model});

  @override
  ListCellState clone() {
    return ListCellState()
      ..model = model;
  }
}

ListCellState initState(Map<String, dynamic> args) {
  return ListCellState();
}
