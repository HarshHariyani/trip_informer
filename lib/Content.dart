import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trip_manager/pages/Flights.dart';
import 'package:trip_manager/pages/Explore.dart';
import 'package:trip_manager/pages/Category.dart';
import 'package:trip_manager/pages/Wishlist.dart';
import 'Firebase.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

class Content extends StatefulWidget {
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
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
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController();
    List<Widget> _screen = [
      Explore(),
      Categorys(),
      Flights(),
      WishList(),
    ];
    void _ontap(int selectedIndex) {
      _pageController.jumpToPage(selectedIndex);
    }

    return WillPopScope(
      onWillPop: _popUp,
      child: MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
          appBar: AppBar(
            actions: [
              GestureDetector(
                onTap: () {
                  signout();
                },
                child: Icon(
                  Icons.exit_to_app,
                ),
              )
            ],
            title: Text('Finally'),
          ),
          body: PageView(
            controller: _pageController,
            children: _screen,
          ),
          bottomNavigationBar: ConvexAppBar(
            style: TabStyle.react,
            height: 45.0,
            backgroundColor: Colors.black26,
            activeColor: Colors.white,
            items: [
              TabItem(icon: Icons.explore, title: 'Explore'),
              TabItem(icon: Icons.category, title: 'Category'),
              TabItem(icon: Icons.flight, title: 'Flights'),
              TabItem(icon: Icons.list, title: 'WishList'),
            ],
            onTap: _ontap,
          ),
        ),
      ),
    );
  }
}
