import 'package:flutter/material.dart';
import 'package:selaa/settings/change_email.dart';
import 'package:selaa/settings/phone_number.dart';
import 'package:selaa/settings/shipping_adress.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFF008080),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChangeEmailPage()),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Email',
                style: TextStyle(
                  fontSize: 20,
                ),
              )
            ),
          ),
          GestureDetector(
            onTap: (){
              print('tapped');
            },
            child: Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Password',
                style: TextStyle(
                  fontSize: 20,
                ),
              )
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => AddPhoneNumberPage())
              );
            },
            child: Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Phone number',
                style: TextStyle(
                  fontSize: 20,
                ),
              )
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ShippingAddressPage()),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Shipping address',
                style: TextStyle(
                  fontSize: 20,
                ),
              )
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.01,
            color: Color.fromARGB(255, 185, 185, 185),
          ),
        ],
      ),
    );
  }
}