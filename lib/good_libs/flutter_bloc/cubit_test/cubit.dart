import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'state.dart';

class CubitTestCubit extends Cubit<CubitTestState> {
  CubitTestCubit() : super(CubitTestState().init());

  void increment() {
    print('increment state count ${state.count}');
    emit(state.clone()..count += 10);
  }

  void changeName() {
    emit(state.clone()..testModel?.name += '五 ');
  }

  void changeColor() {
    emit(state.clone()
      ..backColor = Colors.green
      ..colorChanged = true);
  }

  @override
  Future<void> close() {
    print('Bloc Cubit close');

    return super.close();
  }
}

/// Custom Cubit
class GlobalBloc extends Cubit<GlobalBlocState> {
  GlobalBloc() : super(GlobalBlocState());
}

class GlobalBlocState {
  int count = 0;

  GlobalBlocState clone() {
    return GlobalBlocState()..count = count;
  }
}

class GlobalBlocA extends Cubit<GlobalBlocAState> {
  GlobalBlocA() : super(GlobalBlocAState().init());
}

class GlobalBlocAState {
  int count = 0;
  String name = '';

  GlobalBlocAState init() {
    return clone()
      ..name = '张三+7656'
      ..count = 9527;
  }

  GlobalBlocAState clone() {
    return GlobalBlocAState()
      ..count = count
      ..name = name;
  }
}
