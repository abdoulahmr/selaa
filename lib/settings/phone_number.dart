import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:selaa/functions.dart';

class AddPhoneNumberPage extends StatefulWidget {
  @override
  _AddPhoneNumberPageState createState() => _AddPhoneNumberPageState();
}

class _AddPhoneNumberPageState extends State<AddPhoneNumberPage> {
  TextEditingController _phoneNumberController = TextEditingController();
  bool isEditing = false;

  @override
  void initState() {
    getUserPhoneNumber().then((value) {
      setState(() {
        _phoneNumberController.text = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Phone Number'),
        backgroundColor: const Color(0xFF008080),
        actions: [
          if (!isEditing)
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  isEditing = true;
                });
              },
            ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Container(
            margin: const EdgeInsets.all(20),
            child: _phoneNumberController.text == ''
                ? Column(
                    children: [
                      const Text(
                        "Add Your Phone Number",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "We just need your phone number to contact you if there is any problem with your order.",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        "Your Phone Number",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "press the edit button to change your phone number.",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      )
                    ],
                )
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: TextField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.phone,
              enabled: isEditing,
              decoration: InputDecoration(
                labelText: "Phone Number",
                labelStyle: const TextStyle(
                  color: Color(0xFF415B5B),
                  fontSize: 16,  // Adjust the font size as needed
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF415B5B)),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Adjust padding
              ),
            ),
          ),
          if (isEditing)
            Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.05,
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
                onPressed: () {
                  if (_phoneNumberController.text.length >= 10) {
                    updateUserPhoneNumber(_phoneNumberController.text, context);
                  } else {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.error,
                      title: 'Error',
                      text: 'Phone number must have at least 10 digits.',
                    );
                  }
                },
                child: Text('Add'),
              ),
            ),
        ],
      ),
    );
  }
}
