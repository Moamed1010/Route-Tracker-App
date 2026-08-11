import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../entities/route_details.dart';
import '../repos/maps_repository.dart';

class GetRouteUseCase {
  final MapsRepository repository;
  GetRouteUseCase(this.repository);
  
  Future<RouteDetails?> call(LatLng start, LatLng end) async {
    return await repository.getRoute(start, end);
  }
}