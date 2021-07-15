import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trip_manager/pages/Flights.dart';
import 'package:trip_manager/pages/Explore.dart';
import 'package:trip_manager/pages/Wishlist.dart';
import 'Firebase_U.dart';

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  FirebaseL fl = FirebaseL();
  Future<bool> _popUp() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () => SystemNavigator.pop(),
            child: new Text('Yes'),
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  fl.signout();
                  Navigator.pushNamed(context, '/home');
                });
              },
              child: Text('SignOut'))
        ],
      ),
    ));
  }

  PageController _pageController = PageController();
  List<Widget> _screen = [
    Explore(),
    Flights(),
    WishList(),
  ];
  int _selectedIndex = 0;
  void _ontap(int selectedIndex) {
    setState(() {
      _selectedIndex = selectedIndex;
    });
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _popUp,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _popUp();
                  });
                },
                icon: Icon(Icons.exit_to_app),
              )
            ],
            title: Text('Trip Informer'),
          ),
          body: PageView(
            onPageChanged: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            controller: _pageController,
            children: _screen,
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            onTap: (value) {
              _ontap(value);
            },
            items: [
              BottomNavigationBarItem(
                label: 'Explore',
                icon: Icon(Icons.explore),
              ),
              BottomNavigationBarItem(
                label: 'Flights',
                icon: Icon(Icons.flight),
              ),
              BottomNavigationBarItem(
                label: 'WishList',
                icon: Icon(Icons.list),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
