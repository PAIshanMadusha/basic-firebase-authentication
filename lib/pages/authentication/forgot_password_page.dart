import 'package:basic_firebase_authentication/services/authentication_service.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  Future<void> _sendPasswordResetEmail() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      final email = _emailController.text.trim();
      await AuthenticationService().sendPasswordResetEmail(email: email);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "A Password Reset Link has been Sent to Your Email Addrss",
            ),
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error Sending Password Reset Email: $error")),
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
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 32),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    "Reset, Your Password!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 38,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "Have you forgotten your current password? Enter here your Email and Obtain the Password Reset Link.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 22, color: Colors.blueGrey),
                    ),
                  ),
                  SizedBox(height: 50),
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
                        return "Please Enter Your Email";
                      } else if (!RegExp(
                        r'^[^@]+@[^@]+\.[^@]+',
                      ).hasMatch(value)) {
                        return "Enter a Valid Email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: _sendPasswordResetEmail,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child:
                            _isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                  "Send Password Reset Link",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 24,
                                  ),
                                ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
