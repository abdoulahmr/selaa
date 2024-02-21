import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:selaa/generated/l10n.dart';

void main() async {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate, // Add the AppLocalizationDelegate
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      locale: const Locale('en'),
      theme: ThemeData(
        primaryColor: const Color(0xFF008080),
        hintColor: const Color(0xFFCCE6E6),
      ),
      debugShowCheckedModeBanner: false,
      home: const Test()
    );
  }
}

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text(
            S.of(context).helloWorld,
            style: const TextStyle(
              fontSize: 25,
              fontFamily: 'Montserrat',
            ),
          ),
        ),
      ),
    );
  }
}
