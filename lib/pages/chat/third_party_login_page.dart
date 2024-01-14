import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class ThirdPartyLoginPage extends StatelessWidget {
  const ThirdPartyLoginPage({Key? key}) : super(key: key);

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
                  onPressed: () {
                    _signInApple();
                  },
                )),
            SizedBox(
              height: 50,
            ),
            TextButton(
                onPressed: () {
                  // _signInGoogle(context: context);
                },
                child: _textWidget('Google 登录')),
          ],
        ),
      ),
    );
  }

  Future<void> _signInApple() async {
    final apple = await SignInWithApple.getAppleIDCredential(scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName
    ]);
    print('apple info: userIdentifier: ${apple.userIdentifier}');
    print('apple info: givenName: ${apple.givenName}');
    print('apple info: email: ${apple.email}');
    print('apple info: familyName: ${apple.familyName}');
  }

  /*
  void _signInGoogle({BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      // model.idToken = googleSignInAuthentication.idToken;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);

        // model.user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {

          print('The account already exists with a different credential');

          // ScaffoldMessenger.of(context).showSnackBar(
          //   Authentication.customSnackBar(
          //     content: 'The account already exists with a different credential',
          //   ),
          // );
        } else if (e.code == 'invalid-credential') {

          print('Error occurred while accessing credentials. Try again.');
          // ScaffoldMessenger.of(context).showSnackBar(
          //   Authentication.customSnackBar(
          //     content: 'Error occurred while accessing credentials. Try again.',
          //   ),
          // );
        }
      } catch (e) {
        print('Error occurred using Google Sign In. Try again.');
        // ScaffoldMessenger.of(context).showSnackBar(
        //   Authentication.customSnackBar(
        //     content: 'Error occurred using Google Sign In. Try again.',
        //   ),
        // );
      }
    }
  }

  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Error signing out. Try again.');
      // ScaffoldMessenger.of(context).showSnackBar(
      //   Authentication.customSnackBar(
      //     content: 'Error signing out. Try again.',
      //   ),
      // );
    }
  }

   */

  Widget _textWidget(String title) {
    return Text(
      title,
      style: TextStyle(color: Colors.lightBlue, fontSize: 20),
    );
  }
}
