import 'package:basic_firebase_authentication/pages/authentication/anonymous_login_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnonymousLoginPage(),
    );
  }
}