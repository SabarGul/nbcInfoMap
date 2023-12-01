import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.25273757401672, 67.0578753946527),
    zoom: 14,
  );

  List<Marker> marker = [];
  List<Marker> list = const [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(30.253350808162878, 67.06050211637444),
      infoWindow: InfoWindow(title: 'Academic Block'),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(30.252810560905292, 67.05888575859866),
      infoWindow: InfoWindow(title: 'Administration Block'),
    ),
    Marker(
      markerId: MarkerId('3'),
      position: LatLng(30.25299681827944, 67.06254274128082),
      infoWindow: InfoWindow(title: 'NBC Mosque'),
    ),
    Marker(
      markerId: MarkerId('4'),
      position: LatLng(30.2521441892498, 67.06287533519689),
      infoWindow: InfoWindow(title: 'NBC Girls Hostel'),
    ),
    Marker(
      markerId: MarkerId('5'),
      position: LatLng(30.25400698875134, 67.0664802241282),
      infoWindow: InfoWindow(title: 'NBC Boys Hostel'),
    ),
    Marker(
      markerId: MarkerId('6'),
      position: LatLng(30.252509409465116, 67.0666832384508),
      infoWindow: InfoWindow(title: 'Canteen'),
    ),
    Marker(
      markerId: MarkerId('7'),
      position: LatLng(30.252255772822412, 67.06559213009811),
      infoWindow: InfoWindow(title: 'MOQ NBC'),
    ),
    Marker(
      markerId: MarkerId('8'),
      position: LatLng(30.253753958249327, 67.06705741254463),
      infoWindow: InfoWindow(title: 'BOQ NBC'),
    ),
    Marker(
      markerId: MarkerId('9'),
      position: LatLng(30.25303911600451, 67.06434353568714),
      infoWindow: InfoWindow(title: 'Footsal Ground'),
    ),
    Marker(
      markerId: MarkerId('10'),
      position: LatLng(30.253261048979798, 67.06744993908342),
      infoWindow: InfoWindow(title: 'Cricket Ground'),
    ),
    Marker(
      markerId: MarkerId('11'),
      position: LatLng(30.253392453898744, 67.0668353615922),
      infoWindow: InfoWindow(title: 'VolleyBall Ground'),
    ),
    Marker(
      markerId: MarkerId('12'),
      position: LatLng(30.253519196325154, 67.05813037531861),
      infoWindow: InfoWindow(title: 'Parking 1'),
    ),
    Marker(
      markerId: MarkerId('13'),
      position: LatLng(30.253652503404492, 67.06012036353502),
      infoWindow: InfoWindow(title: 'Parking 2'),
    ),
    Marker(
      markerId: MarkerId('14'),
      position: LatLng(30.253748702081708, 67.0627188605371),
      infoWindow: InfoWindow(title: 'NG-Barik'),
    ),
    Marker(
      markerId: MarkerId('15'),
      position: LatLng(30.199778880832195, 67.02557278935674),
      infoWindow: InfoWindow(title: 'Musa-Checkpost'),
    ),
    Marker(
      markerId: MarkerId('16'),
      position: LatLng(30.20298394567078, 67.01595032731896),
      infoWindow: InfoWindow(title: 'Jinnah-Checkpost'),
    ),
    Marker(
      markerId: MarkerId('17'),
      position: LatLng(30.21886089817198, 67.00954338386715),
      infoWindow: InfoWindow(title: 'Askari-Checkpost'),
    ),
    Marker(
      markerId: MarkerId('17'),
      position: LatLng(30.203555204652524, 67.02068520780003),
      infoWindow: InfoWindow(title: 'China-Checkpost'),
    )
  ];

  @override
  void initState() {
    super.initState();
    marker.addAll(list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(marker),
          mapType: MapType.normal,
          myLocationEnabled: true,
          compassEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.location_disabled_outlined),
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(CameraUpdate.newCameraPosition(
            const CameraPosition(
              target: LatLng(30.199778880832195, 67.02557278935674),
              zoom: 14
            )
          ));
          setState((){

          });
        },
      ),
    );
  }
}
