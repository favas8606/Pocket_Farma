// ignore_for_file: file_names, non_constant_identifier_names, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  late GoogleMapController mapController;
  static double latit = 11.276340281109714;
  static double longit = 75.95728400136682;
  static late double latitudeValueForGoogleMap;
  static late double longtitudeValueForGoogleMap;
  final LatLng _center = LatLng(latit, longit);
  final Set<Marker> _markers = {};
  List<Map<String, dynamic>> pharmacyShopInfo = [];
  //direction
  final Set<Polyline> _polylines = <Polyline>{};
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    polylinePoints = PolylinePoints();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            markers: _markers,
            polylines: _polylines,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 13.0,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 50, right: 12),
            alignment: Alignment.bottomRight,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    openToGoogleMap();
                  },
                  backgroundColor: Colors.green,
                  child: const Icon(
                    Icons.map,
                    size: 30.0,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void createPolyLine({required latitude, required longitude}) async {
    polylineCoordinates.clear();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyA2JTRFwnL71i8VqPpA8ElysoNJyfHLDu0',
        PointLatLng(latit, longit),
        PointLatLng(latitude, longitude));
    setState(() {
      latitudeValueForGoogleMap = latitude;
      longtitudeValueForGoogleMap = longitude;
    });

    if (result.status == 'OK') {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));

        setState(() {
          _polylines.add(Polyline(
              width: 10,
              polylineId: const PolylineId('polyLIne'),
              color: const Color.fromARGB(255, 188, 231, 207),
              points: polylineCoordinates));
        });
      }
    }
  }

  Future<void> fetchData() async {
    SharedPreferences latitudeValue = await SharedPreferences.getInstance();
    final double? latvalue = latitudeValue.getDouble('valuelat');
    SharedPreferences longtitudeValue = await SharedPreferences.getInstance();
    final double? longValue = longtitudeValue.getDouble("valuelong");
    print('logtitude value $longValue');
    print('latitude value $latvalue');
    setState(() {
      latit = latvalue!;
      longit = longValue!;
    });
    var url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=pharmacy%near%me&location=$latit,$longit&key=AIzaSyA2JTRFwnL71i8VqPpA8ElysoNJyfHLDu0';
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var pharmacyShopList = jsonResponse['results'];
      var count = 0;
      for (var i in pharmacyShopList) {
        var latLngName = {
          'id': count,
          'lat': i['geometry']['location']['lat'],
          'lng': i['geometry']['location']['lng'],
          'name': i['name']
        };
        pharmacyShopInfo.add(latLngName);
        count++;
      }
      setState(() {
        _markers.add(Marker(
          markerId: const MarkerId('mylocation'),
          position: LatLng(latit, longit),
          infoWindow: const InfoWindow(title: 'My Location'),
        ));
        for (var data in pharmacyShopInfo) {
          _markers.add(Marker(
              markerId: MarkerId(data['id'].toString()),
              position: LatLng(data['lat'], data['lng']),
              infoWindow: InfoWindow(title: data['name']),
              onTap: () => createPolyLine(
                  latitude: data['lat'], longitude: data['lng'])));
        }
        print(_markers);
      });
      setPolylines();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        'AIzaSyA2JTRFwnL71i8VqPpA8ElysoNJyfHLDu0',
        PointLatLng(latit, longit),
        PointLatLng(pharmacyShopInfo[0]['lat'], pharmacyShopInfo[0]['lng']));
    setState(() {
      latitudeValueForGoogleMap = pharmacyShopInfo[0]['lat'];
      longtitudeValueForGoogleMap = pharmacyShopInfo[0]['lng'];
    });

    if (result.status == 'OK') {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));

        setState(() {
          _polylines.add(Polyline(
              width: 10,
              polylineId: const PolylineId('polyLIne'),
              color: Colors.red,
              points: polylineCoordinates));
        });
      }
    }
  }

  void openToGoogleMap() async {
    await launchUrl(Uri.parse(
        'google.navigation:q=$latitudeValueForGoogleMap, $longtitudeValueForGoogleMap&key=AIzaSyA2JTRFwnL71i8VqPpA8ElysoNJyfHLDu0'));
  }
}
