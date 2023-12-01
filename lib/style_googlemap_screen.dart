import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StyleGoogleMapScreen extends StatefulWidget {
  const StyleGoogleMapScreen({Key? key}) : super(key: key);

  @override
  _StyleGoogleMapScreenState createState() => _StyleGoogleMapScreenState();
}

class _StyleGoogleMapScreenState extends State<StyleGoogleMapScreen> {
  String maptheme = '';
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.25310337158103, 67.05745722915624),
    zoom: 15,
  );

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/night_theme.json')
        .then((value) {
      maptheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Style Google Map'),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        _controller.future.then((value) {
                          DefaultAssetBundle.of(context)
                              .loadString('assets/maptheme/silver_theme.json')
                              .then((string) {
                            value.setMapStyle(string);
                          });
                        });
                      },
                      child: Text('Silver'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        _controller.future.then((value) {
                          DefaultAssetBundle.of(context)
                              .loadString('assets/maptheme/retro_theme.json')
                              .then((string) {
                            value.setMapStyle(string);
                          });
                        });
                      },
                      child: Text('Retro'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        _controller.future.then((value) {
                          DefaultAssetBundle.of(context)
                              .loadString('assets/maptheme/night_theme.json')
                              .then((string) {
                            value.setMapStyle(string);
                          });
                        });
                      },
                      child: Text('Night'),
                    )
                  ])
        ],
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            controller.setMapStyle(maptheme);
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
