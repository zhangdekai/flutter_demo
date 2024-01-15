import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weiChatDemo/base/base_getX_view/controller.dart';

class SliverTabViewController extends BaseViewController
    with GetSingleTickerProviderStateMixin {
  List<String> tabBars = ['历史', '人文', '文化', '算数'];

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabBars.length, vsync: this);
  }
}
