//import 'dart:html';

import 'package:flutter/material.dart';
//import 'package:flutter_geocoder/geocoder.dart';
import 'package:geocoding/geocoding.dart';

class LatlangToAddressConversion extends StatefulWidget {
  const LatlangToAddressConversion({super.key});

  @override
  State<LatlangToAddressConversion> createState() => _LatlangToAddressConversionState();
}

class _LatlangToAddressConversionState extends State<LatlangToAddressConversion> {
  String stAddress = " ";
  String stAdd = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(stAddress),
          Text(stAdd),
          GestureDetector(
              onTap: () async {
                List<Location> locations =
                    await locationFromAddress("NBC, Balochistan");
                List<Placemark> placemarks = await placemarkFromCoordinates(
                    30.25334433035637, 67.05739285599007);

                setState(() {
                  stAddress = locations.last.longitude.toString() +
                      " " +
                      locations.last.latitude.toString();
                  stAdd = placemarks.reversed.last.country.toString() +
                      " " + placemarks.reversed.last.locality.toString()+" "+
                      placemarks.reversed.last.street.toString();
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Center(
                    child: Text('Convert'),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
