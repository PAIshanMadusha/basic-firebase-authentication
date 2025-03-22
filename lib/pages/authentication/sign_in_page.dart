import 'package:basic_firebase_authentication/pages/authentication/forgot_password_page.dart';
import 'package:basic_firebase_authentication/pages/authentication/sign_up_page.dart';
import 'package:basic_firebase_authentication/pages/home_page.dart';
import 'package:basic_firebase_authentication/pages/main_page.dart';
import 'package:basic_firebase_authentication/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  //TextFormField
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //FormKey
  final _formKey = GlobalKey<FormState>();

  //IsLoading
  bool _isLoading = false;

  //Anonymous Login
  void _signInAnonymously(BuildContext context) async {
    try {
      await AuthenticationService().singInAnonymouslyWithExceptions();
      //Navigate to Main Page
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
        //Signed in Message
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

  //SignIn With Email
  Future<void> _signInUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      await AuthenticationService().singInUser(
        email: email,
        password: password,
      );
      //Signed in Message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Sign-In Successfully!"),
            duration: Duration(seconds: 1),
          ),
        );
      }
      //Navigate to MainPage if SignIn Successful
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error with SignIn User: $error")),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  //SignIn With Google
  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await AuthenticationService().signInWithGoogle();
      // Check if user is signed in after the sign-in process
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        // User canceled sign-in, show a message and return
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Google Sign-In was canceled."),
              duration: Duration(seconds: 2),
            ),
          );
        }
        return; // Stop execution, prevent navigation
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Sign-In Successfully!"),
            duration: Duration(seconds: 1),
          ),
        );
        // Navigate to MainPage only if a user is signed in
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error with Google Sign-In: $error")),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  //SignIn With GitHub
  Future<void> _signInWithGitHub() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await AuthenticationService().signInWithGitHub();
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        // User canceled sign-in, show a message and return
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("GitHub Sign-In was canceled."),
              duration: Duration(seconds: 2),
            ),
          );
        }
        return;
      }
      //Signed in Message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Sign-In Successfully!"),
            duration: Duration(seconds: 1),
          ),
        );

        // Navigate to MainPage Only If a User is Signed In
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error with GitHub Sign-In: $error")),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 32),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Hello Again!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 58,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Wellcome Back You've been Missed!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 27, color: Colors.blueGrey),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 26,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Email",
                    hintStyle: TextStyle(color: Colors.black87, fontSize: 19),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter an Email";
                    } else if (!RegExp(
                      r'^[^@]+@[^@]+\.[^@]+',
                    ).hasMatch(value)) {
                      return "Please Enter a Valid Email";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 26,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Password",
                    hintStyle: TextStyle(color: Colors.black87, fontSize: 19),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter a Password";
                    } else if (value.length < 6) {
                      return "Password must be at least 6 characters long ";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage(),
                        ),
                      );
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: _signInUser,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child:
                          _isLoading == true
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                "SingIn",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 34,
                                ),
                              ),
                    ),
                  ),
                ),
                SizedBox(height: 45),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height: 2, width: 50, color: Colors.black45),
                    SizedBox(width: 3),
                    Text(
                      "Or Continue With",
                      style: TextStyle(color: Colors.blueGrey, fontSize: 20),
                    ),
                    SizedBox(width: 3),
                    Container(height: 2, width: 50, color: Colors.black45),
                  ],
                ),
                SizedBox(height: 45),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => _signInAnonymously(context),
                      child: loginItemCard("assets/anonymity.png"),
                    ),
                    GestureDetector(
                      onTap: _signInWithGoogle,
                      child: loginItemCard("assets/google.png"),
                    ),
                    GestureDetector(
                      onTap: _signInWithGitHub,
                      child: loginItemCard("assets/github.png"),
                    ),
                  ],
                ),
                SizedBox(height: 45),
                Text.rich(
                  TextSpan(
                    text: "Don't have an Account, ",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                    children: [
                      TextSpan(
                        text: "Register Here",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpPage(),
                                  ),
                                );
                              },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container loginItemCard(String image) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Image.asset(image, height: 60, width: 60, fit: BoxFit.cover),
    );
  }
}
