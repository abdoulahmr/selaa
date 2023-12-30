import 'package:flutter/material.dart';
import 'package:selaa/functions.dart';

class ChangeEmailPage extends StatefulWidget {
  @override
  _ChangeEmailPageState createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  final _currentPasswordController = TextEditingController();
  final _newEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Email'),
        backgroundColor: const Color(0xFF008080),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 50),
            TextField(
              controller: _currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Enter your password',
                labelStyle: const TextStyle(
                  color: Color(0xFF415B5B),
                ),  
                hintText: '********',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0)),
                  focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF415B5B))
                )
              ),
            ),
            SizedBox(height: 30.0),
            TextField(
              controller: _newEmailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Enter new email',
                labelStyle: const TextStyle(
                  color: Color(0xFF415B5B),
                ),  
                hintText: 'selaa@example.org',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0)),
                  focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF415B5B))
                )
              ),
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
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
              onPressed: (){
                updateEmail(
                  _currentPasswordController.text,
                  _newEmailController.text,
                  context
                );
              },
              child: Text('Update Email'),
            ),
          ],
        ),
      ),
    );
  }
}
