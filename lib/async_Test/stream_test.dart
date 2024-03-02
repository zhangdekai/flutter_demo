import 'dart:async';

import 'package:flutter/cupertino.dart';

class DataBloc {
  ///定义一个Controller
  StreamController<List<String>> _dataController =
      StreamController<List<String>>();

  ///获取 StreamSink 做 add 入口
  StreamSink<List<String>> get _dataSink => _dataController.sink;

  ///获取 Stream 用于监听
  Stream<List<String>> get _dataStream => _dataController.stream;

  ///事件订阅对象
  late StreamSubscription _dataSubscription;

  /// 广播
  StreamController<int> _broadcast = StreamController.broadcast();
  StreamSink<int> get _dataSink1 => _broadcast.sink;
  Stream<int> get _dataStream1 => _broadcast.stream;

  void init() {
    ///监听事件
    _dataSubscription = _dataStream.listen((value) {
      ///do change
      print('value == $value');
    });

    ///改变事件
    _dataSink.add(["first", "second", "three", "more"]);
  }

  void handleDataStream() {
    _dataStream
        .where((event) => event.length > 3)
        .map((event) => event.isNotEmpty)
        .listen((event) {
      print('object == $event');
    });
  }

  void _add() {
    // _dataSink.addStream(stream);
    _dataSink.add(['1']);
    // _dataSink.addStream(Stream.fromIterable(['1,2,3']);
  }

  void _boardCast() {}

  void close() {
    ///关闭
    _dataSubscription.cancel();
    _dataController.close();
  }
}
