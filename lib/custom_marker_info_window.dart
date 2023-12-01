import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({Key? key}) : super(key: key);

  @override
  _CustomMarkerInfoWindowState createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {
  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latLang = [
    LatLng(30.25334395406838, 67.05743574947304), //NBC Ground
    LatLng(30.252948413786964, 67.06280797721003), //Girls Hostel
    LatLng(30.255098489973058, 67.06636995078911), //Boys Hostel
    LatLng(30.2530400635908, 67.06253180742979), //Mosque
    LatLng(30.253196335110534, 67.0605171381935) //Admin Block
  ];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    for (int i = 0; i < _latLang.length; i++) {
      if (i % 2 != 0) {
        _markers.add(
          Marker(
            markerId: MarkerId(i.toString()),
            icon: BitmapDescriptor.defaultMarker,
            position: _latLang[i],
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 300,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://lh5.googleusercontent.com/p/AF1QipMXpQitP6RDN2ELy17qVB-I-nxd7Ue24CS84SC9=w426-h240-k-no'),
                            fit: BoxFit.fitWidth,
                            filterQuality: FilterQuality.high,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: Colors.blue,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: Text(
                                'NBC',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                            ),
                            Spacer(),
                            Text(
                              'nbcInfo',
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _latLang[i],
              );
            },
          ),
        );
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Info Window"),
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(33.6941, 72.9734),
              zoom: 15,
            ),
            markers: Set<Marker>.from(_markers),
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
            onMapCreated: (GoogleMapController controller) {
              _customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 200,
            width: 200,
            offset: 35,
          )
        ],
      ),
    );
  }
}
