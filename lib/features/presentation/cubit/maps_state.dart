import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/entities/place_suggestion.dart';
import '../../domain/entities/route_details.dart';

abstract class MapsState {}

class MapsInitial extends MapsState {}

class LocationLoaded extends MapsState {
  final Set<Marker> markers;
  LocationLoaded(this.markers);
}

class SuggestionsLoaded extends MapsState {
  final List<PlaceSuggestion> suggestions;
  SuggestionsLoaded(this.suggestions);
}

class RouteLoaded extends MapsState {
  final Set<Marker> markers;
  final Set<Polyline> polylines;
  final RouteDetails routeInfo;

  RouteLoaded({
    required this.markers,
    required this.polylines,
    required this.routeInfo,
  });
}

class MapsError extends MapsState {
  final String message;
  MapsError(this.message);
}