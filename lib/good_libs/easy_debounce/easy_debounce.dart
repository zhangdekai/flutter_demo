import 'package:easy_debounce/easy_debounce.dart';
import 'package:easy_debounce/easy_throttle.dart';

/*

https://pub-web.flutter-io.cn/packages/easy_debounce


函数节流（throttle）与 函数防抖（debounce）都是为了限制函数的执行频次，以优化函数触发频率过高导致的响应速度跟不上触发频率，出现延迟，假死或卡顿的现象
是应对频繁触发事件的优化方案。

防抖就是防止抖动，避免事件的重复触发。
防抖可以概括为触发高频事件后n秒内函数只会执行一次，如果n秒内高频事件再次被触发，则重新计算时间。
n 秒后执行该事件，若在n秒后被重复触发，则重新计时
简单的说，如果某一事件被连续快速地触发多次，只会执行最后那一次。

1:实现方式：每次触发事件时设置一个延迟调用方法，并且取消之前的延时调用方法
2: 如果事件在规定的时间间隔内被不断的触发，则调用方法会被不断的延迟

使用场景

input 搜索录入，用户不断录入值
window触发resize事件
mousemove 鼠标滑动事件
scroll滚动条滑动请求、上拉触底加载更多
表单验证，按钮的提交事件


节流就是减少流量，将频繁触发的事件减少，并每隔一段时间执行。会控制事件触发的频率。所以节流会稀释函数的执行频率。
n 秒内只运行一次，若在n秒内重复触发，只有一次生效。
如果连续快速地触发多次，在规定的时间内，只触发一次。如限制1s，则1s内只执行一次，无论怎样，都在会1s内执行相应的操作。

实现方式：每次触发事件时，如果当前有等待执行的延时函数，则直接return
如果事件在规定的时间间隔内被不断的触发，则调用方法在规定时间内都会执行一次
使用场景

获取验证码
鼠标不断点击触发，mousedown(规定时间内只触发一次)
mousemove 鼠标滑动事件
滚动条滑动请求、上拉触底加载更多
搜索、提交等按钮功能

 */

main() {}

void testDebounce() {
  EasyDebounce.debounce(
      'my-debouncer', // <-- An ID for this particular debouncer
      Duration(milliseconds: 500), // <-- The debounce duration
      () => myMethod() // <-- The target method
      );

  EasyDebounce.cancel('my-debouncer');

  EasyDebounce.cancelAll();

  print('Active debouncers: ${EasyDebounce.count()}');

  EasyDebounce.fire('my-debouncer');
}

void testThrottle() {
  EasyThrottle.throttle(
      'my-throttler', // <-- An ID for this particular debouncer
      Duration(milliseconds: 500), // <-- The debounce duration
      () => myMethod() // <-- The target method
      );

  EasyThrottle.cancel('my-throttler');

  EasyThrottle.cancelAll();

  print('Active throttlers: ${EasyThrottle.count()}');
}

void myMethod() {}
