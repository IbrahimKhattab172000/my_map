import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';
import 'package:my_map/models/place.dart';
import 'dart:ui' as ui;

class CustomGoogleMaps extends StatefulWidget {
  const CustomGoogleMaps({super.key});

  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;
  Set<Marker> markers = {};
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(31.056458878848574, 31.366789128616503),
      zoom: 12,
    );
    initMarkers();

    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          markers: markers,
          onMapCreated: (controller) {
            googleMapController = controller;
          },
          // cameraTargetBounds: CameraTargetBounds(
          //   LatLngBounds(
          //     northeast: const LatLng(
          //       31.07069947545022,
          //       31.416483936139535,
          //     ),
          //     southwest: const LatLng(
          //       31.041509104013798,
          //       31.350029688362447,
          //     ),
          //   ),
          // ),
          initialCameraPosition: initialCameraPosition,
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: ElevatedButton(
            onPressed: () {
              googleMapController.animateCamera(
                CameraUpdate.newLatLng(
                  const LatLng(30.981564914269867, 31.277443854740934),
                ),
              );
              initMapStyle();
            },
            child: const Text("Change location"),
          ),
        ),
      ],
    );
  }

  initMapStyle() async {
    var nightMapStyle = await DefaultAssetBundle.of(context)
        .loadString("assets/map_styles/night_map_style.json");
    googleMapController.setMapStyle(nightMapStyle);
  }

//Low level resizing of the image
  Future<Uint8List> getImageFromRawData(String image, double width) async {
    var imageData = await rootBundle.load(image);
    var imageCodec = await ui.instantiateImageCodec(
      imageData.buffer.asUint8List(),
      targetWidth: width.round(),
    );

    var imageFrame = await imageCodec.getNextFrame();
    var imageByteData =
        await imageFrame.image.toByteData(format: ui.ImageByteFormat.png);

    return imageByteData!.buffer.asUint8List();
  }

  initMarkers() async {
    var customMarkerIcon = BitmapDescriptor.fromBytes(
      await getImageFromRawData("assets/images/marker.png", 100),
    );
    var myMarkers = places
        .map(
          (placeModel) => Marker(
            icon: customMarkerIcon,
            infoWindow: InfoWindow(title: placeModel.name),
            markerId: MarkerId(
              placeModel.id.toString(),
            ),
            position: placeModel.latLng,
          ),
        )
        .toSet();
    markers.addAll(myMarkers);
    setState(() {});
  }
}
