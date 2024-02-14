import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('signonPress');
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Dastagram',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            Padding(padding: EdgeInsets.all(50)),
            SignInButton(

              Buttons.Google,
              onPressed: () {
                _handleSignin().then((value) => {
                  print(value?.displayName)
                });
              },
            )
          ],
        ),
      ),
    );
  }

  Future<User?> _handleSignin() async {
    GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    User? user;
    if (googleAuth != null) {
      user = (await _auth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken)))
          .user;
    } else {
      user = null;
    }
    return user;
  }
}
