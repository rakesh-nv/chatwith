import 'package:chatwith/pages/login_page.dart';
import 'package:chatwith/pages/registration_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chat with',
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Color.fromARGB(42, 117, 188, 1),
          hintColor: Color.fromARGB(42, 117, 188, 1),
          scaffoldBackgroundColor: Color.fromARGB(28, 27, 27, 1)),
      // home: const LoginPage(),
      home: RegistrationPage(),
    );
  }
}
