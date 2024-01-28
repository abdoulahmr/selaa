import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product {
  final String category;
  final String title;
  final String description;
  final double price;
  final String sellerID;
  final List<String> imageUrls;
  final String location;
  final String type;
  final DateTime createdAt;

  Product({
    required this.category,
    required this.title,
    required this.description,
    required this.price,
    required this.sellerID,
    required this.imageUrls,
    required this.location,
    required this.type,
    required this.createdAt,
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final CollectionReference productsCollection =
      FirebaseFirestore.instance.collection('products');

  // Add test products with automatically generated document IDs
  final DocumentReference product1Ref = await productsCollection.add({
    'category': 'VOJpkzoKEYjY7l3Ke1hU', // this is a category ID located in the categories collection
    'title': 'LAINE MINERAL URSA VENT EN PALETTE',
    'description': 'Laine MINERAL 45 mm \n disponible en palette',
    'price': 1000,
    'sellerID': '6ol7AoVMMdVqQQMdgWgQF4l7FCG2',
    'imageUrls': [
      'https://someurl.com/image1.jpg',
    ],
    'location': 'Blida - Ouled Selama',
    'createdAt': FieldValue.serverTimestamp(),
  });

  final DocumentReference product2Ref = await productsCollection.add({
    'category': 'VOJpkzoKEYjY7l3Ke1hU',
    'title': 'Laine De Verre Minéral Volcalis COMFORT 50mm 15.84m',
    'description': 'Laine de VERRE Volcalis 50mm 15.84m\nVentes en Palettes ( 24 rouleaux )',
    'price': 5000,
    'sellerID': '6ol7AoVMMdVqQQMdgWgQF4l7FCG2',
    'imageUrls': [
      'https://firebasestorage.googleapis.com/v0/b/selaa-93e88.appspot.com/o/products-pictures%2FYPP9JqkPuXXhEaR0kVMkeN0QLApdshGJ4GJewNyG.jpg?alt=media&token=49ce7c4c-6696-4849-abb3-a265baacd8ce', 
      'https://firebasestorage.googleapis.com/v0/b/selaa-93e88.appspot.com/o/products-pictures%2FmCvQ9Ye1a6pJEJTqzouVEMMxlAezC0boWPbeX0dj.jpg?alt=media&token=0fab6bc1-b842-4c04-9952-f48e628e4f35',
      'https://firebasestorage.googleapis.com/v0/b/selaa-93e88.appspot.com/o/products-pictures%2Fmh8bYsW6bYf0Dig5k3939pKb7dDTlPSDCxUBtL65.jpg?alt=media&token=4c50de04-7c95-4538-8cac-5a336d93c3c1'
    ],
    'location': 'Blida - Ouled Selama',
    'createdAt': FieldValue.serverTimestamp(),
  });

  // Add more products with automatically generated document IDs as needed

  print('Test products added to the database.');

  // Get the automatically generated document IDs and update the products
  final String product1ID = product1Ref.id;
  final String product2ID = product2Ref.id;

  await product1Ref.update({'productID': product1ID});
  await product2Ref.update({'productID': product2ID});
}
