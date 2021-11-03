import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class ThirdPartyLoginPage extends StatelessWidget {
  const ThirdPartyLoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('三方登录'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            TextButton(
                onPressed: () {},

                /// ios > 13
                /// apple 登录 =》需要配置iOS
                /// native ： https://www.jianshu.com/p/4d7afc83c39b
                child: SignInWithAppleButton(
                  onPressed: () async {
                    final apple = await SignInWithApple.getAppleIDCredential(
                        scopes: [
                          AppleIDAuthorizationScopes.email,
                          AppleIDAuthorizationScopes.fullName
                        ]);

                    print(
                        'apple info: userIdentifier: ${apple.userIdentifier}');
                    print('apple info: givenName: ${apple.givenName}');
                    print('apple info: email: ${apple.email}');
                    print('apple info: familyName: ${apple.familyName}');
                  },
                )),
            SizedBox(
              height: 50,
            ),
            TextButton(onPressed: () {}, child: _textWidget('Google 登录')),
          ],
        ),
      ),
    );
  }

  Widget _textWidget(String title) {
    return Text(
      title,
      style: TextStyle(color: Colors.lightBlue, fontSize: 20),
    );
  }
}
