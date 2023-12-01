import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class GooglePlacesApiScreen extends StatefulWidget {
  const GooglePlacesApiScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GooglePlacesApiScreenState createState() => _GooglePlacesApiScreenState();
}

class _GooglePlacesApiScreenState extends State<GooglePlacesApiScreen> {
  final TextEditingController _controller = TextEditingController();
  var uuid = const Uuid();
  String _sessionTaken = "1234";
  List<dynamic> placesList = [];

  @override
  void initState() {
    super.initState();
    _controller.addListener(onChange);
  }

  void onChange() {
    getSuggestion(_controller.text);
  }

  void getSuggestion(input) async {
    String kplacesApiKey = 'AIzaSyBMfCifEZF69Z-AKFzRHyfqziegjBoMApo';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    // ignore: prefer_typing_uninitialized_variables
    String request =
        '$baseURL?input=$input&key=$kplacesApiKey&sessiontoken=$_sessionTaken';
    var response = await http.get(Uri.parse(request));

    if (response.statusCode == 200) {
      setState(() {
        placesList = jsonDecode(response.body.toString())['predictions'];
      });
    } else {
      throw Exception('Failed to load suggestions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Google Search Places API',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration:
                  const InputDecoration(hintText: 'Search Places with name'),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: placesList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () async {
                          List<Location> locations = await locationFromAddress(
                              placesList[index]['description']);
                          print(locations.last.longitude);
                          print(locations.last.latitude);
                        },
                        title: Text(placesList[index]['description']),
                        subtitle: Text(placesList[index]['description']),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
