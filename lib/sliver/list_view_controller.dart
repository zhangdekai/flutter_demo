import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:weiChatDemo/base/base_getX_view/controller.dart';

class ListViewController extends BaseViewController {
  ScrollController scrollController = ScrollController();

  bool showTopBar = false;

  RxInt count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    print('onInit');
    scrollController.addListener(() {
      // print('scrollController.offset  == ${scrollController.offset}');
      if (scrollController.offset >= 1000 && !showTopBar) {
        showTopBar = true;
        update();
      } else {
        showTopBar = false;
      }
    });
  }

  void increaseCount() {
    count.value += 10;
  }

  void goUp() {
    showTopBar = false;
    scrollController.animateTo(0,
        duration: Duration(milliseconds: 200), curve: Curves.ease);
    Future.delayed(Duration(milliseconds: 300), () {
      update();
    });
  }

  @override
  void onClose() {
    super.onClose();
    scrollController.dispose();
  }
}
