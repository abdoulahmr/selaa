import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:selaa/register/redirect_login.dart';
import 'package:selaa/register/pre_register.dart';
import 'firebase_options.dart';
//import 'firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseApi firebaseApi = FirebaseApi();
  // await firebaseApi.initNotifications();
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF008080),
        hintColor: const Color(0xFFCCE6E6),
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator()); 
          } else {
            if (snapshot.hasData) {
              return const RedirectLogin();
            } else {
              return const PreRegister();
            }            
          }
        },
      ),
    );
  }
}