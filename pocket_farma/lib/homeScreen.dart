import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pocket_farma/Location.dart';
import 'package:pocket_farma/account.dart';
import 'package:pocket_farma/homePage.dart';

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

  final pages = const [homePage(), homePage(), Location_locate(), Account()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          print(_currentIndex);
          setState(() => pages[index]);
        },
        children: <Widget>[
          Container(
            child: homePage(),
          ),
          Container(
            child: homePage(),
          ),
          Container(
            child: Location_locate(),
          ),
          Container(
            child: Account(),
          ),
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
              title: const Text('Medical Store'),
              icon: const Icon(Icons.local_pharmacy)),
          BottomNavyBarItem(
              title: const Text('Profile'), icon: const Icon(Icons.person)),
        ],
      ),
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
