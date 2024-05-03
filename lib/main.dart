// main.dart
import 'package:flutter/material.dart';
import 'package:restaurant_locator/map_screen.dart'; // Import the MapScreen widget

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Locator',
      home: MapScreen(), // Use MapScreen as the home widget
    );
  }
}
