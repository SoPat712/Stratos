import 'package:stratos/models/location/location.dart';

class Coords {
  final Locale location;

  Coords({required this.location});

  Coords.fromJson(Map<dynamic, dynamic> parsedJson)
      : location = Locale.fromJson(parsedJson['location']);
}
