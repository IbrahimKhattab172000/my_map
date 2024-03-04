import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';

class CustomGoogleMaps extends StatefulWidget {
  const CustomGoogleMaps({super.key});

  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  late CameraPosition initialCameraPosition;
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(31.056458878848574, 31.366789128616503),
      zoom: 10,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      cameraTargetBounds: CameraTargetBounds(
        LatLngBounds(
          northeast: const LatLng(
            31.07069947545022,
            31.416483936139535,
          ),
          southwest: const LatLng(
            31.041509104013798,
            31.350029688362447,
          ),
        ),
      ),
      initialCameraPosition: initialCameraPosition,
    );
  }
}
