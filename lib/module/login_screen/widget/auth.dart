import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/routes/app_routes_name.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
//end

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void showCustomSnackBar(
      BuildContext context, String title, String message, ContentType type) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: type,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> register(
      BuildContext context, String name, String email, String password) async {
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      showCustomSnackBar(
          context, "Error", "Please fill all fields", ContentType.failure);
      return;
    }

    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      await credential.user?.updateDisplayName(name);
      showCustomSnackBar(context, "Success", "Account created successfully!",
          ContentType.success);
      Navigator.pushReplacementNamed(context, RoutesName.login);
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred. Please try again.";
      if (e.code == 'weak-password') {
        errorMessage = "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        errorMessage = "The account already exists for that email.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "The email address is badly formatted.";
      }
      showCustomSnackBar(context, "Error", errorMessage, ContentType.failure);
    }
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      showCustomSnackBar(context, "Error", "Please enter email and password",
          ContentType.failure);
      return;
    }
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      showCustomSnackBar(
          context, "Success", "Logged in successfully!", ContentType.success);
      Navigator.pushReplacementNamed(context, RoutesName.layout);
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred. Please try again.";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found for this email.";
      } else if (e.code == 'wrong-password') {
        errorMessage = "Wrong password provided for that user.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "The email address is badly formatted.";
      }
      showCustomSnackBar(context, "Error", errorMessage, ContentType.failure);
    }
  }

  Future<void> resetPassword(BuildContext context, String email) async {
    if (email.isEmpty) {
      showCustomSnackBar(
          context, "Error", "Please enter your email", ContentType.failure);
      return;
    }
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      showCustomSnackBar(context, "Success", "Password reset email sent!",
          ContentType.success);
      Navigator.pushReplacementNamed(context, RoutesName.login);
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An error occurred. Please try again.";
      if (e.code == 'user-not-found') {
        errorMessage = "No user found for this email.";
      } else if (e.code == 'invalid-email') {
        errorMessage = "The email address is badly formatted.";
      }
      showCustomSnackBar(context, "Error", errorMessage, ContentType.failure);
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        showCustomSnackBar(
            context, "Error", "Google sign-in canceled.", ContentType.warning);
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _auth.signInWithCredential(credential);
      showCustomSnackBar(context, "Success",
          "Signed in with Google successfully!", ContentType.success);
      Navigator.pushReplacementNamed(context, RoutesName.layout);
    } catch (e) {
      showCustomSnackBar(
          context, "Error", "Google sign-in failed: $e", ContentType.failure);
    }
  }
}
