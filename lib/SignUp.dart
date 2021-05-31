import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class signUp extends StatefulWidget {
  @override
  _signUpState createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image(
                  height: 500,
                  width: 200,
                  image: AssetImage('images/Logo.png'),
                ),
              ),
              Container(
                width: 300.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {},
                  child: Text('signup with email'),
                ),
              ),
              Container(
                width: 300.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image(
                          image: AssetImage('images/google.png'),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Center(
                          child: Text(
                            'SignUp with Gmail',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                            Navigator.pushNamed(context, '/login');
                          })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
