import 'package:flutter/material.dart';

import 'animation_custom_decorateBox.dart';

class AnimatedAvatarWater extends StatefulWidget {
  const AnimatedAvatarWater({Key? key}) : super(key: key);

  @override
  _AnimatedWidgetsTestState createState() => _AnimatedWidgetsTestState();
}

class _AnimatedWidgetsTestState extends State<AnimatedAvatarWater> {
  @override
  Widget build(BuildContext context) {
    var duration = const Duration(milliseconds: 400);
    return Scaffold(
      appBar: AppBar(
        title: Text('头像 波纹'),
      ),
      body: Center(
        child: OnlineAvatar(
          avatarUrl:
              'https://sync-image.linke.ai/avatar/card/220082.png?x-oss-process=image/resize,w_500,image/format,webp',
          size: 60,
        ),
      ),
    );
  }
}

class OnlineAvatar extends StatefulWidget {
  final String avatarUrl;
  final double size;

  const OnlineAvatar({required this.avatarUrl, required this.size, Key? key}) : super(key: key);

  @override
  _OnlineAvatarState createState() => _OnlineAvatarState();
}

class _OnlineAvatarState extends State<OnlineAvatar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(); // 无限循环
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 波纹动画
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                width: widget.size + _animation.value * 20, // 动态变化的尺寸
                height: widget.size + _animation.value * 20, // 动态变化的尺寸
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.withOpacity(1 - _animation.value),
                ),
              );
            },
          ),
          // 头像
          CircleAvatar(
            radius: widget.size / 2,
            backgroundImage: NetworkImage(widget.avatarUrl),
          ),
          // 在线状态标识
          Positioned(
            bottom: 4,
            right: 4,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
