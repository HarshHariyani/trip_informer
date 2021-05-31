import 'package:flutter/material.dart';
import 'SignUp.dart';

void main() {
  runApp(Trip_Manager());
}

class Trip_Manager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.dark(), initialRoute: '/', routes: {
      '/': (contex) => signUp(),
    });
  }
}
