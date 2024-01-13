import 'package:get/get.dart';

import 'state.dart';

/// 父GetxController 可添加 Loading， ViewState， dialog show 等；
class BaseViewController extends GetxController {
  final BaseViewState state = BaseViewState();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  @override
  // TODO: implement onDelete
  InternalFinalCallback<void> get onDelete => super.onDelete;

  @override
  // TODO: implement onStart
  InternalFinalCallback<void> get onStart => super.onStart;
}
