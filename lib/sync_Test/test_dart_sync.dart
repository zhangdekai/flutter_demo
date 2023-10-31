import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


void func01(SendPort port) {//有点问题????
  print('第一个来了!!');
  port.send(10000);
}

int a = 10;

//Isolate 看起来更加像进程.因为有独立的内存空间!
//它的好处是:不用担心多线程的资源抢夺问题!不需要锁!
//Isolate 非常底层.


void test0001() async {

  ReceivePort port = ReceivePort();

  Isolate iso = await Isolate.spawn(func1, port.sendPort);

  port.listen((message) {
    a = message;
    print(a);

    // 需要关闭 close  和  kill
    port.close();
    iso.kill();
  });

  print('回来之后的A是$a');
  print('外部代码2');

}


class TestDartSync extends StatelessWidget {
  String _data = '0';


  @override
  Widget build(BuildContext context) {

    dioDemo();
//    futureDemo();
//    isolateDemo();
//    computeTest();
//    test0001();
//    textFuture3();
//    textFuture2();
//    textFuture1();
//    textFuture();
//    getData();

    return Scaffold(
      appBar: AppBar(
        title: Text('测试Dart 异步编程'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: Text('测试Dart 异步编程'),
      ),
    );
  }

  void textFuture() {

    Future((){
      sleep(Duration(seconds: 1));
      return '任务1';
    })
        .then((value){
      print('${value}结束');
      throw Exception('异常');
    })
        .then((value) {
      print('$value结束');
      return '任务3';
    })
        .then((value) => print('$value结束'))
        .catchError((e) => print(e));

    print('任务添加完毕');
  }

  void getData() async {

    print('开始data=$_data');

    //1.后面的操作必须是异步才能用await
    //2.当前函数必须是异步函数
    Future future = Future(() {
      //耗时操作
      for (int i = 0; i < 1000000000; i++) {}
//    throw Exception('网络异常');
    });


    //处理错误
    future.then((value) {
      print('then  来了!!');
      print(value);
    }).catchError((e) {
      print('捕获到了:' + e.toString());
    }).whenComplete(() {
      print('完成了!');
    });

    //使用then来接收数据
//  future.then((value) {
//    print('then  来了!!');
//    print(value);
//  }, onError: (e) {
//    print(e.toString());
//  });

    print('干点其他的事情!');
  }

  //任务组，数组， 任务1 任务2都完成以后 then 操作
  void textFuture1() {

    Future future = Future.wait([
      Future((){
        return '任务1';
      }),
      Future((){
        return '任务2';
      })
    ]).then((value){
      print(value[0] + value[1]);
    });

    Future.value();

  }

  void textFuture2() {

    print('外部代码1');

    Future(() => print('A')).then((value) => print('A结束'));
    Future(() => print('B')).then((value) => print('B结束'));

    //微任务 优先级更高些，加入队列的 任务事件 和 微任务 ，优先处理微任务
    scheduleMicrotask((){
      print('微任务A');
    });

    sleep(Duration(seconds: 1));

    print('外部代码2');

    scheduleMicrotask((){

    });

  }

  // 任务、微任务 优先级
  void textFuture3() {

    Future x1 = Future(() => null);

    x1.then((value) {
      print('6');
      scheduleMicrotask(() => print('7'));
    }).then((value) => print('8'));

    Future x = Future(()=> print('1'));

    x.then((value)  {
      print('4');
      Future(() => print('9'));
    }).then((value) => print('10'));

    Future(() => print('2'));

    scheduleMicrotask(() => print('3'));

    print('5');

    // 5 3 6 8 7 1 4 10 2 9

  }

}

void computeTest() {

  print('外部代码1');


  compute(func2, 1000).then((value) => print(value));

  print('外部代码2');

//  flutter: 外部代码1
//  flutter: 外部代码2
//  Reloaded 6 of 576 libraries in 303ms.
//  flutter: 2345

}

int func2(int message) {
  sleep(Duration(seconds: 1));
  return 2345;
}

void func1(SendPort message) {
  print('第一个来了!!');

  message.send(228738);
}

void isolateDemo(){

//  // 打印顺序不一
//  Future(()=> compute(func3,123)).then((value) => print('1结束'));
//  Future(()=> compute(func3,123)).then((value) => print('2结束'));
//  Future(()=> compute(func3,123)).then((value) => print('3结束'));
//  Future(()=> compute(func3,123)).then((value) => print('4结束'));
//  Future(()=> compute(func3,123)).then((value) => print('5结束'));


    loadData().then((value) => print('1结束'));
    loadData().then((value) => print('2结束'));
    loadData().then((value) => print('3结束'));
    loadData().then((value) => print('4结束'));
    loadData().then((value) => print('5结束'));
    //非顺序打印
}

Future loadData(){

//  return Future((){
//     compute(func3,234);// 此种方式 顺序打印
//  });

  return Future((){
    print(Isolate.current.debugName);
    //如果你返回的是compute的Future,那么这个任务在子Isolate的事件队列中!
    return compute(func3,234);// 此种方式 不顺序打印  return
  });
}

int func3(int message) {
  return 333;
}

void futureDemo() {

  Future x = Future((){
    print('A异步任务1');
    scheduleMicrotask(() => print('B微任务1'));
  });
  // 关于then 他在Future任务执行完毕后，立刻执行，可以看做一个任务执行！
  x.then((value) => print('C异步1结束'));
  print('D主任务');
  // D A C B


  Future y = Future((){
    print('F异步任务1');
  });

  // 等待 x,y 执行完毕才执行
  Future.wait([x,y]).then((value) {
    print(value);
  });

//  Future.delayed(Duration(seconds: 2));

//  Future.doWhile(() => null)

}

void dioDemo(){

  final dio = Dio();

  var downloadUrl = 'http://pub.idqqimg.com/pc/misc/groupgift/fudao/CourseTeacher_1.3.16.80_DailyBuild.dmg';;

  String savepath = '/Users/zhangdekai/Desktop/123/腾讯课堂.dmg';

  String savePath2 = Directory.systemTemp.path + '/腾讯课堂.dmg';
  
  print(savePath2);

//  下载
//  download1(dio, downloadUrl, savePath2);

}

void download1(Dio dio, String downloadUrl, String savepath) {
  dio.download(downloadUrl, savepath,onReceiveProgress: showDownloadProgress)
      .then((value) => print(value))
      .whenComplete(() => print('下载结束'));
}

void showDownloadProgress(int count, int total) {
  if(total != -1){
    print((count / total * 100).toStringAsFixed(0) + '%');
  }
}
