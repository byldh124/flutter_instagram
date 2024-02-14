import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_insta_clone/screen/loading_page.dart';
import 'package:fl_insta_clone/screen/tab_page.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _handleCurrentScreen();
  }

  Widget _handleCurrentScreen() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingPage();
        } else {
          if (snapshot.hasData) {
            return TabPage();
          }
          return LoginPage();
        }
      },
    );
  }
}
