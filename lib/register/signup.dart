import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaa/register/login.dart';
import 'package:selaa/register/pre_register.dart';
import '../functions.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  final TextEditingController _email = TextEditingController();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();

  void checkInputs(context) {
    if (_email.text.isEmpty) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Email is empty!',
      );
    } else if (_firstname.text.isEmpty) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'First name is empty!',
      );
    } else if(_lastname.text.isEmpty){
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Last name is empty!',
      );
    } 
    else if (_password.text != _confirmPassword.text) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Passwords do not match!',
      );
    } else {
      registerWithEmailPassword(
        email: _email.text,
        password: _password.text,
        firstname: _firstname.text,
        lastname: _lastname.text,
        type: "seller",
        context: context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
            return false;
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(top: 50, left: 30),
                  child: IconButton(
                    icon: const FaIcon(FontAwesomeIcons.arrowLeft),
                    onPressed: () {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => const PreRegister()));
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 35, left: 30, right: 30),
                  child: const Text(
                    "Hello Seller ! Register to get started",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF415B5B)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: TextFormField(
                    controller: _firstname,
                    decoration: InputDecoration(
                      labelText: 'First Name',
                      labelStyle: const TextStyle(
                        color: Color(0xFF415B5B),
                      ),  
                      hintText: 'seller1',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF415B5B)))),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 30, right: 30),
                  child: TextFormField(
                    controller: _lastname,
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                      labelStyle: const TextStyle(
                        color: Color(0xFF415B5B),
                      ),  
                      hintText: 'seller1',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF415B5B)))),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 30, right: 30),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _email,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: const TextStyle(
                        color: Color(0xFF415B5B),
                      ),  
                      hintText: 'ex : selaa@examle.org',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF415B5B)))),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 30, right: 30),
                  child: TextFormField(
                    controller: _password,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                        color: Color(0xFF415B5B),
                      ),  
                      hintText: '********',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF415B5B)))),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 30, right: 30),
                  child: TextFormField(
                    controller: _confirmPassword,
                    decoration: InputDecoration(
                      labelText: 'Confirm password',
                      labelStyle: const TextStyle(
                        color: Color(0xFF415B5B),
                      ),  
                      hintText: '********',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF415B5B)))),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                ElevatedButton(
                  onPressed: () {
                    checkInputs(context);
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(
                      Size(MediaQuery.of(context).size.width*0.85, MediaQuery.of(context).size.height*0.06),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF008080)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: const BorderSide(color: Color(0xFF415B5B)),
                      ),
                    ),
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 1,
                      color: Colors.black,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "or Register with",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 1,
                      color: Colors.black,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        icon: const FaIcon(FontAwesomeIcons.facebookF),
                        onPressed: () {},
                        color: Colors.blue,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        icon: const FaIcon(FontAwesomeIcons.google),
                        onPressed: () {},
                        color: Colors.red,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        icon: const FaIcon(FontAwesomeIcons.apple),
                        onPressed: () {},
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: const Text(
                        " Login Now",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF008080),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
