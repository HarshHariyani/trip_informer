import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Firebase.dart';

String email = '';
String password = '';

FirebaseL fl = FirebaseL();

class SignUpE extends StatefulWidget {
  @override
  _SignUpEState createState() => _SignUpEState();
}

class _SignUpEState extends State<SignUpE> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              padding: EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                color: Color(0xFF3A3A3C),
                borderRadius: BorderRadius.all(
                  Radius.circular(2),
                ),
              ),
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
                        onChanged: (text) {
                          email = text;
                        },
                        cursorWidth: 1.0,
                        decoration: InputDecoration(
                          border: InputBorder.none,
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
              padding: EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                color: Color(0xFF3A3A3C),
                borderRadius: BorderRadius.all(
                  Radius.circular(2),
                ),
              ),
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
                        onChanged: (text) {
                          password = text;
                        },
                        cursorWidth: 1.0,
                        decoration: InputDecoration(
                          border: InputBorder.none,
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () {
                  fl.signUpf(email, password);
                  Navigator.pushNamed(context, '/content');
                },
                child: Text('SignUp'),
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Already have an account?',
                  ),
                  TextSpan(
                      style: TextStyle(decoration: TextDecoration.underline),
                      text: ' SignIn',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/login');
                        })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
