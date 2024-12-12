## [Futures and error handling](https://dart.dev/libraries/async/futures-error-handling#potential-problem-failing-to-register-error-handlers-early)

ps: Jay 推荐的很详细的Future error 处理，里边有正确的Future error 写法，可以参考。
以下是我在修改项目问题时的一些发现和简单总结，归纳了 Future error的 bad case 和 正确使用方法。

### 一、问题的描述

1. 问题的表现是怎样的？


- FlutterError - Invalid argument(s) (onError): The error handler of Future.catchError must return a
  value of the future's type

- Future._completeError
    - Invalid argument(s) (onError): The error handler of Future.then must return a value of the
      returned future's type）

3. 问题的复现Case

- 业务操作很难触发Future 的error。通过代码模拟 error，可触发复现 2种问题.
  case1:   .catchError()
- 引发 FlutterError - Invalid argument(s) (onError): The error handler of Future.catchError must
  return a value of the future's type 的 Case

```
 // error Future, 有返回值的
  Future<int> _testFuture() async {
  await Future.error(Exception('测试 Future.error(Exception)'));
  return 12;
  }
```

** _testFuture() 是一个有具体类型返回的Future，直接.catchError(),需要return 相应的类型的值.

```
_testFuture().catchError((e) {
debugPrint('_testFuture()  ==== ${e.toString()}');
return 10; // good。需要return 相应的类型的值.
// no return // bad
});

_testFuture().then((value) => 12).catchError((e) {
debugPrint('_testFuture()  ==== ${e.toString()}');
return -1; // good .then 的箭头函数，返回一个int 值，catchError 必须也要返回 一个int值。
// return '10'; // bad
// return null; // bad
});
```

** catchError(): 会捕获它前边Future的error，Future有返回值，catchError()也需 return 相应的
(.then() 也是一个Future)

```
Future<void> _testFuture1() async {
await Future.error(Exception('测试 void Future.error(Exception)'));
}
```

** _testFuture1() 返回void，catchError 不需要返回值。

```
_testFuture1().catchError((e) { // good
debugPrint('_testFuture()  ==== ${e.toString()}');
});
```

Case 2:

- Invalid argument(s) (onError): The error handler of Future.then must return a value of the
  returned future's type）

```
Future<R> then<R>(FutureOr<R> onValue(T value), {Function? onError}); 中的 onError

** then((value) => 12) 是返回int 值， onError 中必须返回相应值
Future.error(Exception('测试1 - Future.error')).then((value) => 12, onError: (e) {
// return 10; // good
// return null; // bad
// no return // bad
});
```

二、总结

- 归纳起来，便是无论是 catchError() 还是 onError, 其作用的Future 有返回值的，error也需要返回相应类型的值，
  以往对于Future error 的处理有遗漏。
- 测试中发现error处理 优先级，onError >  catchError()  >  try catch. 以后使用需注意，使用了 onError,
  再加 catchError() 是不起作用的，catchError() 外边套上 try catch 也不起作用。
  Future error的正确处理方式
  1:  使用 onError ， catchError() ，具体的使用方法可参考 上边 问题的复现case
  2:  使用try catch 嵌套 Future, 在 catch(e) 中 处理error。注意，try catch 必须搭配 await 使用，否则
  catch 不到error， 而且 其处理方式和 onError ， catchError() 一样，需要返回值的，必须返回相应类型的值.

```
Future<int> _testFuture143() async {
try{
await Future.error(Exception('测试 void Future.error(Exception)'));
return 1222;
} catch (e){
print('_testFuture143 e = $e');
return 122; // good
// no return // bad
}
}
```

3:   返回值 是 Future， Future<void>, Future<dynamic> 的 error 处理时，可以不 return。

```
Future<dynamic> _testFuture143() async {
try{
await Future.error(Exception('测试 void Future.error(Exception)'));
return 1222;
} catch (e){
print('_testFuture143 e = $e');
// return 122; // good
// return null; // good
// return '123'; // no problem
But 最好 return null 或 return try中return的类型值。
}
}

Future<void> _testFuture143() async { // good
try{
await Future.error(Exception('测试 void Future.error(Exception)'));
} catch (e){
print('_testFuture143 e = $e');
}
}
```

不建议写成这样，最好有具体的返回值，无值就用 void 不加return。

```
Future _testFuture143() async {
try{
await Future.error(Exception('测试 void Future.error(Exception)'));
// return 123; // not good  
} catch (e){
print('_testFuture143 e = $e');
// return '123'; // not good
}
}
```

4:  更加复杂的Future 链式写法，对 error的处理原理与上边所讲一样，onError 和 catch Error 会作用在其Future
上，有返回值的 error 也需要返回值。更详细的case
可参考 [Futures and error handling](https://dart.dev/libraries/async/futures-error-handling#potential-problem-failing-to-register-error-handlers-early)。













