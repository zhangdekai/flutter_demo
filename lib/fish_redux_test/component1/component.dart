import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ListBottomViewComponent extends Component<ListBottomViewState> {
  ListBottomViewComponent()
      : super(
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ListBottomViewState>(
                adapter: null,
                slots: <String, Dependent<ListBottomViewState>>{
                }),);

}
