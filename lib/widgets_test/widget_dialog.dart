import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weiChatDemo/base/base_view.dart';

/*
https://book.flutterchina.club/chapter7/dailog.html#_7-7-1-使用对话框

AlertDialog、SimpleDialog以及Dialog是Material组件库提供的三种对话框，
旨在帮助开发者快速构建出符合Material设计规范的对话框，但可以自定义对话框样式.

可以把对话框分为内部样式和外部样式两部分。内部样式指对话框中显示的具体内容；外部样式包含对话框遮罩样式、打开动画等
 */

class DialogWidgetTest extends BaseView {
  @override
  String get title => 'Dialog';

  bool _checkValue = false;

  @override
  Widget buildPage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('Show Dialog with Material design'),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextButton(
                onPressed: () async {
                  final res = await showDeleteConfirmDialog1(context);
                  print('res == $res');
                },
                child: Text('AlterDialog')),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextButton(
                onPressed: () async {
                  final res = await showDeleteConfirmDialog1(context,
                      wrapListView: true);
                  print('res == $res');
                },
                child: Text('Dialog wrap ListView')),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextButton(
                onPressed: () {
                  showSimpleDialog(context);
                },
                child: Text('SimpleDialog')),
          ),
          SizedBox(height: 20),
          Text('Show Dialog with Cupertino design \n Cupertino(平果总部所在地)'),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextButton(
                onPressed: () {
                  _buildShowCupertinoDialog(context);
                },
                child: Text('showCupertinoDialog CupertinoAlertDialog')),
          ),
          SizedBox(height: 20),
          Text('Show Customer Dialog'),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextButton(
                onPressed: () {
                  _buildShowCustomDialog(context);
                },
                child: Text('showGeneralDialog customer')),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextButton(
                onPressed: () {
                  _buildShowDialog(context);
                },
                child: Text('StatefulBuild in AlertDialog')),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextButton(
                onPressed: () {
                  _buildShowModalBottomSheet(context);
                },
                child: Text('showModalBottomSheet')),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: TextButton(
                onPressed: () {
                  _buildShowLoadingDialog(context);
                },
                child:
                    Text('show Container width 280 - UnconstrainedBox wrap')),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _buildShowLoadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true, //点击遮罩不关闭对话框
      builder: (context) {
        /// UnconstrainedBox 允许child 无约束； 可以抵抗 父类的约束
        return UnconstrainedBox(
          constrainedAxis: Axis.vertical,
          child: SizedBox(
            width: 280,
            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.only(top: 26.0),
                    child: Text("正在加载，请稍后..."),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<int?> _buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return ListView.builder(
          itemCount: 30,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("$index"),
              onTap: () => Navigator.of(context).pop(index),
            );
          },
        );
      },
    );
  }

  Future<dynamic> _buildShowDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: Text('选择'),
            content: Row(
              children: [
                Text('是否加盐'),
                StatefulBuilder(builder: (con, _state) {
                  return Checkbox(
                      value: _checkValue,
                      onChanged: (v) {
                        // //1: 将 con 标脏 need build in next frame
                        // (con as Element).markNeedsBuild();
                        // _checkValue = v!;

                        _state(() {
                          _checkValue = v!;
                        });
                        print('_checkValue == $_checkValue');
                      });
                })
              ],
            ),
            actions: _actions(context),
          );
        });
  }

  Future<bool?> _buildShowCustomDialog(BuildContext context) {
    return showCustomDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要删除当前文件吗?"),
          actions: <Widget>[
            TextButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text("删除"),
              onPressed: () {
                // 执行删除操作
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> _buildShowCupertinoDialog(BuildContext context) {
    return showCupertinoDialog(
        barrierDismissible: true,
        context: context,
        builder: (c) {
          return CupertinoAlertDialog(
            title: Text('Cupertino dialog'),
            content: Text('content - 你好'),
          );
        });
  }

  Future<T?> showCustomDialog<T>({
    required BuildContext context,
    bool barrierDismissible = true,
    required WidgetBuilder builder,
    ThemeData? theme,
  }) {
    final ThemeData theme = Theme.of(context);
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        final Widget pageChild = Builder(builder: builder);
        return SafeArea(
          child: Builder(builder: (BuildContext context) {
            return theme != null
                ? Theme(data: theme, child: pageChild)
                : pageChild;
          }),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black87, // 自定义遮罩颜色
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: _buildMaterialDialogTransitions,
    );
  }

  Widget _buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    // 使用缩放动画
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }

  // 弹出对话框
  Future<bool?> showDeleteConfirmDialog1(BuildContext context,
      {bool? wrapListView = false}) {
    final warpListView = _dialog();
    return showDialog<bool>(
      context: context,
      builder: (context) {
        if (wrapListView!) {
          return warpListView;
        }
        return AlertDialog(
          title: Text("提示"),
          content: Text(
              "您确定要删除当前文件吗?"), //, // content 不可直接使用ListView 这类不报告内部维度的widget，即 IntrinsicWidth 类,
          actions: _actions(context),
        );
      },
    );
  }

  Dialog _dialog() {
    return Dialog(
        child: Column(
      children: [
        Text('选择'),
        Expanded(
            child: ListView.separated(
                itemBuilder: (c, i) {
                  return ListTile(
                    title: Text('$i - 看客流浪了'),
                  );
                },
                separatorBuilder: (c, i) => Divider(),
                itemCount: 25))
      ],
    ));
  }

  List<Widget> _actions(BuildContext context) {
    return <Widget>[
      TextButton(
        child: Text("取消"),
        onPressed: () => Navigator.of(context).pop(), // 关闭对话框
      ),
      TextButton(
        child: Text("删除"),
        onPressed: () {
          //关闭对话框并返回true
          Navigator.of(context).pop(true);
        },
      ),
    ];
  }

  Future<void> showSimpleDialog(BuildContext context) async {
    int? i = await showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('请选择语言'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  // 返回1
                  Navigator.pop(context, 1);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text('中文简体'),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  // 返回2
                  Navigator.pop(context, 2);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: const Text('美国英语'),
                ),
              ),
            ],
          );
        });

    if (i != null) {
      print("选择了：${i == 1 ? "中文简体" : "美国英语"}");
    }
  }
}

class _DialogModel extends ChangeNotifier {}
