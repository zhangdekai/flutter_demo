import 'package:weiChatDemo/good_libs/flutter_bloc/cubit_test/state.dart';

class BlocTestState {
  int count = 0;
  CubitTestModel? testModel;

  BlocTestState init() {
    return BlocTestState()..testModel = CubitTestModel(1, '张三');
  }

  BlocTestState clone() {
    return BlocTestState()
      ..count = count
      ..testModel = testModel;
  }
}
