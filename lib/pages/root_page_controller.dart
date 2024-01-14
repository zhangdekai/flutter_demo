import 'package:flutter/material.dart';
import 'package:weiChatDemo/base/base_getX_view/controller.dart';

class RootPageController extends BaseViewController {
  PageController pageController = PageController();

  int currentIndex = 0;

  void onTap(int index) {
    currentIndex = index;
    pageController.jumpToPage(index);
    refresh();
  }
}
