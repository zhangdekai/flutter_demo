import 'package:flutter/cupertino.dart';

class FlippedDirectionWidget extends StatelessWidget {
  final Widget child;
  const FlippedDirectionWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    bool isRtl = Directionality.of(context) == TextDirection.rtl;
    return isRtl
        ? Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
            child: child,
          )
        : child;
  }
}
