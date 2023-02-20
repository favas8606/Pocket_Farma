// ignore_for_file: avoid_print, file_names

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:pocket_farma/Admin/LocationForAddmin.dart';
import 'package:pocket_farma/Screen/SelectionOfSearchBar.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
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
        children: const <Widget>[
          Selection(),
          AddminLocation(),
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
                title: const Text('Search'),
                icon: const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Icon(Icons.search),
                )),
            BottomNavyBarItem(
                title: const Text('Location'),
                icon: const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(Icons.location_pin),
                )),
          ]),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
