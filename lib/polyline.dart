import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({Key? key}) : super(key: key);

  @override
  _PolylineScreenState createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  Completer<GoogleMapController> _controller =
      new Completer<GoogleMapController>();
  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.25310337158103, 67.05745722915624),
    zoom: 15,
  );

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  List<LatLng> latlng = [
    
    LatLng(30.253350808162878, 67.06050211637444), //Acad Block
    LatLng(30.252810560905292, 67.05888575859866), //Admin Block
    LatLng(30.25299681827944, 67.06254274128082), //Mosque
    LatLng(30.2521441892498, 67.06287533519689), //Girls Hostel
    LatLng(30.252509409465116, 67.0666832384508), //Canteen
    LatLng(30.252255772822412, 67.06559213009811), //MOQ NBC
    LatLng(30.253753958249327, 67.06705741254463), //BOQ NBC
    LatLng(30.25303911600451, 67.06434353568714), //Footsal Ground
    LatLng(30.253261048979798, 67.06744993908342), //Cricket Ground
    LatLng(30.253392453898744, 67.0668353615922), //Volleyball Ground
    LatLng(30.25400698875134, 67.0664802241282), //Boys Hostel
    LatLng(30.253748702081708, 67.0627188605371), //NG-Bariks
    LatLng(30.199778880832195, 67.02557278935674), //drop of position - Mussa Checkpost
    LatLng(30.20298394567078, 67.01595032731896), //Jinnah Checkpost
    LatLng(30.203555204652524, 67.02068520780003), //China Checkpost
    LatLng(30.21886089817198, 67.00954338386715), //Askari Chckpost
  ];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < latlng.length; i++) {
      _markers.add(
        Marker(
            markerId: MarkerId(i.toString()),
            position: latlng[i],
            infoWindow: InfoWindow(
              title: 'NBC Acad-Block',
              snippet: 'NUST',
            )),
      );
    }

    _polyline.add(Polyline(
        polylineId: PolylineId('id-1'),
        visible: true,
        points: latlng,
        color: Colors.red,
        width: 4)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Polyline'),
      ),
      body: GoogleMap(
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          
        },
        myLocationEnabled: true,
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        polylines: _polyline,

      ),
    );
  }
}
