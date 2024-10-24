import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () {
                _testFuture().catchError((_) {});
              },
              child: Text('error 1')),
          TextButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () {
                _testFuture2();
              },
              child: Text('error 2')),
          TextButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () {
                _testFuture3();
              },
              child: Text('error 3')),
          TextButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
              onPressed: () async {
                await _testFutureDynamic().catchError((_) {
                  print('error 4');
                  // return 1233;
                });
              },
              child: Text('error 4')),
        ],
      ),
    );
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
