import 'package:basic_firebase_authentication/exceptions/authentication_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //SignIn Anonymously
  Future<void> singInAnonymouslyWithExceptions() async {
    try {
      final UserCredential userCredential = await _auth.signInAnonymously();
      final user = userCredential.user;

      if (user != null) {
        debugPrint("SignIn Anonymously: ${user.uid}");
      }
    } on FirebaseAuthException catch (error) {
      debugPrint(
        "Error SignIn Anonymously: ${mapFirebaseAuthExceptionCodes(errorCode: error.code)}",
      );
      throw Exception(mapFirebaseAuthExceptionCodes(errorCode: error.code));
    } catch (error) {
      debugPrint("An Unexpected Error Occurred: $error");
    }
  }

  //Get the Current User
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //SignOut
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (error) {
      debugPrint(
        "Error SignOut Anonymously: ${mapFirebaseAuthExceptionCodes(errorCode: error.code)}",
      );
      throw Exception(mapFirebaseAuthExceptionCodes(errorCode: error.code));
    } catch (error) {
      debugPrint("Error Logging Out: $error");
    }
  }
}
