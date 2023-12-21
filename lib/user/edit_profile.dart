import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'user_page.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  List<Map<String, dynamic>> userInfo = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        setState(() {
          userInfo = [snapshot.data()!];
          isLoading = false;
        });
      } else {
        // Handle case when user is null
      }
    } catch (error) {
      // Handle error
      print("Error loading user information: $error");
      setState(() {
        isLoading = false;
      });
    }
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
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.32,
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(top: 50, left: 30),
                        child: IconButton(
                          icon: const FaIcon(FontAwesomeIcons.arrowLeft),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const UserPage()));
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 50),
                        child: Row(
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(
                                  Size(
                                    MediaQuery.of(context).size.width * 0.25,
                                    MediaQuery.of(context).size.height * 0.04,
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(const Color(0xFFF4F4F4)),
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
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  color: Color(0xFF001A1A),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(
                                  Size(
                                    MediaQuery.of(context).size.width * 0.25,
                                    MediaQuery.of(context).size.height * 0.04,
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
                              child: const Text(
                                "Save",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 50),
                  isLoading
                      ? const CircularProgressIndicator()
                      : CircleAvatar(
                    radius: 100,
                    backgroundImage: userInfo.isNotEmpty && userInfo[0]['profilePicture'] != null
                        ? NetworkImage(userInfo[0]['profilePicture'])
                        : const NetworkImage(
                      'https://firebasestorage.googleapis.com/v0/b/selaa-2ff93.appspot.com/o/profilePicture%2Fkisspng-computer-icons-download-avatar-5b3848b5343f86.741661901530415285214-removebg-preview%20(1).png?alt=media&token=0c01bbf5-f998-4ad9-af94-235ba6fd4ab5',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(
                        Size(
                          MediaQuery.of(context).size.width * 0.40,
                          MediaQuery.of(context).size.height * 0.04,
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
                    child: const Text(
                      "Change Picture",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 100, left: 30, right: 30),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _username,
                decoration: InputDecoration(
                  labelText: userInfo[0]['username'],
                  labelStyle: const TextStyle(
                    color: Color(0xFF415B5B),
                  ),  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF415B5B)))),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 100, left: 30, right: 30),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _firstname,
                decoration: InputDecoration(
                  labelText: userInfo[0]['firstname'],
                  labelStyle: const TextStyle(
                    color: Color(0xFF415B5B),
                  ),  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF415B5B)))),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 100, left: 30, right: 30),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _lastname,
                decoration: InputDecoration(
                  labelText: userInfo[0]['lastname'],
                  labelStyle: const TextStyle(
                    color: Color(0xFF415B5B),
                  ),  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF415B5B)))),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 100, left: 30, right: 30),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _email,
                decoration: InputDecoration(
                  labelText: userInfo[0]['bio'],
                  labelStyle: const TextStyle(
                    color: Color(0xFF415B5B),
                  ),  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF415B5B)))),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 100, left: 30, right: 30),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _email,
                decoration: InputDecoration(
                  labelText: userInfo[0]['email'],
                  labelStyle: const TextStyle(
                    color: Color(0xFF415B5B),
                  ),  
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF415B5B)))),
              ),
            ),
          ],
        ),
      )
    );
  }
}
