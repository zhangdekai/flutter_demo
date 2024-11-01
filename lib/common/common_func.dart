import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'const.dart';
import 'flipped_directional_widget.dart';

/// 执行 Task 的时间差
void taskMillisecondGap(VoidCallback task) {
  int temp = DateTime.now().millisecondsSinceEpoch;

  task.call();

  int gap = DateTime.now().millisecondsSinceEpoch - temp;

  print('Task spend millisecond = $gap');

  return;
}

Color get randomMaterialColor {
  return Colors.primaries[Random().nextInt(Colors.primaries.length)];
}

AppBar createCommonAppBar(
  BuildContext context, {
  String? title,
  Function()? titleTap,
  Function()? leftTap,
  bool? centerTitle,
  List<Widget>? actions,
  Widget? flexibleSpace,
  TextStyle? titleTextStyle,
  Color? backgroundColor,
  Widget? titleView,
  Widget? leading,
  Widget? leftWidget,
  double? leadingWidth,
  Color? leadIconColor,
  EdgeInsetsGeometry? leadingPadding,
  double? toolbarHeight,
  SystemUiOverlayStyle? systemOverlayStyle,
}) {
  final titleTextWidget = titleView ??
      Text(
        title ?? "",
        style: titleTextStyle ?? TextStyle(color: Colors.black87, fontSize: 16),
      );
  Widget titleWidget = titleTextWidget;
  if (titleTap != null) {
    titleWidget = InkWell(
      onTap: titleTap,
      child: titleTextWidget,
    );
  }
  return AppBar(
    title: titleWidget,
    centerTitle: centerTitle,
    titleSpacing: 0,
    toolbarHeight: toolbarHeight,
    systemOverlayStyle: systemOverlayStyle,
    leading: leading ??
        IconButton(
          padding: leadingPadding,
          icon: FlippedDirectionWidget(
            child: leftWidget ?? Icon(Icons.arrow_back_ios, size: 24, color: leadIconColor ?? Colors.black87),
          ),
          onPressed: () {
            if (leftTap != null) {
              leftTap.call();
            } else {
              Navigator.of(context).maybePop();
            }
          },
        ),
    leadingWidth: leadingWidth,
    elevation: 0,
    actions: actions,
    flexibleSpace: flexibleSpace,
    backgroundColor: backgroundColor ?? weChatThemeColor,
  );
}

Widget createCommonTabBar(BuildContext context, TabController tabController, List<String> tabs,
    {TextStyle? labelStyle, Color? labelColor, ValueChanged<int>? onTap}) {
  return TabBar(
    controller: tabController,
    unselectedLabelColor: Colors.black87.withOpacity(0.6),
    labelColor: labelColor ?? Colors.black87,
    unselectedLabelStyle: labelStyle ?? TextStyle(color: Colors.black87.withOpacity(0.6)),
    labelStyle: labelStyle ?? TextStyle(color: Colors.black87),
    dividerColor: Colors.transparent,
    // indicator: RoundUnderlineTabIndicator(borderSide: BorderSide(width: 1.0, color: labelColor ?? context.cbOnBackground())),
    isScrollable: true,
    tabs: tabs
        .map((e) => Tab(
              text: e,
            ))
        .toList(),
    onTap: onTap,
  );
}
