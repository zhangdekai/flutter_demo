import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';

class ImmutableSourceFlowAdapter extends SourceFlowAdapter<ImmutableSourceFlowState> {
  ImmutableSourceFlowAdapter()
      : super(
          pool: <String, Component<Object>>{},
          reducer: buildReducer(),
          );
}
