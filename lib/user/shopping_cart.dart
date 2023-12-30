import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaa/functions.dart';
import 'package:selaa/user/home.dart';
import 'package:selaa/user/notification.dart';
import 'package:selaa/user/user_page.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<Map<String, dynamic>> shoppingCart = [];
  int totalPrice = 0;
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const Home(),
    const UserPage(),
    const NotificationPage(),
    const ShoppingCart(),
  ];
  
  @override
  void initState() {
    super.initState();
    loadCartItems().then((List<Map<String, dynamic>> items) {
      setState(() {
        shoppingCart = items;
      });
    });
    calculateTotalPrice().then((int price) {
      setState(() {
        totalPrice = price;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 50),
                child: const Text(
                  "Shopping Cart",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                )
            ),
            Container(
              
            )
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(0xFFCCE6E6),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          selectedItemColor: const Color(0xFF008080),
          unselectedItemColor: const Color(0xFF008080),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => _pages[index]),
            );
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 35,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
                size: 35,
              ),
              label: "Profile",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
                size: 35,
              ),
              label: "Notification",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_cart,
                size: 35,
              ),
              label: "Cart",
            ),
          ],
        ),
      ),
    );
  }
}
