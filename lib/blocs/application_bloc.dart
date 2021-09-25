import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:Stratus/models/location/coords.dart';
import 'package:Stratus/models/location/location.dart';
import 'package:Stratus/models/location/place.dart';
import 'package:Stratus/models/location/place_search.dart';
import 'package:Stratus/services/geolocator_service.dart';
import 'package:Stratus/services/places_service.dart';

class ApplicationBloc with ChangeNotifier {
  ApplicationBloc() {
    setCurrentLocation();
  }

  String cityName = "";
  //Variables
  Position? currentLocation;

  int day = 0;
  String description = "Default";
  double feelTemp =
      0; //what the temperature feels like (to one dp for accuracy)

  final geoLocatorService = GeolocatorService();
  int high = 0;
  int humidity = 0;
  String icon = "02d";
  int low = 0;
  int night = 0;
  dynamic dataSave;
  final placesService = PlacesService();
  int pressure = 0;
  List<PlaceSearch>? searchResults;
  StreamController<Place>? selectedLocation = StreamController<Place>();
  Place? selectedLocationStatic;
  int temperature =
      0; //actual temperature, celsius for metric, fahrenheit for imperial

  double uvIndex = 0; //the UV index at midday

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    selectedLocationStatic = Place(
      name: "",
      geometry: Coords(
        location: Locale(
            lat: currentLocation!.latitude, lng: currentLocation!.longitude),
      ),
    );
    var sLocation = Place(
      name: "",
      geometry: Coords(
        location: Locale(
            lat: currentLocation!.latitude, lng: currentLocation!.longitude),
      ),
    );
    selectedLocation!.add(sLocation);
    notifyListeners();
    List<Placemark> placemarks = await placemarkFromCoordinates(
        currentLocation!.latitude, currentLocation!.longitude);
    if (placemarks[0].administrativeArea!.isEmpty) {
      cityName = placemarks[0].locality.toString() +
          ", " +
          placemarks[0].country.toString();
    } else if (placemarks[0].locality!.isEmpty) {
      cityName = placemarks[0].country.toString();
    } else if (placemarks[0].administrativeArea!.isEmpty &&
        placemarks[0].locality!.isEmpty) {
      cityName = placemarks[0].country.toString();
    } else {
      cityName = placemarks[0].locality.toString() +
          ", " +
          placemarks[0].administrativeArea.toString();
    }
  }

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }

  setSelectedLocation(String placeId) async {
    var sLocation = await placesService.getPlace(placeId);
    selectedLocation!.add(sLocation);
    selectedLocationStatic = sLocation;
    searchResults!.clear;
    List<Placemark> placemarks = await placemarkFromCoordinates(
        selectedLocationStatic!.geometry.location.lat,
        selectedLocationStatic!.geometry.location.lng);
    if (placemarks[0].administrativeArea!.isEmpty) {
      cityName = placemarks[0].locality.toString() +
          ", " +
          placemarks[0].country.toString();
    } else if (placemarks[0].locality!.isEmpty) {
      cityName = placemarks[0].country.toString();
    } else if (placemarks[0].administrativeArea!.isEmpty &&
        placemarks[0].locality!.isEmpty) {
      cityName = placemarks[0].country.toString();
    } else {
      cityName = placemarks[0].locality.toString() +
          ", " +
          placemarks[0].administrativeArea.toString();
    }
    notifyListeners();
  }
}
