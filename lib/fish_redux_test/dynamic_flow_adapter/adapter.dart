import 'package:fish_redux/fish_redux.dart';
import 'package:weichatdemo/fish_redux_test/component/component.dart';
import 'package:weichatdemo/fish_redux_test/state.dart';
import 'reducer.dart';

///The template is a Map that accepts an array-like data driven
class DynamicSourceFlowAdapter extends SourceFlowAdapter<FishReduxTestState> {
  DynamicSourceFlowAdapter()
      : super(
          pool: <String, Component<Object>>{
            'listCell': ListCellComponent(),
          },reducer: buildReducer()
  );
}
