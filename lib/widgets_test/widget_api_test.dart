import 'dart:async';
import 'dart:math';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/*
以下包含：
1：Stream StreamBuild
2：FutureBuilder
3：LayoutBuilder
4：Flexible
5：GridView


 */

class WidgetsApiTest extends StatefulWidget {
  final int testType;

  const WidgetsApiTest({super.key, required this.testType});

  @override
  _WidgetsApiTestState createState() => _WidgetsApiTestState();
}

class _WidgetsApiTestState extends State<WidgetsApiTest> with AfterLayoutMixin{

  /// 只能被一个监听, 会缓存 sink add 过的事件
  // StreamController _controller = StreamController();

  /// 可被多方监听   不会缓存
  StreamController _controller = StreamController.broadcast();

  Stream<int> getNumber() async* {
    await Future.delayed(Duration(seconds: 2));
    yield 1; // 返回 1
  }

  @override
  void initState() {
    super.initState();
    _nextFrameAction();
  }

  void _nextFrameAction() {
     WidgetsBinding.instance.endOfFrame.then((value) {
      if(mounted){

      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

    });
  }


  @override
  void dispose() {
    super.dispose();
    // 不加这行，_controller 报警告。
    _controller.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget api test'),
        backgroundColor: Colors.cyan,
      ),
      body: Container(
        color: Colors.green[200]?.withOpacity(0.8),
        child: contentWidget(),
      ),
    );
  }

  Widget contentWidget() {
    switch (widget.testType) {
      case 0:
        return _gridViewTest();
      case 1:
        return _streamBuilderTest();
      case 2:
        return _flexibleTest();
      case 3:
        return _layoutBuilderTest();
      case 4:
        return _futureBuilderTest();
      case 5:
        return _futureBuilderTest();
    }
    return _gridViewTest();
  }

  /// 键盘输入 Stream 检测
  Widget _gridViewTest() {
    return Stack(
      children: [
        PuzzleView(inputStream: _controller.stream),
        Center(
          child: DefaultTextStyle(
            style: TextStyle(fontSize: 30, color: Colors.yellow),
            child: StreamBuilder<dynamic>(
                stream: _controller.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text('Your enter is ${snapshot.data}');
                  }
                  return Text('waiting...');
                }),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.red[300],
            child: GridView.count(
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              crossAxisCount: 3,
              childAspectRatio: 2 / 1,
              children: List.generate(9, (index) {
                return TextButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            BeveledRectangleBorder()), //BeveledRectangleBorder, CircleBorder
                        backgroundColor: MaterialStateProperty.all(
                            Colors.primaries[index][200])),
                    onPressed: () {
                      // _controller.sink.add(index + 1);
                      _controller.add(index + 1);
                    },
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(fontSize: 25, color: Colors.black),
                    ));
              }),
            ),
          ),
        )
      ],
    );
  }

  Widget _streamBuilderTest() {
    return Center(
      child: DefaultTextStyle(
        style: TextStyle(fontSize: 25, color: Colors.yellow),
        child: Column(children: [
          TextButton(
              onPressed: () {
                _controller.sink.add(10);
              },
              child: Text('10')),
          TextButton(
              onPressed: () {
                _controller.sink.add(20);
              },
              child: Text('20')),
          TextButton(
              onPressed: () {
                _controller.sink.addError('oops');
              },
              child: Text('oops')),
          MaterialButton(
            onPressed: () {
              _controller.sink.add('MaterialButton');
            },
            child: Text('MaterialButton'),
          ),
          StreamBuilder(
              // initialData: 100,
              stream: _controller.stream
                  .map((event) => event * 2)
                  .where((event) => event > 10)
                  .distinct(), //_stream   .map((event) => event * 2)
              //distinct 去重
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print('building....');
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Text('ConnectionState.none');
                  case ConnectionState.waiting:
                    // TODO: Handle this case.
                    return Text('ConnectionState.waiting');
                  case ConnectionState.active:
                    // TODO: Handle this case.

                    if (snapshot.hasError) {
                      return Icon(
                        Icons.error,
                        size: 50,
                      );
                    }
                    if (snapshot.hasData) {
                      return Text(
                          'ConnectionState.active date = ${snapshot.data}');
                    }
                    return Text('ConnectionState.active');
                  case ConnectionState.done:
                    // TODO: Handle this case.
                    break;
                }
                return Container();
              }),
        ]),
      ),
    );
  }

  Widget _futureBuilderTest() {
    return Center(
      child: DefaultTextStyle(
        style: TextStyle(fontSize: 20, color: Colors.red),
        child: FutureBuilder(
            // initialData: 32,
            future: Future.delayed(
                Duration(seconds: 2), () => 200), //100  throw('error 1')
            builder: (con, snp) {
              if (snp.hasError) {
                return Icon(Icons.error, size: 50);
              }

              if (snp.connectionState == ConnectionState.done) {
                print('ConnectionState.done');
              }

              if (snp.hasData) {
                return Text(
                  'data = ${snp.data}',
                  style: TextStyle(fontSize: 30),
                );
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }

  Widget _layoutBuilderTest() {
    Widget widget = Container(
      color: Colors.cyan[200],
      child: FractionallySizedBox(
        // widthFactor: 0.2,
        // heightFactor: 0.2,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            print('LayoutBuilder constraints = $constraints');

            if(constraints.minWidth >= 100.0){
              return FlutterLogo(size: 200);
            }

            return FlutterLogo(size: 20);
          },
        ),
      ),
    );

    widget = Container(
      color: Colors.green[100],
      child: Padding(
        padding: EdgeInsets.all(20),
        child: ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: 100, minHeight: 100, maxWidth: 150, maxHeight: 148),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              print('LayoutBuilder constraints = $constraints');
              if(constraints.minWidth >= 100.0){
                return FlutterLogo(size: 200,textColor: Colors.red,);
              }

              return FlutterLogo(size: 50);            },
          ),
        ),
      ),
    );

    return Center(child: widget);
  }

  Widget _flexibleTest() {
    return Column(
      children: [
        Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: GestureDetector(
              child: Container(
                height: 50,
                color: Colors.red,
              ),
              onTap: () {
                AppUtils.showDialogs(
                    context,
                    BaseDialog(
                      title: '撒大声地',
                      content: '是非法的',
                    ));
              },
            )),
        Flexible(flex: 2, child: Container(color: Colors.green)),
        Flexible(
            flex: 3,
            child: Container(
              color: Colors.yellow,
            )),
      ],
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    print('afterFirstLayout');
  }
}

