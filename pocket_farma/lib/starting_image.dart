import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:medical_project/login_page.dart';

class starting_Image extends StatefulWidget {
  const starting_Image({Key? key}) : super(key: key);

  @override
  State<starting_Image> createState() => _starting_imageState();
}

class _starting_imageState extends State<starting_Image> {
  @override
  void initState() {
    gotoLogin();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 6, 6),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> gotoLogin() async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => loginPage()));
  }
}
