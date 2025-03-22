import 'package:basic_firebase_authentication/pages/authentication/sign_in_page.dart';
import 'package:basic_firebase_authentication/pages/authentication/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: size.height,
        width: size.height,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: size.height * 0.53,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                  color: Colors.blue,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/homepage.svg",
                    height: 500,
                    width: 500,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.6,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "Basic Firebase\nAuthentication",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 52,
                        color: Colors.blueGrey,
                        height: 1,
                      ),
                    ),
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "A simple Flutter app that implements Firebase\nAuthentication, allowing users to SignUp, SingIn, and SingOut securely.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                      ),
                    ),
                    SizedBox(height: size.height * 0.09),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: size.height * 0.08,
                              width: size.width / 2.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black,
                                border: Border.all(color: Colors.white24),
                                boxShadow: [
                                  BoxShadow(
                                    // ignore: deprecated_member_use
                                    color: Colors.black12.withOpacity(0.05),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(0, -1),
                                  ),
                                ],
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignInPage(),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Text(
                                    "SignIn",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpPage(),
                                  ),
                                );
                              },
                              child: Container(
                                height: size.height * 0.08,
                                width: size.width / 2.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black,
                                  border: Border.all(color: Colors.white24),
                                  boxShadow: [
                                    BoxShadow(
                                      // ignore: deprecated_member_use
                                      color: Colors.black12.withOpacity(0.05),
                                      spreadRadius: 1,
                                      blurRadius: 7,
                                      offset: Offset(0, -1),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    "SignUp",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
