import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trip_manager/Content.dart';
import 'package:trip_manager/TPlaces.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:trip_manager/pages/Wishlist.dart';

WishList wp = new WishList();

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<Tplaces> placeList = [];
  Uint8List altImg = Uint8List.fromList(<int>[]);
  final rnd = Random();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseReference postref =
        FirebaseDatabase.instance.reference().child('selection1');
    postref.once().then((DataSnapshot snap) {
      int key = 0;
      var data = snap.value;
      for (var ikey = key; ikey < 100; ikey++) {
        Tplaces place = new Tplaces(
            data[ikey]['name'], data[ikey]['image_url'], data[ikey]['info']);
        placeList.add(place);
      }
      setState(() {
        print(placeList.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      StaggeredGridView.countBuilder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: placeList.length,
        primary: false,
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.white,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SecondPage(
                          placeList[index].name.toString().trim(),
                          placeList[index].image_url,
                          placeList[index].info)),
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image(
                    image: NetworkImage(placeList[index].image_url),
                    fit: BoxFit.fill,
                  ),
                  ListTile(
                    title: Text(
                      placeList[index].name.toString(),
                      style: GoogleFonts.robotoMono(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        staggeredTileBuilder: (index) => const StaggeredTile.fit(2),
      )
    ]);
  }

  void printN(String names) {
    print(names);
  }
}

class SecondPage extends StatelessWidget {
  late String pName, pUrl, pInfo;
  double height = 1000;
  double width = double.infinity;
  SecondPage(String name, String url, String info) {
    pName = name;
    pUrl = url;
    pInfo = info;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Content()),
            );
          },
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  image: new DecorationImage(image: NetworkImage(pUrl)),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 5.0,
                    ),
                  ]),
              child: Image(
                colorBlendMode: BlendMode.dstATop,
                color: Colors.black.withOpacity(0.1),
                image: NetworkImage(pUrl),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5.0,
                    ),
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pName,
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Description : ',
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      pInfo,
                      style: GoogleFonts.roboto(
                          color: Colors.black, fontSize: 15.0),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      fl.addNames(pName);
                    },
                    child: Text('Add to Favorit'),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
