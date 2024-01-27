import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter/material.dart';
import 'package:selaa/register/redirect_login.dart';
import 'package:selaa/seller/user_page.dart';
import 'register/login.dart';
import 'seller/edit_profile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

// Function to register a user with email and password (bute)
Future<User?> registerWithEmailPassword({
  required email,
  required password,
  required firstname,
  required lastname,
  required accountType,
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
        'username': '',
        'bio': '',
        'profilePicture': '',
        'phoneNumber': '',
        'address': '',
        'shippingAdress': '',
        'accountType': accountType,
        'balance': 0,
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password should be at least 8 characters'),
        ),
      );
    } else if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('The account already exists for that email.'),
        ),
      );
    }
  } catch (e) {
    // Handle other exceptions
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Error',
      text: 'Error creating account please send us a feedback',
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
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Loading',
      text: 'Please wait...',
    );
    // Sign in with email and password
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = userCredential.user;
    if (user != null && !user.emailVerified) {
      Navigator.pop(context);
      // Show info alert if email is not verified
      QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        title: 'Confirm Email',
        text: 'Please confirm your email address!',
      );
    } else {
      // Navigate to home screen after successful login
      Navigator.push(context, MaterialPageRoute(builder: (context) => const RedirectLogin()));
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
        text: 'Error logging in please send us a feedback',
      );
    }
  } catch (e) {
    // Handle other exceptions
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Error',
      text: 'Error logging in please send us a feedback',
    );
  }
  return null;
}

// Function to get account type (buyer,seller)
Future<String?> getAccountType() async {
  try {
    // Get the current user from FirebaseAuth
    User? user = FirebaseAuth.instance.currentUser;
    // Retrieve the document snapshot from Firestore using the user's UID
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
    // Check if the document exists in the 'users' collection
    if (documentSnapshot.exists) {
      // Return the 'accountType' field from the document
      return documentSnapshot.data()!['accountType'];
    } else {
      // Return null if the document does not exist
      return null;
    }
  } catch (e) {
    // Handle exceptions and return null in case of an error
    return null;
  }
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
      text: 'Error sending password reset email please send us a feedback',
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
      text: 'Error signing out please send us a feedback',
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
Future<void> addProduct(
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
        FirebaseFirestore.instance.collection('products');
    // Reference to the Firebase Storage bucket
    Reference storageRef =
        FirebaseStorage.instance.ref().child('poste_images');
    // List to store image download URLs
    List<String> imageUrls = [];
    // Upload each image to Firebase Storage
    for (XFile image in images) {
      File file = File(image.path);
      String imageName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference imageRef = storageRef.child(imageName);
      await imageRef.putFile(file);
      String imageUrl = await imageRef.getDownloadURL();
      imageUrls.add(imageUrl);
    }
    // Create a map with post data
    Map<String, dynamic> postData = {
      'sellerID': FirebaseAuth.instance.currentUser!.uid,
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
Future<List<Map<String, dynamic>>> loadUserInfo(context) async {
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
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Error',
          text: 'Error loading user information please send us a feedback',
        );
        return [];
      }
    } catch (error) {
      // Handle errors
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Error loading user information please send us a feedback',
      );
      return [];
    }
  } else {
    // Handle case when user is null
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Error',
      text: 'User is not authenticated.',
    );
    return [];
  }
}

// load seller information
Future<List<Map<String, dynamic>>> loadSellerInfo(uid,context) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .get();
    if (documentSnapshot.exists) {
      // Return a list containing user data
      return [documentSnapshot.data()!];
    } else {
      // Handle case when document does not exist
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Error loading seller information please send us a feedback',
      );
      return [];
    }
  } catch (error) {
    // Handle errors
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Error',
      text: 'Error loading seller information please send us a feedback',
    );
    return [];
  }
}

// Load user postes
Future<List<Map<String, dynamic>>> loadUserPostes(context) async {
  User? user = FirebaseAuth.instance.currentUser;
  List<Map<String, dynamic>> userPostes = [];

  if (user != null) {
    try {
      // Fetch user posts from Firestore
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('products')
              .where('sellerID', isEqualTo: user.uid)
              .get();
      // Extract the data from the documents in the query snapshot
      userPostes = querySnapshot.docs.map((doc) => doc.data()).toList();
    } catch (error) {
      // Handle any errors that may occur during the process
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Error loading products please send us a feedback',
      );
      return [];
    }
  } else {
    // Handle case when user is null
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Error',
      text: 'User is not authenticated.',
    );
  }
  return userPostes;
}

