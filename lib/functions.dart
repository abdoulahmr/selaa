import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter/material.dart';
import 'package:selaa/user/user_page.dart';
import 'register/login.dart';
import 'user/home.dart';
import 'user/edit_profile.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';

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
Future<void> updateUserInfo(
  context,
  String username,
  String firstname,
  String lastname,
  String bio,
  String address,
  ) async {
  try {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
            'username': username,
            'firstname': firstname,
            'lastname': lastname,
            'bio': bio,
            'address': address,
          });
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'User information updated successfully!',
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const EditProfile()),
      );
    }
  } catch (error) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Error',
      text: 'Error updating user information: $error',
    );
  }
}

// function to add a poste
Future<void> addPost(
  String category,
  String type,
  String selling,
  String price,
  String location,
  String description,
  List<XFile> images,
  context,
) async {
  try {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Loading',
      text: 'Please wait...',
    );
    // Reference to the Firestore collection
    CollectionReference<Map<String, dynamic>> postsCollection =
        FirebaseFirestore.instance.collection('postes');
    // Reference to the Firebase Storage bucket
    firebase_storage.Reference storageRef =
        firebase_storage.FirebaseStorage.instance.ref().child('poste_images');
    // List to store image download URLs
    List<String> imageUrls = [];
    // Upload each image to Firebase Storage
    for (XFile image in images) {
      File file = File(image.path);
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      firebase_storage.Reference imageRef = storageRef.child(imageName);
      await imageRef.putFile(file);
      String imageUrl = await imageRef.getDownloadURL();
      imageUrls.add(imageUrl);
    }
    // Create a map with post data
    Map<String, dynamic> postData = {
      'userId': FirebaseAuth.instance.currentUser!.uid,
      'category': category,
      'type': type,
      'title': selling,
      'price': price,
      'location': location,
      'description': description,
      'imageUrls': imageUrls,
      'createdAt': DateTime.now(),
    };
    // Add the post data to Firestore and get the document reference
    DocumentReference<Map<String, dynamic>> documentReference =
        await postsCollection.add(postData);
    // Get the productID (document ID) from the reference
    String productID = documentReference.id;
    // Update the document with the productID
    await documentReference.update({'productID': productID});
    // Dismiss loading alert
    Navigator.pop(context);
    // Show success alert
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Success',
      text: 'Post added successfully!',
    );
    // Navigate to home screen after adding post
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserPage()),
    );
  } catch (error) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Error',
      text: 'Error adding post: $error',
    );
  }
}

// load user information
Future<List<Map<String, dynamic>>> loadUserInfo() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (documentSnapshot.exists) {
        // Return a list containing user data
        return [documentSnapshot.data()!];
      } else {
        // Handle case when document does not exist
        return [];
      }
    } catch (error) {
      // Handle errors
      print("Error loading user information: $error");
      return [];
    }
  } else {
    // Handle case when user is null
    print("User is null");
    return [];
  }
}

// Load user postes
Future<List<Map<String, dynamic>>> loadUserPostes() async {
  User? user = FirebaseAuth.instance.currentUser;
  List<Map<String, dynamic>> userPostes = [];

  if (user != null) {
    try {
      // Fetch user posts from Firestore
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('postes')
              .where('userId', isEqualTo: user.uid)
              .get();

      // Extract the data from the documents in the query snapshot
      userPostes = querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (error) {
      // Handle any errors that may occur during the process
      print('Error loading user postes: $error');
    }
  } else {
    // Handle case when user is null
    print('User is null');
  }

  return userPostes;
}

// load poste information
Future<List<Map<String, dynamic>>> loadPosteInfo(String productID) async {
  List<Map<String, dynamic>> posteInfo = [];

  try {
    // Fetch poste data from Firestore
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('postes')
            .doc(productID)
            .get();

    if (documentSnapshot.exists) {
      // Return a list containing poste data
      return [documentSnapshot.data()!];
    } else {
      // Handle case when document does not exist
      return [];
    }
  } catch (error) {
    // Handle errors
    print("Error loading poste information: $error");
    return [];
  }
}