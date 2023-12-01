import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerScreen extends StatefulWidget {
  const CustomMarkerScreen({Key? key}) : super(key: key);

  @override
  _CustomMarkerScreenState createState() => _CustomMarkerScreenState();
}

class _CustomMarkerScreenState extends State<CustomMarkerScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  Uint8List? markerImage;

  List<String> images = [
    'images/car_top.png',
    'images/car.png',
    'images/marker.png',
    'images/marker1.png',
    'images/motorcycle.png'
  ];

  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latLngs = <LatLng>[
    LatLng(30.25334395406838, 67.05743574947304), //NBC Ground
    LatLng(30.252948413786964, 67.06280797721003), //Girls Hostel
    LatLng(30.255098489973058, 67.06636995078911), //Boys Hostel
    LatLng(30.2530400635908, 67.06253180742979), //Mosque
    LatLng(30.253196335110534, 67.0605171381935) //Admin Block
  ];

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.6910, 72.98072),
    zoom: 15,
  );

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load('assets/$path');
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetHeight: width,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    for (int i = 0; i < images.length; i++) {
      final Uint8List markerIcon = await getBytesFromAssets(images[i], 100);
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: _latLngs[i],
          icon: BitmapDescriptor.fromBytes(markerIcon),
          infoWindow: InfoWindow(
            title: 'Marker ${i.toString()}',
          ),
        ),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set.from(_markers),
        ),
      ),
    );
  }
}
