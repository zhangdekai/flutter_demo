import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';

import 'reducer.dart';
import 'state.dart';

class CSCustomFlowAdapter extends Adapter<CSCustomFlowState> {
  CSCustomFlowAdapter()
      : super(
          adapter: buildAdapter,
          reducer: buildReducer(),
        );
}

ListAdapter buildAdapter(
    CSCustomFlowState state, Dispatch dispatch, ViewService service) {
  final List<IndexedWidgetBuilder> builders =
      Collections.compact(<IndexedWidgetBuilder>[]);
  return ListAdapter(
    (BuildContext buildContext, int index) =>
        builders[index](buildContext, index),
    builders.length,
  );
}
