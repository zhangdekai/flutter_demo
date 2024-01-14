import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weiChatDemo/base/base_provider_view/view.dart';
import 'provider.dart';

// ignore: must_be_immutable
class SliverPageViewPage extends BaseProviderViewPage<SliverPageViewProvider> {
  @override
  String get title => 'PageView';

  @override
  Widget buildPage(BuildContext context) {
    final provider = context.read<SliverPageViewProvider>();

    return PageView();
  }

  @override
  SliverPageViewProvider initProvider() => SliverPageViewProvider();

}
