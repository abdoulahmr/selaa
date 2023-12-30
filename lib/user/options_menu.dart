import 'package:flutter/material.dart';
import 'package:selaa/user/home.dart';
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
              height: 100,
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
                      Icons.home,
                      size: 40,
                      color: Color(0xFF4586FF),
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
              margin: const EdgeInsets.only(top: 50),
              height: 100,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Row(
                  children: <Widget>[
                    SizedBox(width: 40),
                    Icon(
                      Icons.account_circle_outlined,
                      size: 40,
                      color: Color(0xFF4586FF),
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
              height: 100,
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
                      color: Color(0xFF4586FF),
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
              height: 100,
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
                      color: Color(0xFF4586FF),
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
              margin: const EdgeInsets.only(top: 50),
              height: 100,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Row(
                  children: <Widget>[
                    SizedBox(width: 40),
                    Icon(
                      Icons.admin_panel_settings_outlined,
                      size: 40,
                      color: Color(0xFF4586FF),
                    ),
                    SizedBox(width: 40),
                    Text(
                      "Privacy Policy",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 100,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Row(
                  children: <Widget>[
                    SizedBox(width: 40),
                    Icon(
                      Icons.article_outlined,
                      size: 40,
                      color: Color(0xFF4586FF),
                    ),
                    SizedBox(width: 40),
                    Text(
                      "Terms & Conditions",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50, bottom: 20),
              height: 100,
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