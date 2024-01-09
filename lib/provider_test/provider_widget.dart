import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Provider 源码略解： https://juejin.cn/post/6968272002515894303#heading-6
/// 观察者模式，借用树机制，给子widget 传递数据。

/// ProviderWidget 简单封装
class ProviderWidget<T extends ChangeNotifier> extends StatefulWidget {
  final T model;
  final Widget Function(BuildContext context, T value, Widget? child) builder;
  final Function(T) onReady;

  ProviderWidget(this.model, this.builder, this.onReady);

  @override
  _ProviderWidgetState<T> createState() => _ProviderWidgetState<T>();
}

class _ProviderWidgetState<T extends ChangeNotifier>
    extends State<ProviderWidget<T>> {
  @override
  void initState() {
    super.initState();
    widget.onReady.call(widget.model);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>(
      create: (_) => widget.model,
      child: Consumer<T>(builder: widget.builder),
    );
  }
}
