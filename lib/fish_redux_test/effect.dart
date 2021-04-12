import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' show Navigator;
import 'action.dart';
import 'state.dart';


Effect<FishReduxTestState> buildEffect() {
  return combineEffects(<Object, Effect<FishReduxTestState>>{
    Lifecycle.initState: _initState,// 注册事件响应中心，和 生命周期事件
    FishReduxTestAction.action: _onAction,
    FishReduxTestAction.tapAction: _tapAction,

  });
}

void _initState(Action action, Context<FishReduxTestState> ctx) {

  // 初始化操作
  // 网络请求，数据处理
  // 监听处理

  ctx.context;

  ctx.state; //获取数据

  ctx.dispatch(action);// 分发事件，一般传到reduce 更新数据，刷新View
}

// 自定义事件处理
void _tapAction(Action action, Context<FishReduxTestState> ctx) {

  Navigator.of(ctx.context).pushNamed('routeName', arguments: {"name": '吕小布'});

}

void _onAction(Action action, Context<FishReduxTestState> ctx) {

}

