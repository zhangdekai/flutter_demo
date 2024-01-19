import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weiChatDemo/Animation/animation_scale_test.dart';
import 'package:weiChatDemo/base/base_view.dart';

import '../common/common_button.dart';
import 'animation_custom_decorateBox.dart';
import 'animation_hero.dart';
import 'animation_stagger.dart';
import 'animation_switcher.dart';
import 'animation_widget_test.dart';
import 'animation_widget_test1.dart';
/*

Flutter中也对动画进行了抽象，主要涉及 Animation、Curve、Controller、Tween这四个角色，
它们一起配合来完成一个完整动画.

Animation<T>:  Animation<T> extends Listenable
是一个抽象类，它本身和UI渲染没有任何关系，而它主要的功能是保存动画的插值和状态；
其中一个比较常用的Animation类是Animation<double>.

addListener() 侦监听, addStatusListener(...)，动画状态监听。

Curve:
动画过程可以是匀速的、匀加速的或者先加速后减速等。
Flutter中通过Curve（曲线）来描述动画过程，我们把匀速动画称为线性的(Curves.linear)，而非匀速动画称为非线性的.

AnimationController:   class AnimationController extends Animation<double>
用于控制动画，它包含动画的启动forward()、停止stop() 、反向播放 reverse()等方法。
AnimationController会在动画的每一帧，就会生成一个新的值,默认[0,1].

Tween: class Tween<T extends Object?> extends Animatable<T>
开始和结束之间的插值，可为 int,color,double 等.

 */

class AnimationPageTest extends BaseView {
  @override
  String get title => 'Animation Test';

  @override
  Widget buildPage(BuildContext context) {
    return Center(
      child: Column(
        children: [
          PushButton.button1(context, ScaleAnimationRoute(), 'Scale Animation'),
          TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 16))),
              onPressed: () {
                Navigator.push(context, PageRouteBuilder(
                    pageBuilder: (context, animation, secondAnimation) {
                  /// 可自定义带animation 的widget。
                  return FadeTransition(
                      opacity: animation, child: ScaleAnimationRoute());
                }));
              },
              child: Text(
                'PageRouteBuilder - FadeTransition',
                textScaleFactor: 1.5,
              )),
          PushButton.button1(context, HeroAnimationRouteA(), 'Hero Animation'),
          PushButton.button1(
              context, StaggerAnimationTest(), 'Stagger Animation'),
          PushButton.button1(
              context, AnimationSwitcherTest(), 'AnimatedSwitcher'),
          PushButton.button1(
              context, AnimationCustomExample(), 'Custom Animation Decorate'),
          PushButton.button1(
              context, AnimationWidgetTest(), 'AnimationWidgetTest'),
          PushButton.button1(
              context, AnimatedWidgetsTest1(), 'AnimationWidgetTest1'),
        ],
      ),
    );
  }
}
