import 'dart:math';

import 'package:flutter/material.dart';

import 'custom_turnBox.dart';

/// A circular progress indicator with gradient effect.
class GradientCircularProgressIndicator extends StatelessWidget {
  const GradientCircularProgressIndicator({
    Key? key,
    required this.radius,
    this.stokeWidth = 2.0,
    this.colors,
    this.stops,
    this.strokeCapRound = false,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.totalAngle = 2 * pi,
    this.fullColor,
    this.value,
  }) : super(key: key);

  /// The width of the line used to draw the circle.
  final double stokeWidth;

  /// The radius of the [GradientCircularProgressIndicator]
  final double radius;

  /// The kind of finish to place on the end of arc drawn .
  /// if `true`, [StrokeCap.round] will be set to `Paint.strokeCap`.
  final bool strokeCapRound;

  /// The value of this progress indicator with 0.0 corresponding
  /// to no progress having been made and 1.0 corresponding to all the progress
  /// having been made.
  final double? value;

  /// The progress color when value is 1.
  final Color? fullColor;

  /// The progress indicator's background color. The current theme's
  /// `Color(0xFFEEEEEE)` by default.
  final Color backgroundColor;

  /// The total angle of the progress. Defaults to 2*pi (entire circle)
  final double totalAngle;

  /// The colors the gradient should obtain at each of the stops.
  ///
  /// If [stops] is non-null, this list must have the same length as [stops].
  ///
  /// This list must have at least two colors in it (otherwise, it's not a
  /// gradient!).
  final List<Color>? colors;

  /// A list of values from 0.0 to 1.0 that denote fractions along the gradient.
  ///
  /// If non-null, this list must have the same length as [colors].
  ///
  /// If the first value is not 0.0, then a stop with position 0.0 and a color
  /// equal to the first color in [colors] is implied.
  ///
  /// If the last value is not 1.0, then a stop with position 1.0 and a color
  /// equal to the last color in [colors] is implied.
  ///
  /// The values in the [stops] list must be in ascending order. If a value in
  /// the [stops] list is less than an earlier value in the list, then its value
  /// is assumed to equal the previous value.
  ///
  /// If stops is null, then a set of uniformly distributed stops is implied,
  /// with the first stop at 0.0 and the last stop at 1.0.
  final List<double>? stops;

  @override
  Widget build(BuildContext context) {
    double _offset = .0;
    if (strokeCapRound && totalAngle != 2 * pi) {
      _offset = asin(stokeWidth / (radius * 2 - stokeWidth));
    }
    var _colors = colors;
    if (_colors == null) {
      Color color = Theme.of(context).colorScheme.secondary;
      _colors = [color, color];
    }
    return Transform.rotate(
      angle: -pi / 2.0 - _offset,
      child: CustomPaint(
        size: Size.fromRadius(radius),
        painter: _GradientCircularProgressPainter(
          stokeWidth: stokeWidth,
          strokeCapRound: strokeCapRound,
          backgroundColor: backgroundColor,
          value: value,
          fullColor: fullColor,
          total: totalAngle,
          radius: radius,
          colors: _colors,
        ),
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  const _GradientCircularProgressPainter({
    this.stokeWidth = 10.0,
    this.strokeCapRound = false,
    this.backgroundColor = const Color(0xFFEEEEEE),
    this.radius,
    this.total = 2 * pi,
    required this.colors,
    this.stops,
    this.value,
    this.fullColor,
  });

  final double stokeWidth;
  final bool strokeCapRound;
  final double? value;
  final Color backgroundColor;
  final List<Color> colors;
  final double total;
  final double? radius;
  final List<double>? stops;
  final Color? fullColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (radius != null) {
      size = Size.fromRadius(radius!);
    }
    double _offset = stokeWidth / 2.0;
    double _value = (value ?? .0);
    _value = _value.clamp(.0, 1.0) * total;
    double _start = .0;

    if (strokeCapRound) {
      _start = asin(stokeWidth / (size.width - stokeWidth));
    }

    Rect rect = Offset(_offset, _offset) &
        Size(size.width - stokeWidth, size.height - stokeWidth);

    var paint = Paint()
      ..strokeCap = strokeCapRound ? StrokeCap.round : StrokeCap.butt
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = stokeWidth;

    // draw background arc
    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawArc(rect, _start, total, false, paint);
    }

    if (value == 1 && fullColor != null) {
      paint.color = fullColor!;
      canvas.drawArc(rect, _start, _value, false, paint);
    } else if (_value > 0) {
      // draw foreground arc and apply gradient
      paint.shader = SweepGradient(
        startAngle: 0.0,
        endAngle: _value,
        colors: colors,
        stops: stops,
      ).createShader(rect);
      canvas.drawArc(rect, _start, _value, false, paint);
    }
  }

  @override
  bool shouldRepaint(_GradientCircularProgressPainter old) {
    return old.stokeWidth != stokeWidth ||
        old.strokeCapRound != strokeCapRound ||
        old.backgroundColor != backgroundColor ||
        old.radius != radius ||
        old.value != value ||
        old.fullColor != fullColor ||
        old.colors.toString() != colors.toString() ||
        old.stops.toString() != stops.toString();
  }
}

class GradientCircularProgressRoute extends StatefulWidget {
  const GradientCircularProgressRoute({Key? key}) : super(key: key);

