import 'package:fish_redux/fish_redux.dart';
import 'package:weichatdemo/fish_redux_test/dynamic_flow_adapter/adapter.dart';

import 'component1/component.dart';
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
                //给ListView 配置adapter
                adapter: NoneConn<FishReduxTestState>() + DynamicSourceFlowAdapter(),
                slots: <String, Dependent<FishReduxTestState>>{
                  'bottom': ListCellConnector() + ListBottomViewComponent()
                }),
            middleware: <Middleware<FishReduxTestState>>[
            ],);

}
