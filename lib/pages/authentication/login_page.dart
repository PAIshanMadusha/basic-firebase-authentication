import 'package:basic_firebase_authentication/pages/authentication/register_page.dart';
import 'package:basic_firebase_authentication/pages/main_page.dart';
import 'package:basic_firebase_authentication/services/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  //SignIn
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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("SignIn Successfully!"),
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

  //SignIn with Google
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page"), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: "Email"),
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
                  decoration: InputDecoration(labelText: "Password"),
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
                _isLoading == true
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                      children: [
                        ElevatedButton(
                          onPressed: _signInUser,
                          child: Text("Login"),
                        ),
                        ElevatedButton(
                          onPressed: _signInWithGoogle,
                          child: Text("SignIn with Google"),
                        ),
                      ],
                    ),
                SizedBox(height: 15),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text(
                    "Don't have an Account, Register Here",
                    style: TextStyle(color: Colors.blue),
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
