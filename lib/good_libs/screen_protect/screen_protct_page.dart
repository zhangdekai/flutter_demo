import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:weiChatDemo/common/common_func.dart';
import 'package:weiChatDemo/common/toast_util.dart';

class ScreenProtectPage extends StatefulWidget {
  const ScreenProtectPage({super.key});

  @override
  State<ScreenProtectPage> createState() => _ScreenProtectPageState();
}

class _ScreenProtectPageState extends State<ScreenProtectPage> {
  @override
  void initState() {
    super.initState();
    ScreenProtector.preventScreenshotOn();
    ScreenProtector.addListener(() {
      ToastUtil.show('不可截屏');
    }, (v) {
      if (v) {
        ToastUtil.show('不可录屏');
      }
    });
  }

  @override
  void dispose() {
    ScreenProtector.preventScreenshotOff();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createCommonAppBar(context, title: 'Screen_protect'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Image.network(
            'https://staticai.linke.ai/comic/post/cover/2081/12b345838667a420fa6d234f3e624af1.jpg',
          ),
        ),
      ),
    );
  }
}
