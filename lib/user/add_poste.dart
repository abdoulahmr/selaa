import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:selaa/user/user_page.dart';

class AddPoste extends StatefulWidget {
  const AddPoste({Key? key}) : super(key: key);

  @override
  State<AddPoste> createState() => _AddPosteState();
}

class _AddPosteState extends State<AddPoste> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.50,
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
                  width: MediaQuery.of(context).size.width * 0.32,
                  child: ElevatedButton(
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const UserPage()));
                    },
                    child: const Text(
                      "Publish",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}