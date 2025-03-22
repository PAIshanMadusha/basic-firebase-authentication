import 'package:basic_firebase_authentication/pages/authentication/sign_in_page.dart';
import 'package:basic_firebase_authentication/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final String userId =
      AuthenticationService().getCurrentUser()?.uid ?? "unknown";

  void _signOut(BuildContext context) async {
    AuthenticationService().signOut();

    //Navigate to HomePage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  "Main Page",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 58,
                    color: Colors.black,
                  ),
                ),
                SvgPicture.asset(
                  "assets/mainpage.svg",
                  height: 400,
                  width: 400,
                  fit: BoxFit.cover,
                ),
                Text(
                  "you are Now Signed-In",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Your Id: $userId",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blueGrey,
                  ),
                ),
                SizedBox(height: 50),
                GestureDetector(
                  onTap: () => _signOut(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "SingOut",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 34,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 60),
                Text(
                  "Created by: PAIshanMadusha",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
