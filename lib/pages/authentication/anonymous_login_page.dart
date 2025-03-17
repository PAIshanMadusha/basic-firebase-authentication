import 'package:basic_firebase_authentication/pages/main_page.dart';
import 'package:basic_firebase_authentication/services/authentication_service.dart';
import 'package:flutter/material.dart';

class AnonymousLoginPage extends StatelessWidget {
  const AnonymousLoginPage({super.key});

  void _signInAnonymously(BuildContext context) async {
    try {
      await AuthenticationService().singInAnonymously();

      //Navigate to Main Page
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Your Signed in as an Anonymous User"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      debugPrint("Error SignIn Anonymously: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Anonymous Login Page"), centerTitle: true),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _signInAnonymously(context),
          child: Text("SignIn Anonymously"),
        ),
      ),
    );
  }
}
