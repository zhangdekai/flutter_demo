import 'package:bloc/bloc.dart';

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

  @override
  Future<void> close() {
    print('Bloc Cubit close');

    return super.close();
  }
}
