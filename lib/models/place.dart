import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  final int id;

  final String name;
  final LatLng latLng;

  Place({
    required this.id,
    required this.name,
    required this.latLng,
  });
}

List<Place> places = [
  Place(
    id: 1,
    name: "الروضة",
    latLng: const LatLng(31.056955301332312, 31.380596286778353),
  ),
  Place(
    id: 2,
    name: "مسجد مسعود",
    latLng: const LatLng(31.056464854934028, 31.375503316332995),
  ),
  Place(
    id: 3,
    name: "سنتر برافو",
    latLng: const LatLng(31.05504458964481, 31.38026232150325),
  ),
];
