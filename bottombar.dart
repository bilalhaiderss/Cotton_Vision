import 'package:cotton_app/home.dart';
import 'package:cotton_app/profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class bottombar extends StatefulWidget {
  static const id = 'bottombar';

  @override
  _bottombarState createState() => _bottombarState();
}

class _bottombarState extends State<bottombar> {
  int _page = 0; // Default page index

  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        backgroundColor: Color(0xffC19A6B),
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.account_circle, size: 30),
        ],
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: Center(child: _page == 0 ? HomePage() : ProfilePage()),
    );
  }
}
