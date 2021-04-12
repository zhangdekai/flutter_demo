import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class list_cellComponent extends Component<list_cellState> {
  list_cellComponent()
      : super(
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<list_cellState>(
                adapter: null,
                slots: <String, Dependent<list_cellState>>{
                }),);

}
