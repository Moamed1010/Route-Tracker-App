import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../../domain/entities/place_suggestion.dart';
import '../../domain/entities/route_details.dart';
import '../../domain/repos/maps_repository.dart';
import '../datasources/remote_data_source.dart';
import '../../../utils/location_services.dart';

class MapsRepositoryImpl implements MapsRepository {
  final MapsRemoteDataSource remoteDataSource;
  final LocationServices localDataSource;

  MapsRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<LocationData> getCurrentLocation() async {
    return await localDataSource.getLocation();
  }

  @override
  Future<List<PlaceSuggestion>> getPlaceSuggestions(String input) async {
    return await remoteDataSource.getSuggestions(input);
  }

  @override
  Future<RouteDetails?> getRoute(LatLng start, LatLng end) async {
    return await remoteDataSource.getRoute(start, end);
  }
}