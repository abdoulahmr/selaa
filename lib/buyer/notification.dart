import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:selaa/seller/home_seller.dart';
import 'package:selaa/seller/order.dart';
import 'package:selaa/seller/user_page.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<Widget> _pages = [
    const HomeSeller(),
    const UserPage(),
    const NotificationPage(),
    const ListOrderPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      bottomNavigationBar:Container(
        decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey, width: 0.5),
            ),
          ),
        child: FloatingNavbar(
          selectedItemColor: const Color(0xFF415B5B),
          unselectedItemColor: const Color(0xFFCCE6E6),
          backgroundColor: Colors.white,
          onTap: (int val) {
            if(val != 1){
              Navigator.push(context,MaterialPageRoute(builder: (context) => _pages[val]));
            }
          },
          currentIndex: 2,
          items: [
            FloatingNavbarItem(icon: Icons.home, title: 'Home'),
            FloatingNavbarItem(icon: Icons.account_circle, title: 'Profile'),
            FloatingNavbarItem(icon: Icons.notifications, title: 'Notifications'),
            FloatingNavbarItem(icon: Icons.all_inbox, title: 'Orders'),
          ],
        ),
      ),
    );
  }
}
