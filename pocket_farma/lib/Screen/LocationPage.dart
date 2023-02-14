// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, file_names

import 'dart:async';
import 'package:flutter/material.dart';

import 'package:percent_indicator/percent_indicator.dart';
import 'package:pocket_farma/Screen/NearByLocation/LocationOfMedicaalstore.dart';
// import 'package:geolocator/geolocator.dart';

class Location_locate extends StatefulWidget {
  const Location_locate({Key? key}) : super(key: key);

  @override
  State<Location_locate> createState() => _Location_locateState();
}

class _Location_locateState extends State<Location_locate> {
  bool _isLoading = false;
  var changeState;
  String locationMessage = '';
  late String lat;
  late String long;
  @override
  void initState() {
    // fetchCurrentLocation().then((value) {
    //   lat = '${value.latitude}';
    //   long = '${value.longitude}';
    //   setState(() {
    //     locationMessage = 'Latitude:$lat , Longitude: $long';
    //   });
    // });
    super.initState();
  }

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
                              animationDuration: 5900,
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
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 15,
                    child: Text(locationMessage),
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

    changeState = await Future.delayed(const Duration(seconds: 6));

    newPage();
    setState(() {
      _isLoading = false;
    });
    // liveLocation();
  }

  Future<void> newPage() async {
    gotonext(context);
  }

  void gotonext(BuildContext context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const LocationState()));
  }

  // Future<Position> fetchCurrentLocation() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   LocationPermission permission;
  //   if (!serviceEnabled) {
  //     return Future.error('Location service desabled');
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are denied permanently,we cannot request for permission ');
  //   }
  //   return await Geolocator.getCurrentPosition();
  // }

  // void liveLocation() async {
  //   LocationSettings locationSettings = const LocationSettings(
  //     accuracy: LocationAccuracy.high,
  //     distanceFilter: 100,
  //   );
  //   Geolocator.getPositionStream(locationSettings: locationSettings)
  //       .listen((Position position) {
  //     lat = position.latitude.toString();
  //     long = position.longitude.toString();
  //     setState(() {
  //       locationMessage = 'Latitude:$lat , Longitude: $long';
  //     });
  //   });
  // }
}
