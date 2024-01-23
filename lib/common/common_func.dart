import 'package:flutter/foundation.dart';

/// 执行 Task 的时间差
void taskMillisecondGap(VoidCallback task) {
  int temp = DateTime.now().millisecondsSinceEpoch;

  task.call();

  int gap = DateTime.now().millisecondsSinceEpoch - temp;

  print('Task spend millisecond = $gap');

  return;
}
