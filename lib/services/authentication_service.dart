import 'package:basic_firebase_authentication/exceptions/authentication_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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

  //SignIn with Google
  Future<void> signInWithGoogle() async {
    try {
      //Trigger the Google SignIn Process
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return;
      }

      //Obtain the Google SignIn Authentication Object
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;

      //Create a New Credential
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      //SignIn to Firebase with the Google Auth Credential
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (error) {
      debugPrint(
        "Error with Google SignIn: ${mapFirebaseAuthExceptionCodes(errorCode: error.code)}",
      );
      throw Exception(mapFirebaseAuthExceptionCodes(errorCode: error.code));
    } catch (error) {
      debugPrint("Error SignIn with Google: $error");
    }
  }
}
