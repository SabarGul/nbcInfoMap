import 'package:flutter/material.dart';
//import 'package:myapp/custom_marker_on_screen.dart';
//import 'package:myapp/polyline.dart';
import 'package:myapp/style_googlemap_screen.dart';
//import 'package:myapp/home_screen.dart';
//import 'package:myapp/latlang_to_address.dart';
//import 'package:myapp/user_current_location.dart';
//import 'package:myapp/google_places_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StyleGoogleMapScreen(),
    );
  }
}
