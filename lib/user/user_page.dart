import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:selaa/user/add_poste.dart';
import 'package:selaa/user/edit_profile.dart';
import 'package:selaa/user/home.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPage();
}

class _UserPage extends State<UserPage> {
  List<Map<String, dynamic>> userInfo = [];

  Future<void> loadUserInfo() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        userInfo = [snapshot.data()!];
      });
    } else {
      // Handle case when user is null
    }
  }

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFCCE6E6),
              ),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(top: 50, left: 30),
                    child: IconButton(
                      icon: const FaIcon(FontAwesomeIcons.arrowLeft),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
                      },
                    ),
                  ),
                  if (userInfo.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              userInfo[0]['username'] as String,
                              style: const TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: userInfo[0]['profilePicture'] != null
                                ? NetworkImage(userInfo[0]['profilePicture'])
                                : const NetworkImage(
                              'https://firebasestorage.googleapis.com/v0/b/selaa-2ff93.appspot.com/o/profilePicture%2Fkisspng-computer-icons-download-avatar-5b3848b5343f86.741661901530415285214-removebg-preview%20(1).png?alt=media&token=0c01bbf5-f998-4ad9-af94-235ba6fd4ab5',
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (userInfo.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(left: 40,bottom: 20),
                      child: Text(
                        userInfo[0]['bio'],
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  if (userInfo.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(left: 40),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on),
                              const SizedBox(width: 10),
                              Text(
                                userInfo[0]['address'],
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.phone),
                              const SizedBox(width: 10),
                              Text(
                                userInfo[0]['phoneNumber'],
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.alternate_email_outlined),
                              const SizedBox(width: 10),
                              Text(
                                userInfo[0]['email'],
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width*0.8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(
                        Size(
                          MediaQuery.of(context).size.width * 0.35,
                          MediaQuery.of(context).size.height * 0.06,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(const Color(0xFF008080)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: const BorderSide(color: Color(0xFF415B5B)),
                        ),
                      ),
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPoste()));
                    }, 
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        SizedBox(width: 10),
                        Text('Add'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(
                        Size(
                          MediaQuery.of(context).size.width * 0.35,
                          MediaQuery.of(context).size.height * 0.06,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(const Color(0xFF008080)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: const BorderSide(color: Color(0xFF415B5B)),
                        ),
                      ),
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfile()));
                    }, 
                    child: const Row(
                      children: [
                        Icon(Icons.edit_square),
                        SizedBox(width: 10),
                        Text('Edit profile'),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}