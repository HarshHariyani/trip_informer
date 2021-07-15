import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'Firebase_U.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class logIn extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

FirebaseL fl = FirebaseL();

class _loginState extends State<logIn> {
  String _email = '';
  String _password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back!',
                    style: TextStyle(
                      fontSize: 50.0,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Sign in to your account',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.grey,
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
                        'Email',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Center(
                      child: TextField(
                        onChanged: (text) {
                          _email = text;
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
                        obscureText: true,
                        onChanged: (text) {
                          _password = text;
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
                  fl.signInf(_email, _password).then((value) => {
                        if (value == true)
                          {
                            Navigator.pushNamed(context, '/content'),
                          }
                      });
                },
                child: Text('SignIn'),
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Dont\'t have an account? ',
                  ),
                  TextSpan(
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                      text: 'SignUp',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/signupe');
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
