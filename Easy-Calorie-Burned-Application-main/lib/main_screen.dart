import 'package:animations/animations.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';


import 'package:flutter/material.dart';
import 'package:mobile_final/screens/Friend/friends_screen.dart';

import 'package:mobile_final/screens/home_screen.dart';
import 'package:mobile_final/screens/profile_screen.dart';
import 'package:mobile_final/screens/setting_screen.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    
  }


  int pageIndex = 0;
  List<Widget> pageList = <Widget>[
    const HomeScreen(),
    const FriendScreen(),
    const ProfileScreen(),
    const SettingScreen(),
  ];

  void _changeItem(int value) {
    setState(() {
      pageIndex = value;
    });
  }

  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      // body: pageList[pageIndex],
      body: PageTransitionSwitcher(
        transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
            FadeThroughTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        ),
        child: pageList[pageIndex],
      ),
      
      // bottomNavigationBar: BottomNavyBar(
      //   backgroundColor: Colors.black,
      //   selectedIndex: pageIndex,
      //   showElevation: true,
      //   onItemSelected: _changeItem,
      //   items: <BottomNavyBarItem>[
      //     BottomNavyBarItem(
      //       title: Text('Home'),
      //       icon: Icon(Icons.home),
      //       activeColor: Colors.blue.shade800,
      //     ),
      //     BottomNavyBarItem(
      //       title: Text('Friend'),
      //       icon: Icon(Icons.person_add),
      //       activeColor: Colors.blue.shade600,
      //     ),
      //     BottomNavyBarItem(
      //       title: Text('Profile'),
      //       icon: Icon(Icons.person),
      //       activeColor: Colors.blue.shade400,
      //     ),
      //     BottomNavyBarItem(
      //       title: Text('Setting'),
      //       icon: Icon(Icons.settings),
      //       activeColor: Colors.blue.shade200,
      //     ),
      //   ],
      // ),

      bottomNavigationBar: FancyBottomNavigation(
        textColor: Colors.black,
        tabs: [
          TabData(iconData: Icons.home, title: "Home"),
          TabData(iconData: Icons.person_add, title: "Friend"),
          TabData(iconData: Icons.person, title: "Profile"),
          TabData(iconData: Icons.settings, title: "Setting"),
        ],
        onTabChangedListener: _changeItem,
      ),

      // bottomNavigationBar: ConvexAppBar(
      //   items: [
      //     TabItem(icon: Icon(Icons.home), title: "Home"),
      //     TabItem(icon: Icon(Icons.person_add), title: "Friend"),
      //     TabItem(icon: Icon(Icons.person), title: "Profile"),
      //     TabItem(icon: Icon(Icons.settings), title: "Setting"),
      //   ],
        
      //   height: 50,
      //   top: -30,
      //   curveSize: 100,
      //   color: Colors.black,
      //   initialActiveIndex: pageIndex,
      //   onTap: _changeItem,
      //   backgroundColor: Colors.blue[200],
      //   activeColor: Colors.white70,
      // ),



      
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.blue[200],
      //   selectedIconTheme: IconThemeData(color: Colors.white),
      //   selectedItemColor: Colors.white70,
      //   currentIndex: pageIndex,
      //   onTap: (value) {
      //     setState(() {
      //       pageIndex = value;
      //     });
      //   },
      //   type: BottomNavigationBarType.fixed,
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.person_add), label: "Friends"),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.settings), label: "Settings"),
      //   ],
      // ),
    );
  }
}
