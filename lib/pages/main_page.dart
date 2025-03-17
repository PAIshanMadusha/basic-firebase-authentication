import 'package:basic_firebase_authentication/pages/home_page.dart';
import 'package:basic_firebase_authentication/services/authentication_service.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final String userId =
      AuthenticationService().getCurrentUser()?.uid ?? "unknown";

  void _signOut(BuildContext context) async {
    AuthenticationService().signOut();

    //Navigate to HomePage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );

    //SignOut Message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("You Signed out Successfully!"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Main Page")),
      body: Center(
        child: Column(
          children: [
            Text("Main Page"),
            Text("you are Now Signed In"),
            Text("Your Id: $userId"),
            ElevatedButton(
              onPressed: () => _signOut(context),
              child: Text("SignOut"),
            ),
          ],
        ),
      ),
    );
  }
}
