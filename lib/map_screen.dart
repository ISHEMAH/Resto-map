// map_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  List<LatLng> restaurantCoordinates = [
    LatLng(37.7749, -122.4194), // Example restaurant coordinates
    // Add more restaurant coordinates here
  ];
  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    PermissionStatus status = await Permission.locationWhenInUse.status;
    if (!status.isGranted) {
      status = await Permission.locationWhenInUse.request();
    }
    if (status.isGranted) {
      _getCurrentLocation();
    } else {
      print('Location permission denied');
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Locator'),
      ),
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              onMapCreated: (controller) {
                setState(() {
                  mapController = controller;
                });
              },
              initialCameraPosition: CameraPosition(
                target: _currentPosition!,
                zoom: 12.0,
              ),
              markers: restaurantCoordinates.map((latLng) {
                return Marker(
                  markerId: MarkerId(latLng.toString()),
                  position: latLng,
                  infoWindow: InfoWindow(title: 'Restaurant'),
                );
              }).toSet(),
              myLocationEnabled: true,
            ),
    );
  }
}
