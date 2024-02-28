_testAsyncKeyword() {
  print("test函数开始了：${DateTime.now()}");
  _testString().then((value) => print(value));
  print("test函数结束了：${DateTime.now()}");
}

Future<String> _testString() async {
  Future f = Future.delayed(Duration(milliseconds: 1000), () {
    return "我是测试字符串===1";
  });
  print("我是测试字符串===0");
  String result = await f;
  print("我是测试字符串===2");
  return result;
}

_testAsyncKeyword1() async {
  print("test函数开始了：${DateTime.now()}");
  print(await _testString());
  print("test函数结束了：${DateTime.now()}");
  // flutter: test函数开始了：2021-05-27 14:06:48.185704
// flutter: 我是测试字符串===2
// flutter: 我是测试字符串===1
// flutter: test函数结束了：2021-05-27 14:06:48.497481
}

void main() {
  // _testAsyncKeyword();
  _testAsyncKeyword1();
}
