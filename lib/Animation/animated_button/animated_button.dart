import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WipeAnimatedButton extends StatefulWidget {
  const WipeAnimatedButton({super.key, required this.buttonText, this.buttonTextSize, required this.onTap});

  final String buttonText;
  final double? buttonTextSize;
  final VoidCallback onTap;

  @override
  State<WipeAnimatedButton> createState() => _WipeAnimatedButtonState();
}

class _WipeAnimatedButtonState extends State<WipeAnimatedButton> with TickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _animation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));

    _animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: 279.w,
        height: 48.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24.w)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFF9BAFF).withOpacity(0.5),
              offset: Offset(0, 4.w),
              blurRadius: 20.w,
            ),
          ],
          gradient: const LinearGradient(
            colors: [
              Color(0xFFFFF9F1),
              Color(0xFFFFF9F1),
              Color(0xFFB8B6FF),
              Color(0xFFFFC0D3),
              Color(0xFFFBECFF),
              Color(0xFFFBECFF),
            ],
            stops: [
              0,
              0.01,
              0.39,
              0.74,
              0.95,
              1,
            ],
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(24.w)),
          child: Stack(
            children: [
              // 光条
              AnimatedBuilder(
                  animation: _animation,
                  builder: (ctx, child) {
                    return Positioned(
                      left: 600.w * _animation.value,
                      top: 0,
                      bottom: 0,
                      width: 82.w,
                      child: Image.asset(
                        "assets/images/ic_wipes_button_light.png",
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
              // 文案
              // Center(
              //   child: Text(
              //     widget.buttonText,
              //     style: AppTextStyle.fontTitle2.copyWith(
              //       color: AppColor.cbBlack,
              //       fontSize: widget.buttonTextSize ?? 18.w,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
