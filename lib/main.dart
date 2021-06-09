import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trip_manager/Content.dart';
import 'SignUp.dart';
import 'SignUp_Email.dart';
import 'LogIn.dart';
import 'Firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Trip_Manager());
}

class Trip_Manager extends StatefulWidget {
  @override
  _Trip_ManagerState createState() => _Trip_ManagerState();
}

class _Trip_ManagerState extends State<Trip_Manager> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => signUp(),
        '/login': (context) => logIn(),
        '/signupe': (context) => SignUpE(),
        '/content': (context) => Content(),
      },
    );
  }
}
