class CubitTestState {
  int count = 0;
  CubitTestModel? testModel;

  CubitTestState init() {
    return CubitTestState()
      ..count = 0
      ..testModel = CubitTestModel(1, '张三');
  }

  CubitTestState clone() {
    return CubitTestState()
      ..count = count
      ..testModel = testModel;
  }
}

class CubitTestModel {
  int? age;
  String name;

  CubitTestModel(this.age, this.name);
}
