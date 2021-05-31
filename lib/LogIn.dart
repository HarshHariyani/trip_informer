import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class logIn extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<logIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome back!',
              style: TextStyle(
                fontSize: 50.0,
                color: Colors.white,
              ),
            ),
            Text(
              'Sign in toyur account',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey,
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              color: Color(0xFF3A3A3C),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        'Email',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(6),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              color: Color(0xFF3A3A3C),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        'Password',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.all(6),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Already have an account?',
                  ),
                  TextSpan(
                      text: 'SignIn',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/signup');
                        })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
