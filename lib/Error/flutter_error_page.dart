import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FlutterErrorPage extends StatefulWidget {
  const FlutterErrorPage({super.key});

  @override
  State<FlutterErrorPage> createState() => _CardSwiperPageState();
}

class _CardSwiperPageState extends State<FlutterErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ERROR TEST'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
                style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue[100])),
                onPressed: () {
                  _testFuture().catchError((_) {});
                },
                child: Text('catchError - not return value')),
            TextButton(
                style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue[100])),
                onPressed: () {
                  _testFuture2();
                },
                child: Text('try - catch Future<dynamic>')),
            TextButton(
                style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue[100])),
                onPressed: () {
                  _testFuture3();
                },
                child: Text('then(return value) -> catchError  ')),
            TextButton(
                style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue[100])),
                onPressed: () async {
                  await _testFutureDynamic().catchError((e) {
                    print('Future<dynamic>  catchError e == $e');
                    // return 1233;
                  });
                },
                child: Text('Future<dynamic>  catchError')),
            TextButton(
                style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue[100])),
                onPressed: () async {
                  String jsonString = '.{"name": "Alice", "age": 30}';
                  try {
                    Map<String, dynamic> parsedJson = jsonDecode(jsonString);
                    print('JSON is valid: $parsedJson');
                  } catch (e) {
                    print('JSON is invalid: $e');
                  }
                },
                child: Text('jsonDecode error')),
            TextButton(
                style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue[100])),
                onPressed: () async {
                  try {
                    final aa = NumberFormat.decimalPattern('ars_SA').format(123232234);
                    // final aa = NumberFormat.decimalPattern('ar_SA').format(123.34343); // good
                    print('aa === $aa');
                  } catch (e) {
                    print('NumberFormat.decimalPattern e === ${e.toString()}');
                  }
                  print(decimalPattern(123232234));
                },
                child: Text('NumberFormat.decimalPattern error')),
          ],
        ),
      ),
    );
  }

  String decimalPattern(int num) {
    String text = '$num';
    try {
      text = NumberFormat.decimalPattern().format(num);
    } catch (e) {
      print('decimalPattern e = ${e.toString()}');
    }
    return text;
  }

  Future<int> _testFuture() async {
    print('_testFuture  1111');
    await Future.delayed(Duration(seconds: 1));
    await Future.error(Exception('测试 Future.error(Exception)'));
    return 12;
  }

  Future<dynamic> _testFutureDynamic() async {
    print('_testFuture  1111');
    await Future.delayed(Duration(seconds: 1));
    await Future.error(Exception('测试 Future.error(Exception)'));
    return 12;
  }

  Future<dynamic> _testFuture2() async {
    print('_testFuture2  1111');
    try {
      await Future.delayed(Duration(seconds: 1));
      await Future.error(Exception('测试 Future.error(Exception)'));
      return 12;
    } catch (e) {
      print('_testFuture2  1111 e == $e');
    }
  }

  Future<dynamic> _test2() async {
    /// Invalid argument(s) (onError): The error handler of Future.then must return a value of the returned future's type
    ///
    // bad
    _testOnError1();

    // bad
    // Future.error(Exception('测试5 - Future.error')).then((value) => dynamic,onError: (e){
    //   // return dynamic; // good
    //   // no return // bad
    // });

    // _goodCase();
  }

  Future<void> _goodCase() async {
    try {
      // good
      await Future.error(Exception('测试3 - Future.error')).then((value) => 12);

      // good
      var value = await Future.delayed(Duration(seconds: 1)).then((value) => 12);
      print('value == $value');
    } catch (e) {
      print('_testFuture1 e == $e');
    }
  }

  void test3() {
    // bad
    Future.error(Exception('测试4 - Future.error')).then((value) => 'UserInfo()');
  }

  void _testOnError1() {
    /// Invalid argument(s) (onError): The error handler of Future.then must return a value of the returned future's type
    // bad
    // Future.error(Exception('测试0 - Future.error')).then((value) => UserInfo(), onError: (e) {
    //   // return UserInfo(); // good
    //   // return null; // bad
    //   // no return  // bad
    // });
    //
    // Future.error(Exception('测试1 - Future.error')).then((value) => 12, onError: (e) {
    //   // return -1; // good
    //   // return null; // bad
    //   // no return  // bad
    // });

    // not bad,
    print('object11111');
    Future.error(Exception('测试2 - Future.error')).then((value) => testVoid(), onError: (e) {
      print('object3333');
    }).catchError((e) {
      print('object2222');

      // return null;
    });
  }

  testVoid() {
    print('12122');
  }

  Future<void> _testFuture3() async {
    testFutureString().then((value) {
      print('value === $value');
    }).catchError((e) {
      print(e);
    });
  }

  Future<String?> testFutureString() {
    return Future.delayed(Duration(seconds: 1)).then((value) => Future.error(Exception('测试7--')));
  }

  void _test() {
    test1();

    // _test2();

    // _testFuture2();

    // test3();
  }

  void test1() {
    _testFuture().then((value) => 10);

// then((value) => 10).then((value) => Future.error(Exception('')))
//     _testFuture().then((value) => 10).catchError((e){
//       print('catchError 222 e=== $e');
//
//       return 12;
//     }).then((value) {
//       print('value ==== $value');
//       return '1222';
//     }).catchError((e) {
//
//       print('catchError 111 e=== $e');
//       return 12;
//     });

    /// Invalid argument(s) (onError): The error handler of Future.catchError must return a value of the future's type
    // bad
    // _testFuture().catchError((e) {
    //   debugPrint(e.toString());
    //   // return null;
    //   // return 10;
    // });
    //
    // // good
    // _testFuture().then((value) {
    //   print('value == $value');
    // }).catchError((e) {
    //   print('e == $e');
    //   // return 10;
    // });
    //
    // // bad
    // _testFuture().then((value) {
    //   return 10;
    // }).catchError((e) {
    //   print('e == $e');
    // });
    //
    //
    //
    // // bad
    // Future.error(Exception('测试2 - Future.error')).then((value) => UserInfo()).catchError((e) {
    //   print('2222 catchError e == $e');
    //   // return UserInfo(); // good
    //   // no return // bad
    // });
  }
}
