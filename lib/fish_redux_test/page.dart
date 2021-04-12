import 'package:fish_redux/fish_redux.dart';

import 'adapter/adapter.dart';
import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class FishReduxTestPage extends Page<FishReduxTestState, Map<String, dynamic>> {
  FishReduxTestPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<FishReduxTestState>(
                slots: <String, Dependent<FishReduxTestState>>{
                }),
            middleware: <Middleware<FishReduxTestState>>[
            ],);

}
