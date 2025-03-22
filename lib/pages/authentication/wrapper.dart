import 'package:basic_firebase_authentication/pages/home_page.dart';
import 'package:basic_firebase_authentication/pages/main_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: Colors.black));
        } else if (snapshot.hasData) {
          return MainPage();
        } else {
          return HomePage();
        }
      },
    );
  }
}
