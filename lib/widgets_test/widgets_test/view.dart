import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weiChatDemo/base/base_view.dart';
import 'package:weiChatDemo/widgets_test/widget_api_test.dart';
import 'package:weiChatDemo/widgets_test/widget_dialog.dart';
import 'package:weiChatDemo/widgets_test/widget_valueListenBuilder.dart';

import 'controller.dart';

class WidgetsTestPage extends BaseView {
  WidgetsTestPage({Key? key}) : super(key: key);

  @override
  String get title => 'Widget api test';

  final controller = Get.put(WidgetsTestController());

  @override
  Widget buildPage(BuildContext context) {
    return Column(
      children: [
        TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) {
                return WidgetsApiTest(testType: 0);
              }));
            },
            child: Text('GridViewTest')),
        SizedBox(height: 10),
        TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) {
                return WidgetsApiTest(testType: 1);
              }));
            },
            child: Text('StreamBuilderTest')),
        SizedBox(height: 10),
        TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) {
                return WidgetsApiTest(testType: 2);
              }));
            },
            child: Text('FlexibleTest')),
        SizedBox(height: 10),
        TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) {
                return WidgetsApiTest(testType: 3);
              }));
            },
            child: Text('LayoutBuilderTest')),
        SizedBox(height: 10),
        TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) {
                return WidgetsApiTest(testType: 4);
              }));
            },
            child: Text('FutureBuilderTest')),
        SizedBox(height: 10),
        TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) {
                return WidgetsApiTest(testType: 5);
              }));
            },
            child: Text('AfterLayoutTest')),

        SizedBox(height: 10),
        TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) {
                return ValueListenBuildTest();
              }));
            },
            child: Text('ValueListenBuildTest')),

        SizedBox(height: 10),
        TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) {
                return DialogWidgetTest();
              }));
            },
            child: Text('DialogWidgetTest')),





      ],
    );
  }
}
