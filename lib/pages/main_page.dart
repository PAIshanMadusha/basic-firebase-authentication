import 'package:basic_firebase_authentication/services/authentication_service.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final String userId =
      AuthenticationService().getCurrentUser()?.uid ?? "unknown";

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
          ],
        ),
      ),
    );
  }
}