class PuzzleView extends StatefulWidget {
  final inputStream;

  const PuzzleView({Key? key, this.inputStream}) : super(key: key);

  @override
  _PuzzleViewState createState() => _PuzzleViewState();
}

class _PuzzleViewState extends State<PuzzleView>
    with SingleTickerProviderStateMixin {
  int a = 0;
  int b = 0;
  double x = 0;
  late AnimationController _controller;

  void reset() {
    a = Random().nextInt(5) + 1;
    b = Random().nextInt(5);
    x = Random().nextInt(350).toDouble();
  }

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5))
          ..forward();

    reset();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        reset();
        _controller.forward(from: 0.0);
      }
    });

    widget.inputStream.listen((event) {
      if (event == a + b) {
        reset();
        _controller.forward(from: 0.0);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Positioned(
            left: x,
            top: 400 * _controller.value - 100,
            child: Container(
              child: TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                      backgroundColor:
                          MaterialStateProperty.all(Colors.pink[300])),
                  onPressed: () {},
                  child: Text(
                    '$a + $b',
                    style: TextStyle(fontSize: 20),
                  )),
            ));
      },
    );
  }
}

class BaseDialog extends StatefulWidget {
  final String title;
  final String content;
  final bool cancelAble;
  final Function? confirmCallback; // 点击确定按钮回调
  final Function? cancelCallback; // 点击取消按钮
  final Function? dismissCallback; // 弹窗关闭回调

  BaseDialog(
      {this.title = "",
      this.content = "",
      this.cancelAble = true,
      this.confirmCallback,
      this.cancelCallback,
      this.dismissCallback});

  @override
  _BaseDialogState createState() => _BaseDialogState();
}

class AppUtils {
  /// 展示dialog
  static void showDialogs(BuildContext context, Widget dialog) {
// 导航到新路由 背景颜色为透明色
/*
  Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, animation, secondaryAnimation) {
        return dialog;
      }));
*/
    showDialog(context: context, builder: (_) => dialog);
  }
}

class _BaseDialogState extends State<BaseDialog> {
  @override
  Widget build(BuildContext context) {
    // 设置弹框的宽度为屏幕宽度的86%
    var _dialogWidth = MediaQuery.of(context).size.width * 0.86;

    // 构建弹框内容
    Container _dialogContent = Container(
      decoration: ShapeDecoration(
        color: Color(0xffffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
        ),
      ),
      child: Column(
        // 主轴对齐方向
        mainAxisAlignment: MainAxisAlignment.center,
        // 另一个轴对齐方向
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 标题
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
            child: Text(
              widget.title == "" ? "标题" : widget.title,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w300),
            ),
          ),
          // 内容
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 12, 0, 0),
            child: Text(
              widget.content == "" ? "内容" : widget.content,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          // 按钮
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: _clickCancel,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(146, 26, 0, 0),
                  child: Text(
                    "取消",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: _clickConfirm,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(52, 26, 0, 0),
                  child: Text(
                    "确定",
                    style: TextStyle(
                      color: Color.fromRGBO(233, 87, 14, 1),
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );

    // 构建弹框布局
    return WillPopScope(
        child: GestureDetector(
          onTap: () => {widget.cancelAble ? _dismissDialog() : null},
          child: Material(
            type: MaterialType.transparency,
            child: Center(
              //保证控件居中效果
              child: SizedBox(
                // 设置弹框宽度
                width: _dialogWidth,
                height: 186.0,
                child: _dialogContent,
              ),
            ),
          ),
        ),
        onWillPop: () async {
          return widget.cancelAble;
        });
  }

  /// 点击隐藏dialog
  _dismissDialog() {
    widget.dismissCallback?.call();
    Navigator.of(context).pop();
  }

  /// 点击取消
  void _clickCancel() {
    widget.confirmCallback?.call();
    _dismissDialog();
  }

  /// 点击确定
  void _clickConfirm() {
    widget.confirmCallback?.call();
    _dismissDialog();
  }
}
