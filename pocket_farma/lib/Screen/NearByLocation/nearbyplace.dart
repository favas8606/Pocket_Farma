// fetch nearest medical shop of current location of user using flutter?
//
//
  


//
//
// <uses-permission android:name="android.permission.FOREGROUND_SERVICE" />
// <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION"/>


//
//
// <key>NSLocationWhenInUseUsageDescription</key>
// <key>NSLocationAlwaysUsageDescription</key>


//
//
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:geocoder/geocoder.dart';
// import 'package:location/location.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Location',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: getLocation(),
//     );
//   }
// }

// class getLocation extends StatefulWidget {
//   @override
//   _MyLocationState createState() => _MyLocationState();
// }

// class _MyLocationState extends State<getLocation> {
//    LocationData _currentPosition;
//   late String _address;
//   Location location = Location();

//   @override
//   void initState() {
//     super.initState();
//     fetchLocation();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Flutter Location"),
//       ),
//       body: Container(
//         child: SafeArea(
//           child: Column(
//             children: [
//               if (_currentPosition)
//                 Text(
//                   "Latitude: ${_currentPosition.latitude}",
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
//                 ),
//               if (_currentPosition)
//                 Text(
//                   "Longitude: ${_currentPosition.longitude}",
//                   style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
//                 ),
//               if (_address)
//                 Text(
//                   "Address: $_address",
//                   style: TextStyle(
//                     fontSize: 16,
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );

//   fetchLocation() async {}
//   Future<List<Address>> getAddress(double lat, double lang) async {}
//   }



// //
// //
// fetchLocation() async {
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;

//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }

//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }

//     _currentPosition = await location.getLocation();
//     location.onLocationChanged.listen((LocationData currentLocation) {
//       setState(() {
//         _currentPosition = currentLocation;
//         getAddress(_currentPosition.latitude, _currentPosition.longitude)
//             .then((value) {
//           setState(() {
//             _address = "${value.first.addressLine}";
//           });
//         });
//       });
//     });
//   }


// //
// //
//   Future<List<Address>> getAddress(double lat, double lang) async {
//     final coordinates = new Coordinates(latitude, longitude);
//     List<Address> address =
//         await Geocoder.local.findAddressesFromCoordinates(coordinates);
//     return address;
//   }
// }


// json code for location medical store in kozhikode in flutter?

