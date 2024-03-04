import 'package:flutter/material.dart';
import 'package:my_map/custom_google_map.dart';

void main() {
  runApp(const GoogleMapsWithFlutter());
}

class GoogleMapsWithFlutter extends StatelessWidget {
  const GoogleMapsWithFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google maps',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CustomGoogleMaps(),
    );
  }
}
