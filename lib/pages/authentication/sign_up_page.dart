import 'package:basic_firebase_authentication/pages/authentication/sign_in_page.dart';
import 'package:basic_firebase_authentication/pages/home_page.dart';
import 'package:basic_firebase_authentication/pages/main_page.dart';
import 'package:basic_firebase_authentication/services/authentication_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //TextFormField
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  //FormKey
  final _formKey = GlobalKey<FormState>();

  //IsLoading
  bool _isLoading = false;

  //Register User
  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final confirmPassword = _confirmPasswordController.text.trim();

      if (password != confirmPassword) {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text("Error"),
                content: Text("Password Doesn't Match"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              ),
        );
        return;
      }
      await AuthenticationService().registerUser(
        email: email,
        password: password,
      );
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error with Creating User: $error")),
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
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Welcome, New User!",
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
                    "Enter your Email, Password and Confirm Password to Create a New  Account!",
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
                      return "Please Enter an Email!";
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
                      return "Please Enter the Password";
                    } else if (value.length < 6) {
                      return "Password must be at least 6 characters long";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: _confirmPasswordController,
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
                    hintText: "Confirm Password",
                    hintStyle: TextStyle(color: Colors.black87, fontSize: 19),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter the Confirm Password";
                    } else if (value != _passwordController.text) {
                      return "Passowrd Doesn't Match";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40),
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : GestureDetector(
                      onTap: _registerUser,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "SingUp",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 34,
                            ),
                          ),
                        ),
                      ),
                    ),
                SizedBox(height: 50),
                Text.rich(
                  TextSpan(
                    text: "Already have an Account? ",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                    children: [
                      TextSpan(
                        text: "Login Here",
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
                                    builder: (context) => SignInPage(),
                                  ),
                                );
                              },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
