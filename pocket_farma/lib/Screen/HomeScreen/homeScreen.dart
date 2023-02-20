// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, file_names

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

import 'package:pocket_farma/Screen/Location/LocationPage.dart';
import 'package:pocket_farma/Screen/AccountPage.dart';
import 'package:pocket_farma/Screen/SelectionOfSearchBar.dart';
import 'package:pocket_farma/Screen/homePage.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          print(_currentIndex);

          setState(() => _currentIndex = index);
        },
        children: <Widget>[
          homePage(),
          Selection(),
          Location_locate(),
          Account(),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() => _currentIndex = index);
            _pageController.jumpToPage(index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                title: const Text('Home'), icon: const Icon(Icons.home)),
            BottomNavyBarItem(
                title: const Text('Search'), icon: const Icon(Icons.search)),
            BottomNavyBarItem(
                title: const Text('Location'),
                icon: const Icon(Icons.location_pin)),
            BottomNavyBarItem(
                title: const Text('Profile'), icon: const Icon(Icons.person)),
          ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}





// signout(BuildContext ctx) {
//   Navigator.of(ctx).pushAndRemoveUntil(
//       MaterialPageRoute(builder: (ctx) => loginPage()), (route) => false);
// }
