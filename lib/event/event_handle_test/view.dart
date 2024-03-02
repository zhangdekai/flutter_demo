import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weiChatDemo/base/base_view.dart';

import 'controller.dart';

/*
Flutter 事件处理流程主要分两步，为了聚焦核心流程，我们以用户触摸事件为例来说明：

1. 命中测试：当手指按下时，触发 PointerDownEvent 事件，按照深度优先遍历当前渲染（render object）树，对每一个渲染对象进行“命中测试”（hit test），如果命中测试通过，则该渲染对象会被添加到一个 HitTestResult 列表当中。
2. 事件分发：命中测试完毕后，会遍历 HitTestResult 列表，调用每一个渲染对象的事件处理方法（handleEvent）来处理 PointerDownEvent 事件，该过程称为“事件分发”（event dispatch）。随后当手指移动时，便会分发 PointerMoveEvent 事件。
3. 事件清理：当手指抬（ PointerUpEvent ）起或事件取消时（PointerCancelEvent），会先对相应的事件进行分发，分发完毕后会清空 HitTestResult 列表。

HitTest 整体逻辑就是：
1. 先判断事件的触发位置是否位于组件范围内，如果不是则不会通过命中测试，此时 hitTest 返回 false，如果是则到第二步。
2. 会先调用 hitTestChildren() 判断是否有子节点通过命中测试，如果是，则将当前节点添加到 HitTestResult 列表，此时 hitTest 返回 true。即只要有子节点通过了命中测试，那么它的父节点（当前节点）也会通过命中测试。
3. 如果没有子节点通过命中测试，则会取 hitTestSelf 方法的返回值，如果返回值为 true，则当前节点通过命中测试，反之则否。
 */

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
        SizedBox(height: 20),
        Text('NotificationListener 监听 ListView'),
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
          // return true;// cancel the notification bubbling
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
            ignoring: true,
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.red[100],
              child: Text('IgnorePointer - invisible in hit test \n ignoring == true'),
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
            'RawGestureDetector - 原始事件类，可自定义Gesture',
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
