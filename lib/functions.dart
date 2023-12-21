import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter/material.dart';
import 'register/login.dart';
import 'user/home.dart';

// Function to register a user with email and password
Future<User?> registerWithEmailPassword({
  required email,
  required password,
  required firstname,
  required lastname,
  required type,
  context,
}) async {
  // Show loading alert while registering
  QuickAlert.show(
    context: context,
    type: QuickAlertType.loading,
    title: 'Loading',
    text: 'Please wait...',
  );
  try {
    // Create user with email and password
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = userCredential.user;
    if (user != null) {
      // Save additional user data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'password': password,
        'profilePicture': '',
        'phoneNumber': '',
        'address': '',
      });
    }
    // Dismiss loading alert
    Navigator.pop(context);
    // Show success alert
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Success',
      text: 'Account created successfully!',
    );
    if (user != null) {
      // Send email verification and navigate to login screen
      await user.sendEmailVerification();
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
  } on FirebaseAuthException catch (e) {
    // Handle FirebaseAuth exceptions
    if (e.code == 'weak-password') {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'The password provided is too weak.',
      );
    } else if (e.code == 'email-already-in-use') {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'The account already exists for that email.',
      );
    }
  } catch (e) {
    // Handle other exceptions
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Error',
      text: e.toString(),
    );
  }
  return null;
}

// Function to log in with email and password
Future<User?> loginWithEmailPassword(
  String email,
  String password,
  context,
) async {
  try {
    // Sign in with email and password
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = userCredential.user;
    if (user != null && !user.emailVerified) {
      // Show info alert if email is not verified
      QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        title: 'Confirm Email',
        text: 'Please confirm your email address!',
      );
    } else {
      // Navigate to home screen after successful login
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
    }
  } on FirebaseAuthException catch (e) {
    // Handle FirebaseAuth exceptions
    if (e.code == 'user-not-found') {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'No user found for that email.',
      );
    } else if (e.code == 'wrong-password') {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Wrong password provided for that user.',
      );
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'FirebaseAuthException: ${e.code}',
      );
    }
  } catch (e) {
    // Handle other exceptions
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Error',
      text: e.toString(),
    );
  }
  return null;
}

// Function to reset password
Future<void> resetPassword(String email, context) async {
  try {
    // Send password reset email
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: email,
    );
    // Show success alert
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Success',
      text: 'Password reset email sent to $email',
    );
    // Navigate to home screen after changing password
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  } catch (e) {
    // Handle errors
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Error',
      text: 'Error sending password reset email: $e',
    );
  }
}

// Function to sign out
Future<void> signOut(context) async {
  try {
    // Sign out user
    await FirebaseAuth.instance.signOut();
    // Navigate to login screen after sign out
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  } catch (e) {
    // Handle errors
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Error',
      text: e.toString(),
    );
  }
}

// Function to update user profile
Future <void> updateUserInfo(context) async {

}