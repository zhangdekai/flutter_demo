import 'package:flutter/material.dart' hide Page, Action;
import 'package:get/get.dart';
import 'package:weiChatDemo/generated/l10n.dart';
import 'package:weiChatDemo/pages/root_page.dart';

void main() => runApp(MyApp());

const String _homePage = '/homepage';

/// This widget is the root of your application.

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: _buildThemeData,
        initialRoute: _homePage,
        localizationsDelegates: [S.delegate],
        getPages: [
          GetPage(name: _homePage, page: () => RootPage()),
        ]);
  }

  ThemeData get _buildThemeData {
    return ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white);
  }
}
