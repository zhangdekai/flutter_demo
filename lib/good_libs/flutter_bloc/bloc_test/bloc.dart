import 'dart:ui';

import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

class BlocTestBloc extends Bloc<BlocTestEvent, BlocTestState> {
  BlocTestBloc() : super(BlocTestState().init()) {
    /// 注册Event
    on<InitEvent>(_init);
    on<IncreaseEvent>(_increment);
    on<ChangeNameEvent>(_changeName);
  }

  void _init(InitEvent event, Emitter<BlocTestState> emit) async {
    emit(state.clone()..testModel?.name = '张三');
  }

  void _increment(IncreaseEvent event, Emitter<BlocTestState> emit) {
    print('increment state count ${state.count}');

    emit(state.clone()..count += 10);
  }

  void _changeName(ChangeNameEvent event, Emitter<BlocTestState> emit) {
    emit(state.clone()..testModel?.name += '${event.name} ');
  }

  @override
  Future<void> close() {
    print('Bloc close');

    return super.close();
  }
}
