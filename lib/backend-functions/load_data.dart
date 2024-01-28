import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error please send us a feedback'),
          ),
        );
        return [];
      }
    } catch (error) {
      // Handle errors
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error please send us a feedback'),
          ),
        );
      return [];
    }
  } else {
    // Handle case when user is null
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error please send us a feedback'),
      ),
    );
    return [];
  }
}

Future loadProfilePicture(context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (snapshot.exists) {
        final data = snapshot.data();
        return data?['profilePicture'];
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error please send us a feedback'),
          ),
        );
        return '';
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error please send us a feedback'),
        ),
      ); 
      return '';   
    }
  }

// Load seller information
Future<List<Map<String, dynamic>>> loadSellerInfo(uid, context) async {
  try {
    // Fetch seller data from Firestore
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    // Check if the document exists
    if (documentSnapshot.exists) {
      // Return a list containing seller data
      return [documentSnapshot.data()!];
    } else {
      // Handle case when document does not exist
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error please send us a feedback'),
        ),
      );
      return [];
    }
  } catch (error) {
    // Handle errors
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error please send us a feedback'),
      ),
    );
    return [];
  }
}

// Load user postes
Future<List<Map<String, dynamic>>> loadUserPostes() async {
  List<Map<String, dynamic>> result = [];

  // Fetch products
  QuerySnapshot productsSnapshot = await FirebaseFirestore.instance.collection('products').get();
  List<DocumentSnapshot> products = productsSnapshot.docs;

  // Fetch categories
  Map<String, String> categoryMap = {};
  QuerySnapshot categoriesSnapshot = await FirebaseFirestore.instance.collection('productCategory').get();
  for (var categoryDoc in categoriesSnapshot.docs) {
    categoryMap[categoryDoc.id] = categoryDoc['name'];
  }

  // Combine product and category information
  for (var product in products) {
    Map<String, dynamic> productData = product.data() as Map<String, dynamic>;
    String categoryId = productData['category'];

    // Check if category exists
    if (categoryMap.containsKey(categoryId)) {
      productData['categoryName'] = categoryMap[categoryId];
      result.add(productData);
    }
  }

  return result;
}


// load poste information
Future<List<Map<String, dynamic>>> loadPosteInfo(String productID, context) async {
  List<Map<String, dynamic>> result = [];

  try {
    // Fetch product data from Firestore
    DocumentSnapshot<Map<String, dynamic>> productSnapshot =
      await FirebaseFirestore.instance.collection('products')
        .doc(productID)
        .get();

    if (productSnapshot.exists) {
      // Fetch category data using the category ID from the product
      String categoryID = productSnapshot.data()?['category'];
      DocumentSnapshot<Map<String, dynamic>> categorySnapshot =
          await FirebaseFirestore.instance.collection('productCategory').doc(categoryID).get();

      // Add product and category data to the result list
      result.add(productSnapshot.data()!);
      result.add(categorySnapshot.data()!);

      return result;
    } else {
      // Handle case when product document does not exist
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error loading product. Please send us feedback.'),
        ),
      );
      return [];
    }
  } catch (error) {
    // Handle errors
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error please send us a feedback'),
      ),
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error please send us a feedback'),
      ),
    );
    return [];
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
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error please send us a feedback'),
              ),
            );
            return null;
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error please send us a feedback'),
            ),
          );
          return null;
        }
      }).where((item) => item != null).toList().cast<Map<String, dynamic>>();
    } catch (error) {
      // Handle any errors that may occur during the process
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error please send us a feedback'),
        ),
      );
    }
  } else {
    // Handle case when user is null
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error please send us a feedback'),
      ),
    );
  }
  return userCart;
}

// Function to get user shipping address
Future<String> getUserShippingAddress(context) async {
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error please send us a feedback'),
          ),
        );
        return 'User document does not exist.';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error please send us a feedback'),
        ),
      );
      return 'Error getting user shipping address.';
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error please send us a feedback'),
      ),
    );
    return 'User not authenticated.';
  }
}


// Function to get user phone number
Future<String> getUserPhoneNumber(context) async {
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error please send us a feedback'),
          ),
        );
        return 'User document does not exist.';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error please send us a feedback'),
        ),
      );
      return 'Error getting user phone number.';
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error please send us a feedback'),
      ),
    );
    return 'User not authenticated.';
  }
}