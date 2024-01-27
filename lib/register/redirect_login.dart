import 'package:flutter/material.dart';
import 'package:selaa/buyer/home_buyer.dart';
import 'package:selaa/seller/home.dart';
import 'package:selaa/functions.dart';

class RedirectLogin extends StatefulWidget {
  const RedirectLogin({Key? key}) : super(key: key);

  @override
  State<RedirectLogin> createState() => _PreLoginState();
}

class _PreLoginState extends State<RedirectLogin> {
  String userType = "none";

  @override
  void initState() {
    super.initState();
    getAccountType().then((String? data) {
      if (data != null) {
        setState(() {
          userType = data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: userType == "buyer"
          ? const HomeBuyer()
          : userType == "seller"
              ? const HomeSeller() // Use the appropriate seller home screen
              : const RedirectLogin(),
    );
  }
}
