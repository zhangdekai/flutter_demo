/*
https://www.jianshu.com/p/e376574e2402

 */

import 'dart:async';

import 'package:flutter/services.dart';

const String _methodChanelName = 'method_channel_trigger_name';
const String _methodChanelName1 = 'message_channel_trigger_name1';
const String _methodChanelName2 = 'event_channel_trigger_name2';

class PlatformEventTrigger {
  static const channel = const MethodChannel(_methodChanelName);

  static Future<T> sendForResult<T>(String eventName,
      {dynamic arguments}) async {
    var result = await channel.invokeMethod(eventName, arguments);
    if (result is T) {
      return result;
    } else {
      throw 'type error : ${result.runtimeType}';
    }
  }

  static Future<String> receiveMethodForResult() {
    channel.setMethodCallHandler((call) {
      print('test Native 端发来的消息：$call');
      return Future.value('黄河黄河，我是长江');
    });
    return Future.value('');
  }
  /*
  Flutter BasicMessageChannel 用于传递字符串和半结构化的信息, 属于双向通信,
  可以是 iOS 端主动调用, 也可以是 Flutter 端主动调用, 并且在发送消息的同时还可以设置一个回调监听,
   收到消息之后通过回调给消息发送方一个结果(返回值).

   使用场景:

传递简单的数据, 比如字符串, 数字, 字典等
实现简单的双向通信, 比如获取设备信息, 控制原生功能等
   */

  static const messageChannel =
      const BasicMessageChannel(_methodChanelName1, JSONMessageCodec());

  static Future<String> sendMessageForResult<String>(String eventName,
      {String? jsonString}) async {
    var result = await messageChannel.send(jsonString);
    if (result is String) {
      return result;
    } else {
      throw 'type error : ${result.runtimeType}';
    }
  }

  static Future<String> receiveMessageForResult() {
    messageChannel.setMessageHandler((message) {
      print('test Native 端发来的消息：$message');
      return Future.value('黄河黄河，我是长江');
    });
    return Future.value('');
  }

  /*
  EventChannel用于从Native向Flutter发送通知事件，例如Flutter通过其监听Android的重力感应变化等。
  与MethodChannel不同，EventChannel是Native到Flutter的单向调用，调用是一对多的，
  类似Android的BrodcastReceiver.

  Flutter EventChannel 用于事件流的发送（event streams), 属于持续性的单向通信,
   只能是 iOS 端主动调用, 常用于传递原生设备的信息, 状态等, 比如电池电量, 远程通知, 网络状态变化,
    手机方向, 重力感应, 定位位置变化等等.

使用场景:

监听设备状态变化, 比如电池电量, 网络状态变化
接收来自原生设备的事件, 比如远程通知, 定位信息
实现类似于 Android 的传感器监听

  */
  static const eventChannel = const EventChannel(_methodChanelName2);

  /// streamSubscription.cancel();  need call
  static void receiveEventForResult() {
    StreamSubscription streamSubscription =
    eventChannel.receiveBroadcastStream().listen((event) {
      print('event == $event');
    }, onError: (e) {
      print('e == $e');
    });

    // streamSubscription.cancel();
  }
}
