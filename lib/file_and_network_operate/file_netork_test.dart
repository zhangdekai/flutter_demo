import 'package:flutter/material.dart';
import 'package:weiChatDemo/base/base_view.dart';

import '../common/common_button.dart';
import 'file_io_operate.dart';
import 'http_operte.dart';
import 'webSocket_operte.dart';

class FileAndNetworkTest extends BaseView{
  @override
  Widget buildPage(BuildContext context) {
    return Center(
      child: Column(
        children: [

          PushButton.button1(context, FileOperateTest(), 'File 读写'),
          PushButton.button1(context, HttpOperateTest(), 'Http -> dio get'),
          PushButton.button1(context, WebSocketOperateTest(), 'WebSocketOperate'),


        ]

      ),
    );
  }

}