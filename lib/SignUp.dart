import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Firebase_U.dart';

class signUp extends StatefulWidget {
  @override
  _signUpState createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    getCurrentUser().then(
      (value) => {
        if (value == 'content')
          {Navigator.pushNamed(context, '/content')}
        else if (value == 'signup')
          {Navigator.defaultRouteName}
      },
    );
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
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signupe');
                  },
                  child: Text('Signup With Email'),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: Center(
                          child: Text(
                            'Login',
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
            ],
          ),
        ),
      ),
    );
  }
}
