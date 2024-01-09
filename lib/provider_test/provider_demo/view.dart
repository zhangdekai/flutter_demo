import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weiChatDemo/provider_test/number_counter/view.dart';
import 'package:weiChatDemo/provider_test/provider_test_case.dart';

import 'provider.dart';

class ProviderDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProviderDemoProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<ProviderDemoProvider>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Example'),
        ),
        body: Column(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => NumberCounterPage()));
                },
                child: Text('Provider number counter')),
            SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => ProviderTestCase()));
                },
                child: Text('Provider 封装 counter')),
          ],
        ));
  }
}
