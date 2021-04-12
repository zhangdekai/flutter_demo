import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<FishReduxTestState> buildReducer() {
  return asReducer(
    <Object, Reducer<FishReduxTestState>>{// 事件注册中心，接受effect 数据，更新数据
      FishReduxTestAction.action: _onAction,
    },
  );
}

FishReduxTestState _onAction(FishReduxTestState state, Action action) {
  final FishReduxTestState newState = state.clone();
  // 数据更新
  newState.count = 2;
  return newState; // return 后View 重新build 渲染。
}