// load poste information
Future<List<Map<String, dynamic>>> loadPosteInfo(String productID, context) async {
  try {
    // Fetch poste data from Firestore
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance
            .collection('products')
            .doc(productID)
            .get();

    if (documentSnapshot.exists) {
      // Return a list containing poste data
      return [documentSnapshot.data()!];
    } else {
      // Handle case when document does not exist
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Error loading products please send us a feedback',
      );
      return [];
    }
  } catch (error) {
    // Handle errors
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Error',
      text: 'Error loading products please send us a feedback',
    );
    return [];
  }
}

// Load all postes
Future<List<Map<String, dynamic>>> loadAllPostes(context) async {
  try {
    // Fetch poste data from Firestore
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('products')
            .get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  } catch (error) {
    // Handle errors
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Error',
      text: 'Error loading products please send us a feedback',
    );
    return [];
  }
}

// Function to delete poste and associated images
Future<void> deletePoste(String productID, context) async {
  try {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Loading',
      text: 'Please wait...',
    );
    // Retrieve associated image URLs from Firestore
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance.collection('user').doc(productID).get();
    if (documentSnapshot.exists) {
      final List<dynamic> imageUrls = documentSnapshot.data()?['imageUrls'] ?? [];
      // Delete associated images from Firebase Storage
      for (final String imageUrl in imageUrls) {
        final Reference imageRef = FirebaseStorage.instance.refFromURL(imageUrl);
        await imageRef.delete();
      }
    }
    // Delete poste from Firestore
    await FirebaseFirestore.instance.collection('user').doc(productID).delete();
    Navigator.pop(context);
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Success',
      text: 'Post deleted successfully!',
    );
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserPage()),
    );
  } catch (error) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Error',
      text: 'Error deleting post please send us a feedback',
    );
  }
}

// add to cart
Future<void> addItemToCart(String sellerID, String productID, int quantityValue, String price, context) async {
  User? user = FirebaseAuth.instance.currentUser;
  int totalPrice = int.parse(price) * quantityValue;
  if (user != null) {
    try {
      // Check if the product already exists in the user's cart
      QuerySnapshot<Map<String, dynamic>> existingProductsSnapshot =
          await FirebaseFirestore.instance
              .collection('cart')
              .where('buyerID', isEqualTo: user.uid)
              .where('productID', isEqualTo: productID)
              .get();
      List<DocumentSnapshot<Map<String, dynamic>>> existingProducts = existingProductsSnapshot.docs;
      if (existingProducts.isNotEmpty) {
        // If the product exists, update the quantity
        await FirebaseFirestore.instance
            .collection('cart')
            .doc(existingProducts[0].id)
            .update({
          'quantity': existingProducts[0]['quantity'] + quantityValue,
          'totalPrice': totalPrice + (existingProducts[0]['quantity'] * int.parse(price)),
        });
      } else {
        // If the product does not exist, add a new item
        await FirebaseFirestore.instance.collection('cart').doc().set({
          'sellerID': sellerID,
          'buyerID': user.uid,
          'productID': productID,
          'quantity': quantityValue,
          'totalPrice': totalPrice,
        });
      }
      Navigator.pop(context);
    } catch (error) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Error adding to cart please send us a feedback',
      );
    }
  }
}

// get items from cart
Future<List<Map<String, dynamic>>> loadCartItems(context) async {
  User? user = FirebaseAuth.instance.currentUser;
  List<Map<String, dynamic>> userCart = [];
  if (user != null) {
    try {
      // Fetch user cart items from Firestore
      QuerySnapshot<Map<String, dynamic>> cartSnapshot =
          await FirebaseFirestore.instance
              .collection('cart')
              .where('buyerID', isEqualTo: user.uid)
              .get();
      List<Map<String, dynamic>> cartItems =
          cartSnapshot.docs.map((doc) => doc.data()).toList();
      // Fetch products with the same productID from the postes collection
      List productIDs =
          cartItems.map((item) => item['productID']).toList();
      QuerySnapshot<Map<String, dynamic>> productsSnapshot =
          await FirebaseFirestore.instance
              .collection('products')
              .where('productID', whereIn: productIDs)
              .get();
      // Extract the data from the documents in the products snapshot
      userCart = productsSnapshot.docs.map((doc) {
        if (doc.exists) {
          // Find the corresponding cart item for the product
          Map<String, dynamic>? cartItem = cartItems.firstWhere(
            (item) => item['productID'] == doc.id,
            orElse: () => {},
          );
          if (cartItem.isNotEmpty) {
            // Include both product details and quantity
            return {
              'productDetails': doc.data(),
              'quantity': cartItem['quantity'],
            };
          } else {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.error,
              title: 'Error',
              text: 'Error loading cart items please send us a feedback',
            );
            return null;
          }
        } else {
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Error',
            text: 'Error loading cart items please send us a feedback',
          );
          return null;
        }
      }).where((item) => item != null).toList().cast<Map<String, dynamic>>();
    } catch (error) {
      // Handle any errors that may occur during the process
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Error loading cart items please send us a feedback',
      );
    }
  } else {
    // Handle case when user is null
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Error',
      text: 'User is not authenticated.',
    );
  }
  return userCart;
}

