import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:screenshot/screenshot.dart';
import 'package:weiChatDemo/common/common_func.dart';
import 'package:weiChatDemo/common/toast_util.dart';

class ScreenShotPage extends StatefulWidget {
  const ScreenShotPage({super.key});

  @override
  State<ScreenShotPage> createState() => _ScreenProtectPageState();
}

class _ScreenProtectPageState extends State<ScreenShotPage> {
  ScreenshotController controller = ScreenshotController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: createCommonAppBar(context, title: 'Screen_shot'),
      body: SafeArea(
        child: Column(
          children: [
            TextButton(
                onPressed: () async {
                  final directory = (await getApplicationDocumentsDirectory()).path; //from path_provide package
                  String fileName = DateTime.now().microsecondsSinceEpoch.toString();
                  var image = await controller.captureAndSave(directory, fileName: fileName);
                  if (image != null) {
                    ToastUtil.showToast(context, '成功');

                    //TODO: - cun 到 相册
                  }
                },
                child: Text('截图-保存到本地')),
            Screenshot(
              controller: controller,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Image.network(
                  'https://staticai.linke.ai/comic/post/cover/2081/12b345838667a420fa6d234f3e624af1.jpg',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
