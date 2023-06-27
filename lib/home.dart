import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;

  List<IconData> iconList = [
    Icons.home,
    Icons.favorite,
    Icons.collections,
    Icons.person,
  ];

  //List of the pages titles
  List<String> titleList = [
    'Home',
    'Favorite',
    'My Collection',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Text(
          titleList[_bottomNavIndex],
          style: TextStyle(
            color: Color(0xFF8E44AD),
            fontWeight: FontWeight.w500,
            fontSize: 24,
          ),
        ),
        ],
    ),

      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
          splashColor: Color(0xFF8E44AD),
          activeColor: Colors.white,
          inactiveColor: Colors.black.withOpacity(.5),
          icons: iconList,
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
          onTap: (index) {
            setState(() {
              _bottomNavIndex = index;

            });
          }),
    );
  }
}