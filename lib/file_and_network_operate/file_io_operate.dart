import 'dart:io';
import 'package:flutter/material.dart';
import 'package:weiChatDemo/common/common_button.dart';
import 'package:path_provider/path_provider.dart';

/*

获取File 采用了  3方 path_provider，文件的读写还是使用了 dart:io 的File

 */

class FileOperateTest extends StatefulWidget {
  const FileOperateTest({super.key});

  @override
  State<FileOperateTest> createState() => _FileOperateTestState();
}

class _FileOperateTestState extends State<FileOperateTest> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();

    _readCounter().then((value) => setState(() {
          _counter = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File'),
      ),
      body: Center(
        child: Column(
          children: [

            SizedBox(height: 16),
            Text('从APP Local Documents下获取File内容 数字== $_counter'),

            PushButton.button2(context, '+', _incrementCounter)],
        ),
      ),
    );
  }

  Future<File> _getLocalFile() async {
    // 获取应用目录， iOS 模拟器初次使用时，需要重新run.
    String dir = (await getApplicationDocumentsDirectory()).path;
    return File('$dir/counter.txt');
  }

  Future<int> _readCounter() async {
    try {
      File file = await _getLocalFile();
      // 读取点击次数（以字符串）
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }

  void _incrementCounter() async {
    setState(() {
      _counter++;
    });
    // 将点击次数以字符串类型写到文件中
    await (await _getLocalFile()).writeAsString('$_counter');
  }
}
