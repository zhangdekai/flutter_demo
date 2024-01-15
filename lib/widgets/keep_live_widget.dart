
import 'package:flutter/material.dart';

/// 为 SliverView children Keep live 需要mixIn  AutomaticKeepAliveClientMixin
/// ListView PageView 皆可使用此，进行列表缓存
/// 但 缓存太多Item项，内存压力就会变大。
///
class KeepLiveWidget extends StatefulWidget {
  final Widget child;
  final bool? keepLive;
  const KeepLiveWidget(this.child,{this.keepLive = true});

  @override
  State<KeepLiveWidget> createState() => _KeepLiveWidgetState();
}

class _KeepLiveWidgetState extends State<KeepLiveWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  void didUpdateWidget(covariant KeepLiveWidget oldWidget) {
    if(oldWidget.keepLive != widget.keepLive){
      // keepAlive 状态需要更新，实现在 AutomaticKeepAliveClientMixin 中
      updateKeepAlive();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  bool get wantKeepAlive => widget.keepLive!;
}
