import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTest extends StatefulWidget {
  const MapTest({super.key});

  @override
  State<MapTest> createState() => _MapTestState();
}

class _MapTestState extends State<MapTest> {

  final Completer<GoogleMapController> _controller = Completer();
  CameraPosition? _kGooglePlex;  // Make it nullable
  final List<Marker> _markers = <Marker>[];
  bool _isLoading = true;  // Indicator for initial loading

  final List<LatLng> nearbyLocations = [
    LatLng(20.351209961331747, 85.80523727902101),
    LatLng(20.351204657971792, 85.80541721429958),
    LatLng(20.351224777247033, 85.80514631131578),
    LatLng(20.351199625736996, 85.80586246152117),
    LatLng(20.35121471106321, 85.8062567478905),
    LatLng(20.3512095674121, 85.80625114946758),
    LatLng(20.35120956401728, 85.80648760998223),
    LatLng(20.35186727191281, 85.80640879989505),
    LatLng(20.350928894644387, 85.80532729332728)
  ];

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace){
      print("error"+error.toString());
    });

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  Future<void> _initializeMap() async {
    Position currentPosition = await getUserCurrentLocation();

    _kGooglePlex = CameraPosition(
      target: LatLng(currentPosition.latitude, currentPosition.longitude),
      zoom: 18,
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

    // Add markers for nearby locations (red color) within 100 meters
    for (LatLng location in nearbyLocations) {
      double distance = Geolocator.distanceBetween(
        currentPosition.latitude, currentPosition.longitude,
        location.latitude, location.longitude,
      );

      if (distance <= 100) {
        _markers.add(
          Marker(
            markerId: MarkerId(location.toString()),
            position: location,
            infoWindow: InfoWindow(
              title: 'Nearby Receivers',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        );
      }
    }

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex!));

    // Set isLoading to false to hide the CircularProgressIndicator
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex ?? CameraPosition(target: LatLng(0, 0), zoom: 1),
            markers: Set<Marker>.of(_markers),
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
            },
          ),
          // Show CircularProgressIndicator only during initial loading
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
