import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceModel {
  final int id;

  final String name;
  final LatLng latLng;

  PlaceModel({
    required this.id,
    required this.name,
    required this.latLng,
  });
}

List<PlaceModel> places = [
  PlaceModel(
    id: 1,
    name: "الروضة",
    latLng: const LatLng(31.056955301332312, 31.380596286778353),
  ),
  PlaceModel(
    id: 2,
    name: "مسجد مسعود",
    latLng: const LatLng(31.056464854934028, 31.375503316332995),
  ),
  PlaceModel(
    id: 3,
    name: "سنتر برافو",
    latLng: const LatLng(31.05504458964481, 31.38026232150325),
  ),
];
