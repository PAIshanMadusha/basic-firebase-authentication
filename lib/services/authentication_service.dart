import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //SignIn Anonymously
  Future<void> singInAnonymously ()async{
    try{
      final UserCredential userCredential = await _auth.signInAnonymously();
      final user = userCredential.user;

      if(user != null){
        debugPrint("SignIn Anonymously: ${user.uid}");
      }

    }catch(error){
      debugPrint("Error with SignIn Anonymously: $error");
    }
  }

  //Get the Current User
  User? getCurrentUser() {
    return _auth.currentUser;
  }
}