  @override
  GradientCircularProgressRouteState createState() {
    return GradientCircularProgressRouteState();
  }
}

class GradientCircularProgressRouteState
    extends State<GradientCircularProgressRoute> with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GradientCircularProgress'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              AnimatedBuilder(
                animation: _animationController,
                builder: (BuildContext context, Widget? child) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      children: <Widget>[
                        Wrap(
                          spacing: 10.0,
                          runSpacing: 16.0,
                          children: <Widget>[
                            GradientCircularProgressIndicator(
                              // No gradient
                              colors: const [Colors.blue, Colors.blue],
                              radius: 50.0,
                              stokeWidth: 3.0,
                              value: _animationController.value,
                            ),
                            GradientCircularProgressIndicator(
                              colors: const [Colors.red, Colors.orange],
                              radius: 50.0,
                              stokeWidth: 3.0,
                              value: _animationController.value,
                            ),
                            GradientCircularProgressIndicator(
                              colors: const [
                                Colors.red,
                                Colors.orange,
                                Colors.red
                              ],
                              radius: 50.0,
                              stokeWidth: 5.0,
                              value: _animationController.value,
                            ),
                            GradientCircularProgressIndicator(
                              colors: const [Colors.teal, Colors.cyan],
                              radius: 50.0,
                              stokeWidth: 5.0,
                              strokeCapRound: true,
                              value: CurvedAnimation(
                                      parent: _animationController,
                                      curve: Curves.decelerate)
                                  .value,
                            ),
                            TurnBox(
                              turns: 1 / 8,
                              child: GradientCircularProgressIndicator(
                                colors: const [
                                  Colors.red,
                                  Colors.orange,
                                  Colors.red
                                ],
                                radius: 50.0,
                                stokeWidth: 5.0,
                                strokeCapRound: true,
                                backgroundColor: Colors.red.shade50,
                                totalAngle: 1.5 * pi,
                                value: CurvedAnimation(
                                  parent: _animationController,
                                  curve: Curves.ease,
                                ).value,
                              ),
                            ),
                            RotatedBox(
                              quarterTurns: 1,
                              child: GradientCircularProgressIndicator(
                                colors: [
                                  Colors.blue.shade700,
                                  Colors.blue.shade200
                                ],
                                radius: 50.0,
                                stokeWidth: 3.0,
                                strokeCapRound: true,
                                backgroundColor: Colors.transparent,
                                value: _animationController.value,
                              ),
                            ),
                            GradientCircularProgressIndicator(
                              colors: [
                                Colors.red,
                                Colors.amber,
                                Colors.cyan,
                                Colors.green.shade200,
                                Colors.blue,
                                Colors.red
                              ],
                              radius: 50.0,
                              stokeWidth: 5.0,
                              strokeCapRound: true,
                              value: _animationController.value,
                            ),
                          ],
                        ),
                        GradientCircularProgressIndicator(
                            colors: [
                              Colors.blue.shade700,
                              Colors.blue.shade200
                            ],
                            radius: 100.0,
                            stokeWidth: 20.0,
                            value: _animationController.value),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: GradientCircularProgressIndicator(
                            colors: [
                              Colors.blue.shade700,
                              Colors.blue.shade200
                            ],
                            radius: 100.0,
                            stokeWidth: 20.0,
                            value: _animationController.value,
                            strokeCapRound: true,
                            fullColor: Colors.blue.shade700,
                          ),
                        ),
                        //剪裁半圆
                        ClipRect(
                          child: Align(
                            alignment: Alignment.topCenter,
                            heightFactor: .5,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: SizedBox(
                                //width: 100.0,
                                child: TurnBox(
                                  turns: .75,
                                  child: GradientCircularProgressIndicator(
                                    colors: [Colors.teal, Colors.cyan.shade500],
                                    radius: 100.0,
                                    stokeWidth: 8.0,
                                    value: _animationController.value,
                                    totalAngle: pi,
                                    strokeCapRound: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 104.0,
                          width: 200.0,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Positioned(
                                height: 200.0,
                                top: .0,
                                child: TurnBox(
                                  turns: .75,
                                  child: GradientCircularProgressIndicator(
                                    colors: [Colors.teal, Colors.cyan.shade500],
                                    radius: 100.0,
                                    stokeWidth: 8.0,
                                    value: _animationController.value,
                                    totalAngle: pi,
                                    strokeCapRound: true,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Text(
                                  "${(_animationController.value * 100).toInt()}%",
                                  style: const TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
