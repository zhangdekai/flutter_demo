import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weiChatDemo/base/base_view.dart';

import 'custom_widet_test.dart';
/*
性能优化：

绘制是比较昂贵的操作，所以我们在实现自绘控件时应该考虑到性能开销，下面是两条关于性能优化的建议：

1: 尽可能的利用好shouldRepaint返回值；在UI树重新build时，控件在绘制前都会先调用该方法以确定是否有必要重绘；
假如我们绘制的UI不依赖外部状态，即外部状态改变不会影响我们的UI外观，那么就应该返回false；
如果绘制依赖外部状态，那么我们就应该在shouldRepaint中判断依赖的状态是否改变，
如果已改变则应返回true来重绘，反之则应返回false不需要重绘.

2: 绘制尽可能多的分层；在五子棋的示例中，我们将棋盘和棋子的绘制放在了一起，这样会有一个问题：
由于棋盘始终是不变的，用户每次落子时变的只是棋子，但是如果按照上面的代码来实现，
每次绘制棋子时都要重新绘制一次棋盘，这是没必要的。优化的方法就是将棋盘单独抽为一个组件，
并设置其shouldRepaint回调值为false，然后将棋盘组件作为背景。然后将棋子的绘制放到另一个组件中，
这样每次落子时只需要绘制棋子。

2: 通过 Layer 实现绘制缓存 ?? -> 在Paint中
创建一个 Layer 专门绘制棋盘，然后缓存。
当重绘触发时，如果绘制区域发生了变化，则重新绘制棋盘并缓存；如果绘制区域未变，则直接使用之前的Layer
final layerHandle = LayerHandle<PictureLayer>(); 建议使用 layerHandle.layer

    //将缓存棋盘的layer添加到context中  PaintingContext 的。
    context.addLayer(layerHandle.layer!);
 */

/// 1: 绘制一个 带2个棋子的棋盘
///

class CustomPaintExample extends BaseView {
  @override
  String get title => 'CustomPaintExample';

  @override
  Widget buildPage(BuildContext context) {

    return Center(
      child: Column(
        children: [
          Text('300*300 的棋盘'),
          SizedBox(height: 20),
          SizedBox(
            height: 300,
            width: 300,
            child: Stack(
              // 分层
              children: [
                // RepaintBoundary 给出一个layer 用来单独Paint，不会被其他 animate 或 markNeedsPaint 影响
                RepaintBoundary(
                    child: CustomPaint(
                  // size: Size(300, 300),
                  painter: ChessBoardPaint(),
                  child: SizedBox(
                      height: 300,
                      width: 300,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'CustomPaint child Text -棋盘',
                          textScaleFactor: 1.3,
                        ),
                      )),
                )),

                RepaintBoundary(
                    child: CustomPaint(
                  size: Size(300, 300),
                  painter: ChessBoardCellPaint(),
                )),
              ],
            ),
          ),
          TextButton(onPressed: () {}, child: Text('刷新'))
        ],
      ),
    );
  }

  void drawChessBoardByUnderlineAPI() {
    //1.创建绘制记录器和Canvas
    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);
    //2.在指定位置区域绘制。
    var rect = Rect.fromLTWH(30, 200, 300, 300);
    // drawChessboard(canvas,rect); //画棋盘
    // drawPieces(canvas,rect);//画棋子
    //3.创建layer，将绘制的产物保存在layer中
    var pictureLayer = PictureLayer(rect);
    //recorder.endRecording()获取绘制产物。
    pictureLayer.picture = recorder.endRecording();
    var rootLayer = OffsetLayer();
    rootLayer.append(pictureLayer);
    //4.上屏，将绘制的内容显示在屏幕上。
    final SceneBuilder builder = SceneBuilder();
    final Scene scene = rootLayer.buildScene(builder);

    // View.of(context).render(scene);
  }
}

class ChessBoardPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('paint');

    var paint = Paint()
      ..isAntiAlias = true // 抗锯齿
      ..color = Color(0xFFDCC48C)
      ..style = PaintingStyle.fill;

    // var rect = Offset.zero & size;

    // paint 棋盘背景  size 大小
    // _rect = Rect.fromLTRB(0, 0, size.width, size.height);

    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), paint);

    // paint 棋盘的线, 横线 竖线
    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.black;

    // 横线
    for (int i = 0; i <= 15; i++) {
      var p1dy = i * (size.height / 15);
      canvas.drawLine(Offset(0, p1dy), Offset(size.width, p1dy), paint);
    }

    // 竖线
    for (int i = 0; i <= 15; i++) {
      var p1dx = i * (size.width / 15);
      canvas.drawLine(Offset(p1dx, 0), Offset(p1dx, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class ChessBoardCellPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('paint');
    // paint 棋盘棋子 圆形
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;

    // canvas.drawParagraph(paragraph, offset)

    // 黑子
    var radius = size.width / 15 / 2;
    canvas.drawCircle(Offset(size.width / 2 - radius, size.height / 2 - radius),
        radius, paint);

    // 白字
    paint..color = Colors.white;
    canvas.drawCircle(Offset(size.width / 2 + radius, size.height / 2 + radius),
        radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
