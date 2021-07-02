import 'dart:math';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'action.dart';
import 'state.dart';

Reducer<ListBottomViewState> buildReducer() {
  return asReducer(
    <Object, Reducer<ListBottomViewState>>{
      ListBottomViewAction.action: _onAction,
      ListBottomViewAction.changeGridColor: _onchangeGridColor
    },
  );
}

ListBottomViewState _onAction(ListBottomViewState state, Action action) {
  final ListBottomViewState newState = state.clone();
  return newState;
}

ListBottomViewState _onchangeGridColor(ListBottomViewState state, Action action) {
  final ListBottomViewState newState = state.clone();

  final ran = Random().nextInt(7) * 100;
  newState.gridColor = Colors.purple[ran];
  return newState;
}

