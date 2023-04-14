import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Reducer<FishReduxTestState> buildReducer() {
  return asReducer(
    <Object, Reducer<FishReduxTestState>>{// 事件注册中心，接受effect 数据，更新数据
      FishReduxTestAction.action: _onAction,
      FishReduxTestAction.initDataList: _onInitDataList,
      FishReduxTestAction.initBottomData: _onInitBottomData
    },
  );
}

FishReduxTestState _onAction(FishReduxTestState state, Action action) {
  final FishReduxTestState newState = state.clone();
  // 数据更新
  newState.name = 'reducer fixed';
  return newState; // return 后View 重新build 渲染。
}

FishReduxTestState _onInitDataList(FishReduxTestState state, Action action) {
  final FishReduxTestState newState = state.clone();
  // 数据更新
  // newState.name = 'reducer fixed';
  newState.dataList = action.payload;

  return newState; // return 后View 重新build 渲染。
}
FishReduxTestState _onInitBottomData(FishReduxTestState state, Action action) {
  final FishReduxTestState newState = state.clone();
  // 数据更新
  // newState.bottomModel = action.payload;
  newState.bottomViewState = action.payload;
  return newState; // return 后View 重新build 渲染。
}


