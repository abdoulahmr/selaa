// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:selaa/register/redirect_login.dart';
import 'package:selaa/register/pre_register.dart';
import 'firebase_options.dart';
import 'package:selaa/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MainState? state = context.findAncestorStateOfType<_MainState>();
    state?.setLocale(newLocale);
  }

}

class _MainState extends State<Main> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const[
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      locale: _locale,
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
