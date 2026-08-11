import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../entities/place_suggestion.dart';
import '../entities/route_details.dart';

abstract class MapsRepository {
  Future<List<PlaceSuggestion>> getPlaceSuggestions(String input);
  Future<RouteDetails?> getRoute(LatLng start, LatLng end);
  Future<LocationData> getCurrentLocation();
}