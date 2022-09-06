import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pocket_farma/account.dart';
import 'package:pocket_farma/login_page.dart';
import 'package:pocket_farma/main.dart';
import 'package:pocket_farma/verification.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  int currentSelectIndex = 0;

  final pages = [verify(), loginPage(), Account()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: IndexedStack(
        children: pages,
        index: currentSelectIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        onTap: (newIndex) {
          setState(() {
            currentSelectIndex = newIndex;
            print(currentSelectIndex);
          });
        },
        currentIndex: currentSelectIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_city), label: 'medical Store'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}





// signout(BuildContext ctx) {
//   Navigator.of(ctx).pushAndRemoveUntil(
//       MaterialPageRoute(builder: (ctx) => loginPage()), (route) => false);
// }