// calculate total price
Future<int> calculateTotalPrice(context) async {
  User? user = FirebaseAuth.instance.currentUser;
  int total = 0;
  if (user != null) {
    try {
      // Fetch user cart items from Firestore
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('cart')
              .where('buyerID', isEqualTo: user.uid)
              .get();
      // Extract the data from the documents in the query snapshot
      List<Map<String, dynamic>> userCart =
          querySnapshot.docs.map((doc) => doc.data()).toList();
      // Calculate the total price
      for (int i = 0; i < userCart.length; i++) {
        // Ensure that the 'totalPrice' field is present and non-null
        if (userCart[i]['totalPrice'] != null) {
          total += int.parse(userCart[i]['totalPrice'].toString());
        }
      }
    } catch (error) {
      // Handle any errors that may occur during the process
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Error calculating total price please send us a feedback',
      );
    }
  } else {
    // Handle case when the user is null
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Error',
      text: 'User is not authenticated.',
    );
  }
  return total;
}

// Function to delete item from cart
Future<void> deleteItemFromCart(String productID, context) async {
  User? user = FirebaseAuth.instance.currentUser;
  try {
    // Fetch items to delete from Firestore
    QuerySnapshot<Map<String, dynamic>> itemsToDeleteSnapshot = await FirebaseFirestore.instance
        .collection('cart')
        .where('productID', isEqualTo: productID)
        .where('buyerID', isEqualTo: user!.uid)
        .get();
    // Iterate through the documents and delete each one
    for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot in itemsToDeleteSnapshot.docs) {
      await documentSnapshot.reference.delete();
    }
  } catch (error) {
    // Handle errors
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Error',
      text: 'Error deleting item from cart please send us a feedback',
    );
  }
}

// Function to update user email
Future <void> updateEmail(String password, String email,context) async {
  User? user = FirebaseAuth.instance.currentUser;
  AuthCredential credential = EmailAuthProvider.credential(email: user!.email!, password: password);
  try {
    await user.reauthenticateWithCredential(credential);
  } catch (e) {
    // Handle reauthentication failure
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Error',
      text: 'Reauthentication failed please send us a feedback',
    );
  }
  // Update email address
  try {
    await user.updateEmail(email);
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Success',
      text: 'Email updated successfully! Please login again.',
    );
    signOut(context);
  } catch (e) {
    // Handle email update failure
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Error',
      text: 'Email update failed please send us a feedback',
    );
  }
}

// Function to get user shipping address
Future<String> getUserShippingAddress() async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (documentSnapshot.exists) {
        String shippingAddress = (documentSnapshot.data() as Map<String, dynamic>)['shippingAddress'] ?? '';
        return shippingAddress;
      } else {
        return 'User document does not exist.';
      }
    } catch (e) {
      return 'Error getting user shipping address.';
    }
  } else {
    return 'User not authenticated.';
  }
}

// Function to update user shipping address
Future<void> updateUserShippingAddress(String shippingAddress, context) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'shippingAddress': shippingAddress});
      await QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'Shipping address updated successfully!',
      );
      Navigator.pop(context);
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Error updating shipping address please send us a feedback',
      );
    }
  } else {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Error',
      text: 'User is not authenticated.',
    );
  }
}

// Function to get user phone number
Future<String> getUserPhoneNumber() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (documentSnapshot.exists) {
        String phoneNumber = (documentSnapshot.data() as Map<String, dynamic>)['phoneNumber'] ?? '';
        return phoneNumber;
      } else {
        return 'User document does not exist.';
      }
    } catch (e) {
      return 'Error getting user phone number.';
    }
  } else {
    return 'User not authenticated.';
  }
}

// Function to update user phone number
Future<void> updateUserPhoneNumber(String phoneNumber, context) async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null && phoneNumber.isNotEmpty) {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'phoneNumber': phoneNumber});

      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Success',
        text: 'Phone number updated successfully!',
      );

      // Wait for a short duration before popping the context
      await Future.delayed(const Duration(seconds: 2));

      Navigator.pop(context);
    } catch (e) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Error updating phone number. Please send us feedback.',
      );
    }
  } else {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Error',
      text: 'Invalid phone number. Please provide a valid phone number.',
    );
  }
}

// Function to pass an order
