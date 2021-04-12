import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';

import 'reducer.dart';
import 'state.dart';

class CustomerAdapterAdapter extends Adapter<CustomerAdapterState> {
  CustomerAdapterAdapter()
      : super(
          adapter: buildAdapter,
          reducer: buildReducer(),
        );
}

ListAdapter buildAdapter(
    CustomerAdapterState state, Dispatch dispatch, ViewService service) {
  final List<IndexedWidgetBuilder> builders =
      Collections.compact(<IndexedWidgetBuilder>[]);
  return ListAdapter(
    (BuildContext buildContext, int index) =>
        builders[index](buildContext, index),
    builders.length,
  );
}
