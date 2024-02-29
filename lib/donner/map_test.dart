import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Services/shared_preference.dart';
import '../config.dart';

class MapTest extends StatefulWidget {
  const MapTest({Key? key}) : super(key: key);

  @override
  State<MapTest> createState() => _MapTestState();
}

class _MapTestState extends State<MapTest> {
  final Completer<GoogleMapController> _controller = Completer();
  CameraPosition? _kGooglePlex; // Make it nullable
  final List<Marker> _markers = <Marker>[];
  bool _isLoading = true; // Indicator for initial loading

  final String apiEndpoint = '${Config.fetchDisriLocUrl}';

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    await _getUserCurrentLocation();

    await _fetchAndSetMarkers();

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex!));

    // Set isLoading to false to hide the CircularProgressIndicator
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {}).onError((error, stackTrace) {
      print("error" + error.toString());
    });

    Position currentPosition = await Geolocator.getCurrentPosition();

    _kGooglePlex = CameraPosition(
      target: LatLng(currentPosition.latitude, currentPosition.longitude),
      zoom: 16,
    );

    // Add marker for current location (blue color)
    _markers.add(
      Marker(
        markerId: MarkerId('current_location'),
        position: LatLng(currentPosition.latitude, currentPosition.longitude),
        infoWindow: InfoWindow(
          title: 'Your Location',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      ),
    );
  }

  Future<void> _fetchAndSetMarkers() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final Position currentPosition = await Geolocator.getCurrentPosition();

      final http.Response response = await http.get(Uri.parse(apiEndpoint));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<String> nearbyUids = [];
        print("Response body: " + " " + '$data');
        for (dynamic locationData in data) {
          try {
            final String uid = locationData['uid'];
            final List<String> coordinates = List<String>.from(locationData['location']);

            final double latitude = double.parse(coordinates[0]);
            final double longitude = double.parse(coordinates[1]);

            final double distance = Geolocator.distanceBetween(
              currentPosition.latitude,
              currentPosition.longitude,
              latitude,
              longitude,
            );

            if (distance <= 500) {
              // Add markers for nearby locations (red color) within 100 meters
              print(LatLng(latitude, longitude));

              _markers.add(
                Marker(
                  markerId: MarkerId(uid),
                  position: LatLng(latitude, longitude),
                  infoWindow: InfoWindow(
                    title: locationData['name'],
                  ),
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                ),
              );

              // Store UID in SharedPreferences for future use
              nearbyUids.add(uid);

            }
          } catch (e) {
            // Handle individual location data parsing error
            print('Error parsing location data: $e');
          }
        }

        print(nearbyUids);
        // Save the list of nearby UIDs to SharedPreferences
        await SharedPreferenceService.saveNearbyUidsToLocalStorage(nearbyUids);
      } else {
        // Handle API response status code other than 200
        print('API request failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle general exception during API request
      print('Error fetching and setting markers: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            initialCameraPosition: _kGooglePlex ?? CameraPosition(target: LatLng(0, 0), zoom: 1),
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}