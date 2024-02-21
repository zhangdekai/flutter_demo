import 'dart:async';
import 'dart:core';

import 'package:flutter/cupertino.dart';
main() {
  // test001();

  // getList1(10).forEach((element) {
  //   print(element);
  // });

  testNum();

}

void test001() {
  dump(a: 0); // {c} 02
  dump(b: 1); // {c} 12
  dump(); // {c} 53
  dump(a: 10); // {c} 10  12
  dump(b: 5); // {c} 5  10
}

// 1: 输出
class TestA {
  int? a;
  int? b;

  TestA(this.a, this.b);

  int add() {
    return (a ?? 1) + (b ?? 2);
  }
}

void dump({int? a, int? b}) {
  final TestA test = TestA(a, b);
  int? c = a;
  c ??= (test..a = b).b ?? b ?? 5;
  print('{c} ${c} ' + test.add().toString());

// c  ??=  value  // c为 空 value赋值给 c;
// 若 c 有值，则 value 不赋值给c,  value 为(test..a = b).b ?? b 的话也不执行 value;

  // _dump(a: 0);// {c} 02
  // _dump(b: 1);// {c} 12
  // _dump();    // {c} 53
  // dump(a: 10);// {c} 10  12
  // dump(b: 5); // {c} 5  10
}

///  同步生成器  Synchronous generator： Returns an Iterable object.
///  sync* and yield  搭配使用,
Iterable<int> getList(int n) sync* {
  for (int i = 0; i < n; i++) {
    yield i;
  }
}

/// 异步生成器  Asynchronous generator: Returns a Stream object
Stream<int> getList2(int n) async* {
  yield* getList1(n); // return 相应的 generator 生成器
}
Stream<int> getList1(int n) async* {
  for (int i = 0; i < n; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i; // 返回具体的值
  }
}

/// If your generator is recursive,
/// you can improve its performance by using yield*:
Iterable<int> naturalsDownFrom(int n) sync* {
  if (n > 0) {
    yield n;
    yield* naturalsDownFrom(n - 1); // 递归生成
  }
}


///
/// 3: 代码优化

class Box {
  String key;
  Box(this.key);
}

final Map<String, Box> _boxMap = {
  'key1': Box('key1'),
  'key2': Box('key2'),
  'key3': Box('key3'),
  'key4': Box('key4'),
  'key5': Box('key5'),
};

class BoxMapManager {
  static Map<String, Box> createBoxMap(List<String> keys) {
    final Map<String, Box> boxMap = {};
    for (String key in keys) {
      boxMap[key] = Box(key);
    }
    return boxMap;
  }
}

final Map<String, Box> _boxMap1 =
    BoxMapManager.createBoxMap(['key1', 'key2', 'key3', 'key4', 'key5']);

class MyContainer {
  final Map<String, Box> _boxMap = {};

  Box getBox(String key) {
    return _boxMap.putIfAbsent(key, () => Box(key));
  }
}


/// WeakReference
void weakTest() {
  // 创建一个对象
  var myObject = MyObject();

  // 创建一个对对象的弱引用
  var weakReference = WeakReference(myObject);

  // 通过弱引用获取对象
  var retrievedObject = weakReference.target;

  // 打印对象（如果对象还存在的话）
  if (retrievedObject != null) {
    print('Retrieved Object: $retrievedObject');
  } else {
    print('Object has been garbage collected.');
  }

  // 解除对对象的强引用
  // myObject = null;

  // 手动触发垃圾回收
  // 注意：垃圾回收并不是即时发生的，而是由Dart运行时系统自动管理的。
  // 但是，你可以调用`gc()`函数来主动触发垃圾回收。

  // gc();


  // 再次通过弱引用获取对象
  retrievedObject = weakReference.target;

  // 打印对象（如果对象还存在的话）
  if (retrievedObject != null) {
    print('Retrieved Object: $retrievedObject');
  } else {
    print('Object has been garbage collected.');
  }

}

class MyObject {
  // 你的对象的定义
}

// Zone 的概念
void testZone() {
  // 创建一个自定义Zone
  Zone myZone = Zone.current.fork(
    specification: ZoneSpecification(
      handleUncaughtError: (Zone self,
          ZoneDelegate parent, Zone zone, Object error, StackTrace stackTrace) {
        // 异常处理逻辑
        print('Uncaught error: $error');
      },
    ),
  );

  // 在自定义Zone中运行异步任务
  myZone.run(() {
    // 异步任务
    Future<void>.delayed(Duration(seconds: 2), () {
      // 抛出一个异常
      throw Exception('An error occurred in the async task');
    });
  });

  print('Main function completed');
}

///给你一个数组 nums，其中nums 的整数都在[1,n]之间，
///且每个整数出现1次或2次，请找出所有出现2次的整数，并以数组的形式返回。
///设计一个时间复杂度为 O(n),切仅使用常量额外空间的算法解决此问题。
// 实例：nums = [4,3,2,7,8,2,3,1]   => [2,3]
///
///

void testNum(){
  List<int> nums = [99,4, 3, 2, 7, 8, 2, 3, 1,1,8];
  List<int> result = findDuplicates(nums);
  print(result);
}

List<int> findDuplicates(List<int> nums) {
  List<int> result = [];

  for (int i = 0; i < nums.length; i++) {
    int index = (nums[i].abs() % nums.length) - 1;
    print(' i == $i ,index == $index');

    if (nums[index] < 0) {
      result.add(index + 1);
    } else {
      nums[index] = -nums[index];
    }
  }

  return result;
}