import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quickalert/quickalert.dart';
import 'package:flutter/material.dart';
import 'package:selaa/backend-functions/load_data.dart';
import 'package:selaa/buyer/my_orders.dart';
import 'package:selaa/seller/user_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error adding post: $error code: 20'),
      ),
    );
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error deleting post please send us a feedback  code: 21'),
      ),
    );
  }
}

// add to cart
Future<void> addItemToCart(
  String sellerID, 
  String productID, 
  int quantityValue, 
  String price, 
  context
) async {

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
          'totalPrice': totalPrice + (existingProducts[0]['quantity'] * price),
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error adding to cart please send us a feedback code: 22'),
        ),
      );
    }
  }
}


// calculate total price
Future<double> calculateTotalPrice(context) async {
  User? user = FirebaseAuth.instance.currentUser;
  double total = 0;
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error please send us a feedback  code: 23'),
        ),
      );
    }
  } else {
    // Handle case when the user is null
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error please send us a feedback  code: 24'),
      ),
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
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error please send us a feedback  code: 25'),
      ),
    );
  }
}

// pass an order
Future<void> saveOrder(
  String productName,
  String productID,
  String sellerID,
  String orderID,
  int quantity,
  double unitPrice,
  String location,
  String date,
  context
) async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    // Handle the case where the user is null (not signed in)
    return;
  }
  try {
    String shippingAddress = await loadUserShippingAddress(context);
    if (shippingAddress.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add a shipping address before placing an order.'),
        ),
      );
      return;
    }

    // Save order for the buyer
    await FirebaseFirestore.instance.collection('users')
      .doc(user.uid)
      .collection("orders")
      .add({
        "orderId": orderID,
        "productId": productID,
        "productName": productName,
        "sellerID": sellerID,
        "buyerID": user.uid,
        "quantity": quantity,
        "unitPrice": unitPrice,
        "date": date,
        "location": location,
        "status": "pending"
      });

    // Save order for the seller
    await FirebaseFirestore.instance.collection('users')
      .doc(sellerID)
      .collection("orders")
      .add({
        "orderId": orderID,
        "productId": productID,
        "productName": productName,
        "sellerID": sellerID,
        "buyerID": user.uid,
        "quantity": quantity,
        "unitPrice": unitPrice,
        "date": date,
        "location": location,
        "status": "pending"
      });

    deleteItemFromCart(productID, context);
    double orderAmount = unitPrice * quantity;
    updateBalance(orderAmount, context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Order passed successfully'),
      ),
    );
    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyOrdersPage()));
  } catch (error) {
    // Handle the error
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error please send us a feedback  code: 26'),
      ),
    );
  }
}

// Function to update the user's balance
Future<void> updateBalance(double orderAmount, context) async {
  User? user = FirebaseAuth.instance.currentUser;
  try {
    // Fetch the current balance
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

    if (userSnapshot.exists) {
      // Update the balance by subtracting the order amount
      double currentBalance = userSnapshot['balance'].toDouble();
      double newBalance = currentBalance - orderAmount;

      // Save the updated balance to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'balance': newBalance});
    }
  } catch (error) {
    // Handle the error
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error please send us a feedback  code: 27'),
      ),
    );
  }
}
