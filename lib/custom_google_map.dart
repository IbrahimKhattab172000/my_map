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
  Set<Polyline> ployLines = {};
  Set<Polygon> polyGons = {};
  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(31.056458878848574, 31.366789128616503),
      zoom: 12,
    );
    initMarkers();
    initPolyLines();
    initPolyGons();
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
          polylines: ployLines,
          polygons: polyGons,
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

  initPolyLines() {
    Polyline polyline1 = const Polyline(
      polylineId: PolylineId("1"),
      color: Colors.amber,
      width: 5,
      zIndex: 2,
      patterns: [PatternItem.dot],
      points: [
        LatLng(31.04506121974146, 31.35460634427776),
        LatLng(31.052157224531594, 31.394646359163083),
        LatLng(31.030523736982012, 31.3942216412643),
      ],
    );

    Polyline polyline2 = const Polyline(
      polylineId: PolylineId("2"),
      color: Colors.blueAccent,
      width: 5,
      zIndex: 1,
      geodesic: true,
      points: [
        LatLng(-33.199629726158605, 20.038522154253734),
        LatLng(83.31147980000767, 45.17524089046863),
      ],
    );

    ployLines.add(polyline1);
    ployLines.add(polyline2);
  }

  initPolyGons() {
    Polygon polygon1 = Polygon(
      polygonId: const PolygonId("1"),
      strokeWidth: 1,
      fillColor: Colors.cyanAccent.withOpacity(0.5),
      holes: const [
        [
          LatLng(31.045520932437462, 31.3525218669107),
          LatLng(31.042584131946622, 31.351173242374717),
          LatLng(31.03641919180087, 31.358795581224502),
          LatLng(31.044947278420054, 31.36486472729747),
        ]
      ],
      points: const [
        LatLng(31.06782373598536, 31.39156897001851),
        LatLng(31.059713621319204, 31.41293236419534),
        LatLng(31.011870680081206, 31.384285994730945),
        LatLng(31.030594693676214, 31.354911327737806),
        LatLng(31.057218062306905, 31.348356649979007),
      ],
    );
    polyGons.add(polygon1);
  }
}
