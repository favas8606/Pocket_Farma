import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pocket_farma/Screen/AccountPage.dart';
import 'package:pocket_farma/login/login_page.dart';

class Location_locate extends StatefulWidget {
  const Location_locate({Key? key}) : super(key: key);

  @override
  State<Location_locate> createState() => _Location_locateState();
}

class _Location_locateState extends State<Location_locate> {
  bool _isLoading = false;
  var changeState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 38.0),
                    child: Text(
                      "Let's start",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 18.0, bottom: 18),
                    child: Text(
                      "Your Rout",
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w200),
                    ),
                  ),
                  Image.asset(
                    'assets/Rectangle.png',
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                      height: 50,
                      width: 220,
                      child: _isLoading
                          ? LinearPercentIndicator(
                              animation: true,
                              animationDuration: 10000,
                              lineHeight: 10,
                              percent: 1,
                              barRadius: const Radius.circular(20),
                              progressColor:
                                  const Color.fromARGB(255, 158, 45, 168),
                              backgroundColor: Colors.white,
                            )
                          : null),
                  const Text(
                    "Choose your shope for purchase",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 90,
                  ),
                  SizedBox(
                    height: 40,
                    width: 150,
                    child: ElevatedButton(
                        onPressed: () {
                          indicator(context);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35))),
                        child: const Text(
                          "START",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> indicator(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });

    changeState = await Future.delayed(const Duration(seconds: 11));

    newPage();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> newPage() async {
    gotonext(context);
  }

  void gotonext(BuildContext context) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => const Account()));
  }
}
