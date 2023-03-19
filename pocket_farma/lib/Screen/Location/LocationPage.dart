// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables, file_names, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pocket_farma/Screen/Location/Map.dart';
import 'package:pocket_farma/Screen/homePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Location_locate extends StatefulWidget {
  const Location_locate({Key? key}) : super(key: key);

  @override
  State<Location_locate> createState() => _Location_locateState();
}

class _Location_locateState extends State<Location_locate> {
  bool _isLoading = false;
  var changeState;
  String locationMessage = '';
  late double lat;
  late double long;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: ((context) => const homePage())));
            }),
      ),
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
                      "Your Route",
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
                        onPressed: () async {
                          _getCurrentLocation().then((value) async {
                            setState(() {
                              lat = value.latitude;
                              long = value.longitude;
                            });
                            SharedPreferences latitudeValue =
                                await SharedPreferences.getInstance();
                            await latitudeValue.setDouble('valuelat', lat);
                            SharedPreferences longtitudeValue =
                                await SharedPreferences.getInstance();
                            await longtitudeValue.setDouble('valuelong', long);
                          });
                          _liveLocation();
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
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MyMap()));
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location service desabled');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location service desabled');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location Service Denied forever');
    }
    return await Geolocator.getCurrentPosition();
  }

  void _liveLocation() async {
    LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Position position) {
      lat = position.latitude;
      long = position.longitude;
    });
  }
}
