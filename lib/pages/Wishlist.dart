import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Content.dart';
import '../Firebase_U.dart';

FirebaseL fl = FirebaseL();
late String names;

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  @override
  Widget build(BuildContext context) {
    List<String> names = fl.getNames();
    return Scaffold(
      body: Column(children: [
        Container(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (_, index) => EachList(names[index]),
            itemCount: names.length,
          ),
        ),
        ElevatedButton(
            onPressed: () {
              fl.clearL();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => Content()));
            },
            child: Text('Clear List'))
      ]),
    );
  }
}

class EachList extends StatefulWidget {
  EachList(String s) {
    names = s;
  }
  @override
  _EachListState createState() => _EachListState();
}

class _EachListState extends State<EachList> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Text(names),
      ),
    );
  }
}
