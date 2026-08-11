import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/entities/place_suggestion.dart';
import '../../domain/entities/route_details.dart';
import '../../domain/usecases/get_current_location_usecase.dart';
import '../../domain/usecases/get_place_suggestions_usecase.dart';
import '../../domain/usecases/get_route_usecase.dart';
import 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  final GetCurrentLocationUseCase getCurrentLocationUseCase;
  final GetPlaceSuggestionsUseCase getPlaceSuggestionsUseCase;
  final GetRouteUseCase getRouteUseCase;

  LatLng? currentLocation;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  RouteDetails? routeInfo;

  MapsCubit({
    required this.getCurrentLocationUseCase,
    required this.getPlaceSuggestionsUseCase,
    required this.getRouteUseCase,
  }) : super(MapsInitial());

  Future<void> initLocation(GoogleMapController controller) async {
    try {
      final locationData = await getCurrentLocationUseCase();
      currentLocation = LatLng(locationData.latitude, locationData.longitude);
      
      markers.add(Marker(
        markerId: const MarkerId('current_location'),
        position: currentLocation!,
      ));
      
      controller.animateCamera(CameraUpdate.newLatLngZoom(currentLocation!, 15));
      emit(LocationLoaded(markers));
    } catch (e) {
      emit(MapsError('Failed to get location'));
    }
  }

  Future<void> fetchSuggestions(String text) async {
    if (text.isEmpty) {
      emit(SuggestionsLoaded(const []));
      return;
    }
    try {
      final suggestions = await getPlaceSuggestionsUseCase(text);
      emit(SuggestionsLoaded(suggestions));
    } catch (e) {
      emit(MapsError('Failed to load suggestions'));
    }
  }

  Future<void> drawRouteToPlace(PlaceSuggestion place, GoogleMapController controller) async {
    if (currentLocation == null) return;
    
    LatLng destination = LatLng(place.lat, place.lng);
    markers.clear();
    markers.add(Marker(markerId: const MarkerId('current_location'), position: currentLocation!));
    markers.add(Marker(markerId: MarkerId(place.placeId), position: destination));

    try {
      final route = await getRouteUseCase(currentLocation!, destination);
      
      if (route != null && route.coordinates.isNotEmpty) {
        routeInfo = route;
        List<LatLng> routePoints = route.coordinates.map((p) => LatLng(p.lat, p.lng)).toList();
        
        polylines.clear();
        polylines.add(Polyline(
          polylineId: const PolylineId('my_route'),
          color: Colors.blueAccent,
          width: 5,
          points: routePoints,
        ));

        LatLngBounds bounds = _getLatLngBounds(routePoints);
        controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50.0));

        emit(RouteLoaded(
          markers: markers, 
          polylines: polylines, 
          routeInfo: route,
        ));
      }
    } catch (e) {
      emit(MapsError('Failed to draw route'));
    }
  }

  LatLngBounds _getLatLngBounds(List<LatLng> points) {
    double? x0, x1, y0, y1;
    for (var p in points) {
      if (x0 == null) {
        x0 = x1 = p.latitude;
        y0 = y1 = p.longitude;
      } else {
        if (p.latitude > x1!) x1 = p.latitude;
        if (p.latitude < x0) x0 = p.latitude;
        if (p.longitude > y1!) y1 = p.longitude;
        if (p.longitude < y0!) y0 = p.longitude;
      }
    }
    return LatLngBounds(northeast: LatLng(x1!, y1!), southwest: LatLng(x0!, y0!));
  }
}