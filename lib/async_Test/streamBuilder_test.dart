import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';

///  StreamBuilder 应用

class StreamTest extends StatefulWidget {
  @override
  _StreamTestState createState() => _StreamTestState();
}

class _StreamTestState extends State<StreamTest> {
  StreamController<int> _streamController = StreamController(
      onListen: () {}, onPause: () {}, onCancel: () {}, onResume: () {});

  late Stream _stream;
  late Stream _eventBus;
  late StreamSink _sink;
  int _count = 0;

  @override
  void initState() {
    super.initState();

    ///流事件
    _stream = _streamController.stream;

    ///事件入口
    _sink = _streamController.sink;
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
    _sink.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stream")),
      body: Center(
        child: Column(
          children: [
            Text('You have pushed the button this many times:'),
            StreamBuilder(
              stream: _stream,
              initialData: _count,
              builder: (context, AsyncSnapshot snapshot) {
                ///snapshot携带事件入口处闯进来的数据，用snapshot.data获取数据进行处理
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text(
                    'Done - snapshot.connectionState == ConnectionState.done 了',
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  );
                }
                int number = snapshot.data;
                return Text(
                  "StreamBuilder - $number",
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            child: Icon(Icons.add),
            tooltip: "Increment",
            onPressed: () => _incrementCounter(),
          ),
          SizedBox(width: 20),
        ],
      ),
    );
  }

  /// 它使用 Stream 的 listen() 方法来订阅文件列表，传入一个搜索文件或目录的函数
  Future<void> fetchFile() async {
    String searchPath = '';
    FileSystemEntity.isDirectory('path').then((value) {
      if (value) {
        final startingDir = Directory(searchPath);
        startingDir.list().listen((entity) {
          // if (entity is File) {
          //   searchFile(entity, searchTerms);
          // }
        });
      }
    });

    // same to upper
    if (await FileSystemEntity.isDirectory(searchPath)) {
      final startingDir = Directory(searchPath);

      /// api:
      Future future1 = startingDir.list().first;
      Future future2 = startingDir.list().last;
      Future single = startingDir.list().single;

      Future firstWhere = startingDir.list().firstWhere(
            (element) => element.isAbsolute,
            // orElse: () => null
          );

      startingDir
          .list()
          .transform(
              utf8.decoder as StreamTransformer<FileSystemEntity, dynamic>)
          .transform(LineSplitter());

      await for (final e in startingDir.list()) {
        if (e.path == './//x') {
          // searchFile(entity, searchTerms);
        }
      }
    } else {
      // searchFile(File(searchPath), searchTerms);
    }
  }

  void _incrementCounter() {
    if (_count > 3) {
      _sink.close();
      return;
    }
    _count++;
    _sink.add(_count);
  }
}
