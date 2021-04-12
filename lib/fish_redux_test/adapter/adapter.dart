import 'package:fish_redux/fish_redux.dart';
import 'package:weichatdemo/fish_redux_test/component/component.dart';

import 'reducer.dart';
import 'state.dart';

class listview_adapterAdapter extends SourceFlowAdapter<listview_adapterState> {
  listview_adapterAdapter()
      : super(
          pool: <String, Component<Object>>{//注册需要用到的 自定义 component。
            "header": list_cellComponent(),
          },
          reducer: buildReducer(),
          );
}
