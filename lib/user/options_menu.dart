import 'package:flutter/material.dart';
import 'package:selaa/user/home.dart';
import 'package:selaa/user/settings_list.dart';
import 'package:selaa/user/user_page.dart';
import '../functions.dart';

class OptionsMenu extends StatelessWidget {
  const OptionsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 50),
              height: MediaQuery.of(context).size.height * 0.1,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Row(
                  children: <Widget>[
                    SizedBox(width: 40),
                    Icon(
                      Icons.home_outlined,
                      size: 40,
                      color: Color(0xFF008080),
                    ),
                    SizedBox(width: 40),
                    Text(
                      "Home",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              height: MediaQuery.of(context).size.height * 0.1,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Row(
                  children: <Widget>[
                    SizedBox(width: 40),
                    Icon(
                      Icons.account_circle_outlined,
                      size: 40,
                      color: Color(0xFF008080),
                    ),
                    SizedBox(width: 40),
                    Text(
                      "Profile",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsList()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Row(
                  children: <Widget>[
                    SizedBox(width: 40),
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 40,
                      color: Color(0xFF008080),
                    ),
                    SizedBox(width: 40),
                    Text(
                      "Balance",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsList()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Row(
                  children: <Widget>[
                    SizedBox(width: 40),
                    Icon(
                      Icons.settings_outlined,
                      size: 40,
                      color: Color(0xFF008080),
                    ),
                    SizedBox(width: 40),
                    Text(
                      "Settings",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Row(
                  children: <Widget>[
                    SizedBox(width: 40),
                    Icon(
                      Icons.notifications_outlined,
                      size: 40,
                      color: Color(0xFF008080),
                    ),
                    SizedBox(width: 40),
                    Text(
                      "Notifications",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Row(
                  children: <Widget>[
                    SizedBox(width: 40),
                    Icon(
                      Icons.delivery_dining_outlined,
                      size: 40,
                      color: Color(0xFF008080),
                    ),
                    SizedBox(width: 40),
                    Text(
                      "Delivery",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserPage()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Row(
                  children: <Widget>[
                    SizedBox(width: 40),
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 40,
                      color: Color(0xFF008080),
                    ),
                    SizedBox(width: 40),
                    Text(
                      "Order",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50),
              height: MediaQuery.of(context).size.height * 0.1,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Row(
                  children: <Widget>[
                    SizedBox(width: 40),
                    Icon(
                      Icons.language_outlined,
                      size: 40,
                      color: Color(0xFF008080),
                    ),
                    SizedBox(width: 40),
                    Text(
                      "Language",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Row(
                  children: <Widget>[
                    SizedBox(width: 40),
                    Icon(
                      Icons.bug_report_outlined,
                      size: 40,
                      color: Color(0xFF008080),
                    ),
                    SizedBox(width: 40),
                    Text(
                      "Report a Bug",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Row(
                  children: <Widget>[
                    SizedBox(width: 40),
                    Icon(
                      Icons.info_outline,
                      size: 40,
                      color: Color(0xFF008080),
                    ),
                    SizedBox(width: 40),
                    Text(
                      "About Us",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50, bottom: 20),
              height: MediaQuery.of(context).size.height * 0.1,
              child: OutlinedButton(
                onPressed: () {
                  signOut(context);
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Row(
                  children: <Widget>[
                    SizedBox(width: 40),
                    Icon(
                      Icons.exit_to_app,
                      size: 40,
                      color: Colors.red,
                    ),
                    SizedBox(width: 40),
                    Text(
                      "Log out",
                      style: TextStyle(fontSize: 20, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}