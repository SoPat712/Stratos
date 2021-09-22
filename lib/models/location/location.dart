class Locale {
  final double lat;
  final double lng;

  Locale({required this.lat, required this.lng});

  factory Locale.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Locale(lat: parsedJson['lat'], lng: parsedJson['lng']);
  }
}
