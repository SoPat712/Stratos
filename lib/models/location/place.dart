import 'package:Stratus/models/location/coords.dart';

class Place {
  final Coords geometry;
  final String name;

  Place({required this.geometry, required this.name});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      geometry: Coords.fromJson(json['geometry']),
      name: json['formatted_address'],
    );
  }
}
