import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weiChatDemo/base/base_view.dart';

import 'controller.dart';

class EventHandleTestPage extends BaseView {
  EventHandleTestPage({Key? key}) : super(key: key);

  @override
  String get title => 'Event Handle';

  final controller = Get.put(EventHandleTestController());

  @override
  Widget buildPage(BuildContext context) {
    return Column(
      children: [
        _buildListener(),
        _buildGestureDetector(),
        MyRawGestureDetector(),
        _buildNotificationListener()
      ],
    );
  }

  /// A widget that listens for [Notification]s bubbling up the tree.
  NotificationListener<Notification> _buildNotificationListener() {
    return NotificationListener(
        onNotification: (notification) {
          print(
              'notification.runtimeType == ${notification.runtimeType}  hashCode == ${notification.hashCode}');
          switch (notification.runtimeType) {
            case ScrollStartNotification:
              print("开始滚动");
              break;
            case ScrollUpdateNotification:
              print("正在滚动");
              break;
            case ScrollEndNotification:
              print("滚动停止");
              break;
            case OverscrollNotification:
              print("滚动到边界");
              break;
          }

          /// ScrollNotification, LayoutChangedNotification, KeepAliveNotification
          return false;// continue the notification bubbling
          return true;// cancel the notification bubbling
        },
        child: Expanded(
          child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("$index"),
                );
              }),
        ),
      );
  }

  /// A widget that detects gestures.
  GestureDetector _buildGestureDetector() {
    return GestureDetector(
      onTap: () {},
      onLongPress: () {},
      // 滑动
      onPanDown: (DragDownDetails details) {},
      // 缩放
      onScaleUpdate: (ScaleUpdateDetails details) {},
      onVerticalDragUpdate: (DragUpdateDetails details) {},
      child: Container(
        padding: EdgeInsets.all(16),
        color: Colors.red[200],
        child: Text('GestureDetector'),
      ),
    );
  }

  //A widget that calls callbacks in response to common pointer events
  Listener _buildListener() {
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        print('event.position ${event.position}');
      },
      onPointerUp: (PointerUpEvent event) {
        print('event.localPosition ${event.localPosition}');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IgnorePointer(
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.red[100],
              child: Text('IgnorePointer - invisible in hit test'),
            ),
          ),
          AbsorbPointer(
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.greenAccent,
              child: Text('AbsorbPointer - not invisible in hit test'),
            ),
          )
        ],
      ),
    );
  }
}

/// RawGestureDetector 提供了更底层、直接的手势事件处理能力,可以定制化的手势事件。
/// 它允许你监听原始指针事件，包括按下、移动、抬起等，而无需考虑特定的语义手势.
class MyRawGestureDetector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        MyTapGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<MyTapGestureRecognizer>(
          () => MyTapGestureRecognizer(),
          (MyTapGestureRecognizer instance) {
            instance.onTap = () {
              print('Raw Tap Detected!');
            };
          },
        ),
      },
      child: Container(
        padding: EdgeInsets.all(16),
        color: Colors.blue,
        child: Center(
          child: Text(
            'RawGestureDetector - Tap Me!',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class MyTapGestureRecognizer extends OneSequenceGestureRecognizer {
  Function()? onTap;

  @override
  void addPointer(PointerEvent event) {
    // 当按下时触发 onTap 回调
    if (event is PointerDownEvent) {
      onTap?.call();
    }
  }

  @override
  String get debugDescription => 'override OneSequenceGestureRecognizer';

  @override
  void didStopTrackingLastPointer(int pointer) {}

  @override
  void handleEvent(PointerEvent event) {}
}
