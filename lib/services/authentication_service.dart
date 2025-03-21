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

  //Create User with Email & Password
  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      debugPrint(
        "Error with Creating New User: ${mapFirebaseAuthExceptionCodes(errorCode: error.code)},",
      );
      throw Exception(mapFirebaseAuthExceptionCodes(errorCode: error.code));
    } catch (error) {
      debugPrint("Error Creating User: $error");
    }
  }

  //Sign in with Email and Password
  Future<void> singInUser({required email, required password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      debugPrint(
        "Error with SignIn New User: ${mapFirebaseAuthExceptionCodes(errorCode: error.code)}",
      );
      throw Exception(mapFirebaseAuthExceptionCodes(errorCode: error.code));
    } catch (error) {
      debugPrint("Error SignIn User: $error");
    }
  }
}
