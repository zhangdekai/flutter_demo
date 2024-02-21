import 'package:flukit/example/routes/watermark.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:weiChatDemo/base/base_view.dart';
import 'package:weiChatDemo/common/common_button.dart';

import 'custom_paint_circle.dart';
import 'custom_paint_example.dart';
import 'custom_renderWidget_checkBox.dart';

/// 在Flutter中自定义组件有三种方式：通过组合其他组件、自绘和实现RenderObject。
/// 最常用方式便是 组合其他组件.

///通过组合的方式定义组件和我们之前写界面并无差异，不过在抽离出单独的组件时我们要考虑代码规范性，
///如必要参数要用required关键词标注，对于可选参数在特定场景需要判空或设置默认值等。
///这是由于使用者大多时候可能不了解组件的内部细节，所以为了保证代码健壮性，
///我们需要在用户错误地使用组件时能够兼容或报错提示 (使用assert断言函数）。
///

class CustomWidgetTest extends BaseView {
  @override
  String get title => 'CustomWidgetTest';

  String _currentTxt = '_CustomButton';

  @override
  Widget buildPage(BuildContext context) {

    print('CustomWidgetTest build');
    return Center(
      child: Column(
        children: [
          _buildFirstCustomWidget(),
          PushButton.button1(
              context, CustomPaintExample(), 'CustomPaintExample'),
          PushButton.button1(context, GradientCircularProgressRoute(),
              'GradientCircularProgress'),
          PushButton.button1(
              context, CustomCheckboxTest(), 'CustomCheckboxTest'),
          PushButton.button1(
              context,
              Scaffold(
                appBar: AppBar(title: Text('WaterMark')),
                body: WatermarkRoute(),
              ),
              'WatermarkRoute'),
        ],
      ),
    );
  }

  StatefulBuilder _buildFirstCustomWidget() {

    return StatefulBuilder(
      builder: (c, s) {
        print('StatefulBuilder build');
        return _CustomButton(
          text: _currentTxt,
          background: Colors.green[200],
          onTap: () {
            s(() {
              _currentTxt = 'StatefulWidget _CustomButton 值修改了 为1';
            });
          },
        );
      },
    );
  }
}

class _CustomButton extends StatefulWidget {
  final String? text;
  final Color? background;
  final VoidCallback? onTap;
  const _CustomButton({super.key, this.text = '', this.background, this.onTap});

  @override
  State<_CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<_CustomButton> {
  late String title;

  @override
  void initState() {
    super.initState();
    title = widget.text!;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        color: widget.background,
        child: Text(title),
      ),
    );
  }

  /// 同步外部修改的值
  @override
  void didUpdateWidget(covariant _CustomButton oldWidget) {
    if (oldWidget.text != widget.text) {
      print('didUpdateWidget oldWidget.text != widget.text');
      setState(() {
        title = widget.text!;
      });
    }
    super.didUpdateWidget(oldWidget);
  }
}
